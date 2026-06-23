import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'fb/fb_firestore.dart';

class B2Object {
  final String key;
  final int size;
  final String lastModified;

  B2Object({
    required this.key,
    required this.size,
    required this.lastModified,
  });

  String get sizeFormatted {
    if (size <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    double dSize = size.toDouble();
    while (dSize >= 1024 && i < suffixes.length - 1) {
      dSize /= 1024;
      i++;
    }
    return '${dSize.toStringAsFixed(1)} ${suffixes[i]}';
  }

  DateTime? get lastModifiedDate {
    try {
      return DateTime.parse(lastModified);
    } catch (_) {
      return null;
    }
  }
}

class B2Credentials {
  final String keyId;
  final String applicationKey;
  final String bucketName;
  final String region;

  B2Credentials({
    required this.keyId,
    required this.applicationKey,
    required this.bucketName,
    required this.region,
  });

  bool get isValid =>
      keyId.isNotEmpty &&
      applicationKey.isNotEmpty &&
      bucketName.isNotEmpty &&
      region.isNotEmpty;
}

class B2Service {
  B2Service._privateConstructor();
  static final B2Service instance = B2Service._privateConstructor();

  // Define placeholders for shared credentials
  static const String defaultKeyId = '00384db7dd2f3390000000001';
  static const String defaultApplicationKey = 'K003EUCIHsnIRRoLkgDu7mXM4mSttW8';
  static const String defaultBucketName = 'duofyug';
  static const String defaultRegion = 'eu-central-003';

  /// Resolves the current credentials to use: checks SharedPreferences first,
  /// falling back to the hardcoded constants.
  Future<B2Credentials> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    
    final keyId = prefs.getString('b2_key_id')?.trim();
    final appKey = prefs.getString('b2_application_key')?.trim();
    final bucket = prefs.getString('b2_bucket_name')?.trim();
    final region = prefs.getString('b2_region')?.trim();

    return B2Credentials(
      keyId: (keyId != null && keyId.isNotEmpty) ? keyId : defaultKeyId,
      applicationKey: (appKey != null && appKey.isNotEmpty) ? appKey : defaultApplicationKey,
      bucketName: (bucket != null && bucket.isNotEmpty) ? bucket : defaultBucketName,
      region: (region != null && region.isNotEmpty) ? region : defaultRegion,
    );
  }

  /// Helper to check if credentials are configured
  Future<bool> isConfigured() async {
    final creds = await getCredentials();
    return creds.isValid &&
        creds.keyId != 'YOUR_KEY_ID' &&
        creds.applicationKey != 'YOUR_APPLICATION_KEY' &&
        creds.bucketName != 'YOUR_BUCKET_NAME';
  }

  /// Lists objects in the bucket (reads from Firestore metadata).
  Future<List<B2Object>> listObjects() async {
    final snap = await FbFirestore.instance.collection('document_store').get();
    final List<B2Object> objects = [];
    
    for (final doc in snap.docs) {
      final data = doc.data();
      if (data == null) continue;
      
      final key = data['key'] as String? ?? '';
      if (key.isEmpty) continue;

      objects.add(B2Object(
        key: key,
        size: data['size'] as int? ?? 0,
        lastModified: data['uploadedAt'] as String? ?? DateTime.now().toUtc().toIso8601String(),
      ));

      // Add a virtual thumbnail object so the UI is aware it exists in B2
      objects.add(B2Object(
        key: '$key.thumb.jpg',
        size: 20 * 1024, // Estimate 20 KB
        lastModified: data['uploadedAt'] as String? ?? DateTime.now().toUtc().toIso8601String(),
      ));
    }
    
    return objects;
  }

