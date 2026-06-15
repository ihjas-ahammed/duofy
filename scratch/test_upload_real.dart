import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

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
}

void main() async {
  final creds = B2Credentials(
    keyId: '00384db7dd2f3390000000001',
    applicationKey: 'K003EUCIHsnIRRoLkgDu7mXM4mSttW8',
    bucketName: 'duofyug',
    region: 'eu-central-003',
  );

  print('Testing Backblaze B2 Upload of METACOGNITION.pdf...');
  final filename = 'METACOGNITION.pdf';
  final file = File('METACOGNITION.pdf');
  if (!file.existsSync()) {
    print('Error: METACOGNITION.pdf does not exist');
    return;
  }
  
  final testBytes = await file.readAsBytes();
  print('File size: ${testBytes.length} bytes');

  try {
    print('1. Uploading file...');
    final dateTime1 = DateTime.now().toUtc();
    final host = '${creds.bucketName}.s3.${creds.region}.backblazeb2.com';
    final encodedFilename = Uri.encodeComponent(filename);
    final path = '/$encodedFilename';

    final headers1 = sign(
      creds: creds,
      method: 'PUT',
      path: path,
      queryParams: const {},
      payloadBytes: testBytes,
      dateTime: dateTime1,
    );
    headers1['Content-Type'] = 'application/pdf';
    headers1['Content-Length'] = testBytes.length.toString();

    final uri1 = Uri.parse('https://$host$path');
    final response1 = await http.put(uri1, headers: headers1, body: testBytes);
    print('Upload Response: ${response1.statusCode}');
    if (response1.statusCode != 200 && response1.statusCode != 201) {
      print('Upload Failed: ${response1.body}');
      return;
    }
    print('Upload SUCCESS!');

    print('2. Deleting test file...');
    final dateTime3 = DateTime.now().toUtc();
    final headers3 = sign(
      creds: creds,
      method: 'DELETE',
      path: path,
      queryParams: const {},
      payloadBytes: const [],
      dateTime: dateTime3,
    );
    final uri3 = Uri.parse('https://$host$path');
    final response3 = await http.delete(uri3, headers: headers3);
    print('Delete Response Code: ${response3.statusCode}');
  } catch (e) {
    print('ERROR: $e');
  }
}

Map<String, String> sign({
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

  final segments = path.split('/').where((s) => s.isNotEmpty).map((s) => Uri.encodeComponent(s)).join('/');
  var canonicalUri = '/$segments';
  if (path.endsWith('/') && !canonicalUri.endsWith('/')) {
    canonicalUri += '/';
  }

  final sortedKeys = queryParams.keys.toList()..sort();
  final canonicalQueryString = sortedKeys
      .map((k) => '${Uri.encodeComponent(k)}=${Uri.encodeComponent(queryParams[k]!)}')
      .join('&');

  final payloadHash = sha256.convert(payloadBytes).toString();

  final headersToSign = {
    'host': host,
    'x-amz-content-sha256': payloadHash,
    'x-amz-date': amzDate,
  };

  final sortedHeaderKeys = headersToSign.keys.toList()..sort();
  final canonicalHeaders = sortedHeaderKeys
      .map((k) => '$k:${headersToSign[k]!.trim()}\n')
      .join('');

  final signedHeaders = sortedHeaderKeys.join(';');

  final canonicalRequest = [
    method.toUpperCase(),
    canonicalUri,
    canonicalQueryString,
    canonicalHeaders,
    signedHeaders,
    payloadHash,
  ].join('\n');

  final hashedCanonicalRequest = sha256.convert(utf8.encode(canonicalRequest)).toString();

  final credentialScope = '$dateStamp/${creds.region}/s3/aws4_request';
  final stringToSign = [
    'AWS4-HMAC-SHA256',
    amzDate,
    credentialScope,
    hashedCanonicalRequest,
  ].join('\n');

  final kDate = hmacSha256(utf8.encode('AWS4${creds.applicationKey}'), dateStamp);
  final kRegion = hmacSha256(kDate, creds.region);
  final kService = hmacSha256(kRegion, 's3');
  final kSigning = hmacSha256(kService, 'aws4_request');

  final signature = hmacSha256Hex(kSigning, stringToSign);

  final authorization = 'AWS4-HMAC-SHA256 Credential=${creds.keyId}/$credentialScope, SignedHeaders=$signedHeaders, Signature=$signature';

  return {
    'Authorization': authorization,
    'x-amz-content-sha256': payloadHash,
    'x-amz-date': amzDate,
    'host': host,
  };
}

List<int> hmacSha256(List<int> key, String data) {
  final hmac = Hmac(sha256, key);
  return hmac.convert(utf8.encode(data)).bytes;
}

String hmacSha256Hex(List<int> key, String data) {
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