  /// Uploads a file split into 1MB chunks to the bucket, utilizing unique ID S3 keys for safety.
  Future<void> uploadObject(
    String filename,
    List<int> bytes, {
    void Function(double progress)? onProgress,
  }) async {
    final isThumb = filename.endsWith('.thumb.jpg');
    final mainFilename = isThumb
        ? filename.substring(0, filename.length - '.thumb.jpg'.length)
        : filename;
        
    final folder = mainFilename.split('/').first; // e.g. reference or syllabus
    final hash = sha256.convert(utf8.encode(mainFilename)).toString();
    final b2Key = isThumb
        ? '$folder/$hash.pdf.thumb.jpg'
        : '$folder/$hash.pdf';

    if (isThumb) {
      // Upload thumbnail directly as a single B2 object (usually ~30KB)
      await _uploadPartDirect(b2Key, bytes);
      return;
    }

    const partSize = 1024 * 1024; // 1 MB
    final List<List<int>> parts = [];

    if (bytes.length <= partSize) {
      // Small file: upload directly as a single part
      parts.add(bytes);
    } else {
      // Large file: split into 1 MB chunks
      for (var i = 0; i < bytes.length; i += partSize) {
        final end = (i + partSize < bytes.length) ? i + partSize : bytes.length;
        parts.add(bytes.sublist(i, end));
      }
    }

    var uploadedBytes = 0;
    final List<Future<void> Function()> uploadTasks = [];
    for (var i = 0; i < parts.length; i++) {
      final index = i;
      final partKey = (parts.length == 1)
          ? b2Key
          : '$b2Key.part_${index.toString().padLeft(3, '0')}';
      
      uploadTasks.add(() async {
        await _uploadPartDirect(partKey, parts[index]);
        uploadedBytes += parts[index].length;
        if (onProgress != null) {
          onProgress(uploadedBytes / bytes.length);
        }
      });
    }

    await _runWithConcurrencyLimit<void>(
      concurrency: 4,
      tasks: uploadTasks,
    );

    final docId = mainFilename.replaceAll('/', '_');
    
    await FbFirestore.instance.collection('document_store').doc(docId).set({
      'name': mainFilename.split('/').last,
      'key': mainFilename, // UI uses original filename for list & local cache
      'size': bytes.length,
      'category': folder,
      'partsCount': parts.length,
      'uploadedAt': DateTime.now().toUtc().toIso8601String(),
    });
  }

  /// Downloads file bytes. If it's a split file, downloads parts and concatenates.
  Future<Uint8List> downloadObject(
    String filename, {
    void Function(double progress)? onProgress,
  }) async {
    final isThumb = filename.endsWith('.thumb.jpg');
    final mainFilename = isThumb
        ? filename.substring(0, filename.length - '.thumb.jpg'.length)
        : filename;
        
    final folder = mainFilename.split('/').first;
    final hash = sha256.convert(utf8.encode(mainFilename)).toString();
    final b2Key = isThumb
        ? '$folder/$hash.pdf.thumb.jpg'
        : '$folder/$hash.pdf';

    if (isThumb) {
      return _downloadPartDirect(b2Key);
    }

    final docId = mainFilename.replaceAll('/', '_');
    final docSnap = await FbFirestore.instance.collection('document_store').doc(docId).get();
    
    int partsCount = 1;
    int totalSize = 0;

    if (docSnap.exists) {
      final data = docSnap.data()!;
      partsCount = data['partsCount'] as int? ?? 1;
      totalSize = data['size'] as int? ?? 0;
    }

    if (partsCount <= 1) {
      // Download single part directly
      final bytes = await _downloadPartDirect(b2Key);
      if (onProgress != null) {
        onProgress(1.0);
      }
      return bytes;
    }

    // Split file: download all parts and combine
    var downloadedBytes = 0;
    final List<Future<Uint8List> Function()> downloadTasks = [];

    for (var i = 0; i < partsCount; i++) {
      final index = i;
      final partKey = '$b2Key.part_${index.toString().padLeft(3, '0')}';
      downloadTasks.add(() async {
        final partBytes = await _downloadPartDirect(partKey);
        downloadedBytes += partBytes.length;
        if (onProgress != null && totalSize > 0) {
          onProgress(downloadedBytes / totalSize);
        }
        return partBytes;
      });
    }

    final List<Uint8List> partsBytes = await _runWithConcurrencyLimit<Uint8List>(
      concurrency: 4,
      tasks: downloadTasks,
    );

    final List<int> combinedBytes = [];
    for (final part in partsBytes) {
      combinedBytes.addAll(part);
    }

    return Uint8List.fromList(combinedBytes);
  }

  /// Deletes all parts of a file from the bucket and deletes Firestore metadata.
  Future<void> deleteObject(String filename) async {
    final isThumb = filename.endsWith('.thumb.jpg');
    final mainFilename = isThumb
        ? filename.substring(0, filename.length - '.thumb.jpg'.length)
        : filename;
        
    final folder = mainFilename.split('/').first;
    final hash = sha256.convert(utf8.encode(mainFilename)).toString();
    final b2Key = isThumb
        ? '$folder/$hash.pdf.thumb.jpg'
        : '$folder/$hash.pdf';

    if (isThumb) {
      await _deletePartDirect(b2Key);
      return;
    }

    final docId = mainFilename.replaceAll('/', '_');
    final docSnap = await FbFirestore.instance.collection('document_store').doc(docId).get();
    
    int partsCount = 1;
    if (docSnap.exists) {
      partsCount = docSnap.data()?['partsCount'] as int? ?? 1;
    }

    if (partsCount <= 1) {
      try {
        await _deletePartDirect(b2Key);
      } catch (e) {
        print('[B2Service] Failed to delete file $b2Key: $e');
      }
    } else {
      final List<Future<void> Function()> deleteTasks = [];
      for (var i = 0; i < partsCount; i++) {
        final index = i;
        final partKey = '$b2Key.part_${index.toString().padLeft(3, '0')}';
        deleteTasks.add(() async {
          try {
            await _deletePartDirect(partKey);
          } catch (e) {
            print('[B2Service] Failed to delete part $partKey: $e');
          }
        });
      }

      await _runWithConcurrencyLimit<void>(
        concurrency: 4,
        tasks: deleteTasks,
      );
    }

    final thumbKey = '$b2Key.thumb.jpg';
    try {
      await _deletePartDirect(thumbKey);
    } catch (_) {}

    if (docSnap.exists) {
      await FbFirestore.instance.collection('document_store').doc(docId).delete();
    }
  }

  /// Runs tasks concurrently with a limit.
  Future<List<T>> _runWithConcurrencyLimit<T>({
    required int concurrency,
    required List<Future<T> Function()> tasks,
  }) async {
    final List<T?> results = List.filled(tasks.length, null);
    int nextTaskIndex = 0;
    Object? firstError;
    StackTrace? firstStackTrace;

    Future<void> runWorker() async {
      while (nextTaskIndex < tasks.length && firstError == null) {
        final currentTaskIndex = nextTaskIndex++;
        try {
          results[currentTaskIndex] = await tasks[currentTaskIndex]();
        } catch (e, st) {
          firstError ??= e;
          firstStackTrace ??= st;
        }
      }
    }

    final List<Future<void>> workers = [];
    for (int i = 0; i < concurrency && i < tasks.length; i++) {
      workers.add(runWorker());
    }

    await Future.wait(workers);

    if (firstError != null) {
      Error.throwWithStackTrace(firstError as Object, firstStackTrace!);
    }

    return results.cast<T>();
  }

  /// Computes the AWS Signature Version 4 for B2 S3 API request signing.
  Map<String, String> _sign({
    required B2Credentials creds,
    required String method,
    required String path,
    required Map<String, String> queryParams,
    required List<int> payloadBytes,
    required DateTime dateTime,
  }) {
    final amzDate = _formatAmzDate(dateTime);
    final dateStamp = _formatDateStamp(dateTime);
    final host = '${creds.bucketName}.s3.${creds.region}.backblazeb2.com';

    // 1. Canonical URI
    final segments = path.split('/').where((s) => s.isNotEmpty).map((s) => Uri.encodeComponent(s)).join('/');
    var canonicalUri = '/$segments';
    if (path.endsWith('/') && !canonicalUri.endsWith('/')) {
      canonicalUri += '/';
    }

    // 2. Canonical Query String
    final sortedKeys = queryParams.keys.toList()..sort();
    final canonicalQueryString = sortedKeys
        .map((k) => '${Uri.encodeComponent(k)}=${Uri.encodeComponent(queryParams[k]!)}')
        .join('&');

    // 3. Payload Hash
    final payloadHash = sha256.convert(payloadBytes).toString();

    // 4. Canonical Headers
    final headersToSign = {
      'host': host,
      'x-amz-content-sha256': payloadHash,
      'x-amz-date': amzDate,
    };

    final sortedHeaderKeys = headersToSign.keys.toList()..sort();
    final canonicalHeaders = sortedHeaderKeys
        .map((k) => '$k:${headersToSign[k]!.trim()}\n')
        .join('');

    // 5. Signed Headers
    final signedHeaders = sortedHeaderKeys.join(';');

    // 6. Canonical Request
    final canonicalRequest = [
      method.toUpperCase(),
      canonicalUri,
      canonicalQueryString,
      canonicalHeaders,
      signedHeaders,
      payloadHash,
    ].join('\n');

    final hashedCanonicalRequest = sha256.convert(utf8.encode(canonicalRequest)).toString();

    // 7. String to Sign
    final credentialScope = '$dateStamp/${creds.region}/s3/aws4_request';
    final stringToSign = [
      'AWS4-HMAC-SHA256',
      amzDate,
      credentialScope,
      hashedCanonicalRequest,
    ].join('\n');

    // 8. Calculate Signing Key
    final kDate = _hmacSha256(utf8.encode('AWS4${creds.applicationKey}'), dateStamp);
    final kRegion = _hmacSha256(kDate, creds.region);
    final kService = _hmacSha256(kRegion, 's3');
    final kSigning = _hmacSha256(kService, 'aws4_request');

    // 9. Calculate Signature
    final signature = _hmacSha256Hex(kSigning, stringToSign);

    // 10. Build Authorization Header
    final authorization = 'AWS4-HMAC-SHA256 Credential=${creds.keyId}/$credentialScope, SignedHeaders=$signedHeaders, Signature=$signature';

    return {
      'Authorization': authorization,
      'x-amz-content-sha256': payloadHash,
      'x-amz-date': amzDate,
      'host': host,
    };
  }

  List<int> _hmacSha256(List<int> key, String data) {
    final hmac = Hmac(sha256, key);
    return hmac.convert(utf8.encode(data)).bytes;
  }

  String _hmacSha256Hex(List<int> key, String data) {
    final hmac = Hmac(sha256, key);
    return hmac.convert(utf8.encode(data)).toString();
  }

  String _formatAmzDate(DateTime dt) {
    final iso = dt.toIso8601String()
        .replaceAll('-', '')
        .replaceAll(':', '')
        .split('.')
        .first;
    return '${iso}Z';
  }

  String _formatDateStamp(DateTime dt) {
    return dt.toIso8601String()
        .substring(0, 10)
        .replaceAll('-', '');
  }



  // --- Direct Single-Part Upload/Download/Delete Helpers ---

  Future<void> _uploadPartDirect(
    String filename,
    List<int> bytes,
  ) async {
    final creds = await getCredentials();
    if (!creds.isValid) {
      throw Exception('Backblaze B2 is not configured.');
    }

    final dateTime = DateTime.now().toUtc();
    final host = '${creds.bucketName}.s3.${creds.region}.backblazeb2.com';
    final path = '/$filename';

    final headers = _sign(
      creds: creds,
      method: 'PUT',
      path: path,
      queryParams: const {},
      payloadBytes: bytes,
      dateTime: dateTime,
    );

    final contentType = filename.endsWith('.jpg') ? 'image/jpeg' : 'application/pdf';
    headers['Content-Type'] = contentType;

    final uri = Uri.https(host, path);

    final response = await http.put(uri, headers: headers, body: bytes);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to upload part: [${response.statusCode}] ${response.body}');
    }
  }

  Future<Uint8List> _downloadPartDirect(String filename) async {
    final creds = await getCredentials();
    if (!creds.isValid) {
      throw Exception('Backblaze B2 is not configured.');
    }

    final dateTime = DateTime.now().toUtc();
    final host = '${creds.bucketName}.s3.${creds.region}.backblazeb2.com';
    final path = '/$filename';

    final headers = _sign(
      creds: creds,
      method: 'GET',
      path: path,
      queryParams: const {},
      payloadBytes: const [],
      dateTime: dateTime,
    );

    final uri = Uri.https(host, path);

    final response = await http.get(uri, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to download part: [${response.statusCode}] ${response.body}');
    }

    return response.bodyBytes;
  }

  Future<void> _deletePartDirect(String filename) async {
    final creds = await getCredentials();
    if (!creds.isValid) {
      throw Exception('Backblaze B2 is not configured.');
    }

    final dateTime = DateTime.now().toUtc();
    final host = '${creds.bucketName}.s3.${creds.region}.backblazeb2.com';
    final path = '/$filename';

    final headers = _sign(
      creds: creds,
      method: 'DELETE',
      path: path,
      queryParams: const {},
      payloadBytes: const [],
      dateTime: dateTime,
    );

    final uri = Uri.https(host, path);
    
    final response = await http.delete(uri, headers: headers);
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Failed to delete file: [${response.statusCode}] ${response.body}');
    }
  }
}
