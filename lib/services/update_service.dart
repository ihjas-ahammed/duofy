import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

/// A pending app update resolved from the GitHub `builds/latest.json` manifest.
class UpdateInfo {
  final String versionName;
  final int versionCode;

  /// What's-new notes in Markdown, fetched from the manifest's `changelogPath`.
  final String changelog;

  /// Absolute URL of the split APK matching the running device's ABI.
  final String apkUrl;
  final String abi;

  const UpdateInfo({
    required this.versionName,
    required this.versionCode,
    required this.changelog,
    required this.apkUrl,
    required this.abi,
  });
}

/// Checks GitHub for a newer build, downloads the matching split APK to the
/// app cache (reusing an already-downloaded one), and launches the system
/// installer. Android-only — every entry point no-ops elsewhere.
///
/// The release CI (`.github/workflows/android.yml`) publishes the manifest and
/// per-version changelog this reads; see that workflow for the schema.
class UpdateService {
  UpdateService._();
  static final UpdateService instance = UpdateService._();

  /// Raw GitHub base for the `main` branch of the app repo. The manifest, the
  /// changelog and the APKs all live under here.
  static const String _rawBase =
      'https://raw.githubusercontent.com/ihjas-ahammed/duofy/main/';
  static const String _manifestUrl = '${_rawBase}builds/latest.json';

  /// Only surface the dialog once per app session so revisiting Home doesn't
  /// re-nag; a manual "check for updates" can pass `force: true`.
  bool _promptedThisSession = false;

  /// 0.0–1.0 download progress for the active APK download, for the dialog.
  final ValueNotifier<double> downloadProgress = ValueNotifier<double>(0);

  bool get isSupported => !kIsWeb && Platform.isAndroid;

  static const String _githubReleasesUrl =
      'https://api.github.com/repos/ihjas-ahammed/duofy/releases/latest';

  Future<String> getCurrentVersionString() async {
    try {
      final pkg = await PackageInfo.fromPlatform();
      return 'v${pkg.version} (build ${pkg.buildNumber})';
    } catch (_) {
      return 'v1.0.0';
    }
  }

  /// Returns the pending update if a newer build exists, else null. Safe to
  /// call anywhere — swallows network/parse errors and returns null.
  Future<UpdateInfo?> checkForUpdate({bool force = false}) async {
    if (_promptedThisSession && !force) return null;
    try {
      final pkg = await PackageInfo.fromPlatform();
      final currentCode = int.tryParse(pkg.buildNumber) ?? 0;
      final currentVersionStr = pkg.version;

      // 1. Try builds/latest.json manifest first
      try {
        final res = await http
            .get(Uri.parse(_manifestUrl))
            .timeout(const Duration(seconds: 8));
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          final remoteCode = (data['versionCode'] as num?)?.toInt() ?? 0;
          final versionName = (data['versionName'] as String?) ?? '';
          final apks = (data['apks'] as Map?)?.cast<String, dynamic>() ?? {};

          if (isSupported) {
            await _purgeStaleDownloads(caughtUp: currentCode >= remoteCode);
          }

          if (remoteCode > currentCode && apks.isNotEmpty) {
            final abi = isSupported ? await _pickAbi(apks.keys.toList()) : apks.keys.first;
            if (abi != null) {
              final apkRel = apks[abi] as String;
              final changelog = await _fetchChangelog(data, versionName);
              return UpdateInfo(
                versionName: versionName,
                versionCode: remoteCode,
                changelog: changelog,
                apkUrl: _rawBase + apkRel,
                abi: abi,
              );
            }
          }
        }
      } catch (_) {}

      // 2. Fallback to GitHub Releases API (api.github.com/repos/ihjas-ahammed/duofy/releases/latest)
      final ghRes = await http
          .get(
            Uri.parse(_githubReleasesUrl),
            headers: {'Accept': 'application/vnd.github.v3+json'},
          )
          .timeout(const Duration(seconds: 8));

      if (ghRes.statusCode == 200) {
        final ghData = jsonDecode(ghRes.body) as Map<String, dynamic>;
        final tagName = (ghData['tag_name'] as String?) ?? '';
        final body = (ghData['body'] as String?) ?? 'New update available on GitHub!';
        final htmlUrl = (ghData['html_url'] as String?) ?? 'https://github.com/ihjas-ahammed/duofy/releases';

        final cleanTag = tagName.replaceAll('v', '').trim();
        if (cleanTag.isNotEmpty && cleanTag != currentVersionStr) {
          return UpdateInfo(
            versionName: tagName.startsWith('v') ? tagName : 'v$tagName',
            versionCode: currentCode + 1,
            changelog: body,
            apkUrl: htmlUrl,
            abi: 'universal',
          );
        }
      }
    } catch (e) {
      debugPrint('[UpdateService] checkForUpdate failed: $e');
    }
    return null;
  }

  /// Marks that the update dialog has been shown this session.
  void markPrompted() => _promptedThisSession = true;

  Future<String> _fetchChangelog(
    Map<String, dynamic> data,
    String versionName,
  ) async {
    // An inline `changelog` wins; otherwise fetch the referenced Markdown file.
    final inline = data['changelog'] as String?;
    if (inline != null && inline.trim().isNotEmpty) return inline;

    final path = data['changelogPath'] as String?;
    if (path != null && path.isNotEmpty) {
      try {
        final res = await http
            .get(Uri.parse(_rawBase + path))
            .timeout(const Duration(seconds: 15));
        if (res.statusCode == 200 && res.body.trim().isNotEmpty) {
          return res.body;
        }
      } catch (e) {
        debugPrint('[UpdateService] changelog fetch failed: $e');
      }
    }
    return '## What’s new\n\nVersion $versionName is available.';
  }

  /// Picks the device's preferred ABI that we actually ship a split APK for.
  Future<String?> _pickAbi(List<String> available) async {
    try {
      final android = await DeviceInfoPlugin().androidInfo;
      for (final abi in android.supportedAbis) {
        if (available.contains(abi)) return abi;
      }
    } catch (e) {
      debugPrint('[UpdateService] ABI detection failed: $e');
    }
    // Almost every active Android device is arm64; fall back to it, then to
    // whatever the manifest offers.
    if (available.contains('arm64-v8a')) return 'arm64-v8a';
    return available.isEmpty ? null : available.first;
  }

  Future<Directory> _updatesDir() async {
    final base = await getApplicationSupportDirectory();
    final dir = Directory('${base.path}/updates');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  Future<File> _apkFileFor(UpdateInfo info) async {
    final dir = await _updatesDir();
    return File('${dir.path}/flow-v${info.versionName}-${info.abi}.apk');
  }

  /// A fully-downloaded APK for [info], if one is already cached. Partial
  /// downloads live under a `.part` name and never match here.
  Future<File?> cachedApk(UpdateInfo info) async {
    final file = await _apkFileFor(info);
    return await file.exists() ? file : null;
  }

  /// Downloads the split APK for [info], streaming progress into
  /// [downloadProgress]. Reuses a cached copy whose size matches the remote.
  /// Returns the APK file, or null on failure.
  Future<File?> downloadApk(UpdateInfo info) async {
    downloadProgress.value = 0;
    final file = await _apkFileFor(info);
    final client = http.Client();
    try {
      // Reuse a previously completed download when its size matches the remote.
      int? remoteSize;
      try {
        final head = await client
            .head(Uri.parse(info.apkUrl))
            .timeout(const Duration(seconds: 15));
        remoteSize = int.tryParse(head.headers['content-length'] ?? '');
      } catch (_) {}
      if (remoteSize != null &&
          await file.exists() &&
          await file.length() == remoteSize) {
        downloadProgress.value = 1.0;
        return file;
      }

      final resp = await client.send(http.Request('GET', Uri.parse(info.apkUrl)));
      if (resp.statusCode != 200) {
        debugPrint('[UpdateService] APK download HTTP ${resp.statusCode}');
        return null;
      }
      final total = resp.contentLength ?? remoteSize ?? 0;

      // Stream to a .part file, then atomically rename so a crash mid-download
      // never leaves a truncated APK that looks complete.
      final part = File('${file.path}.part');
      final sink = part.openWrite();
      int received = 0;
      try {
        await for (final chunk in resp.stream) {
          sink.add(chunk);
          received += chunk.length;
          if (total > 0) {
            downloadProgress.value = (received / total).clamp(0.0, 1.0);
          }
        }
      } finally {
        await sink.close();
      }
      if (await file.exists()) await file.delete();
      await part.rename(file.path);
      downloadProgress.value = 1.0;
      return file;
    } catch (e) {
      debugPrint('[UpdateService] downloadApk failed: $e');
      return null;
    } finally {
      client.close();
    }
  }

  /// Hands the APK to the system installer. On Android 8+ the user is routed
  /// through the "Install unknown apps" grant the first time.
  Future<bool> installApk(File apk) async {
    try {
      final result = await OpenFilex.open(
        apk.path,
        type: 'application/vnd.android.package-archive',
      );
      if (result.type != ResultType.done) {
        debugPrint('[UpdateService] install open: ${result.type} ${result.message}');
      }
      return result.type == ResultType.done;
    } catch (e) {
      debugPrint('[UpdateService] installApk failed: $e');
      return false;
    }
  }

  /// Cleans the updates cache. Always removes interrupted `.part` leftovers;
  /// when [caughtUp] (the running build has reached the latest published one,
  /// i.e. the user installed what we downloaded) it wipes the cached APKs too.
  Future<void> _purgeStaleDownloads({required bool caughtUp}) async {
    try {
      final dir = await _updatesDir();
      await for (final entry in dir.list()) {
        if (entry is! File) continue;
        final name = entry.uri.pathSegments.last;
        if (caughtUp || name.endsWith('.part')) {
          await entry.delete().catchError((_) => entry);
        }
      }
    } catch (e) {
      debugPrint('[UpdateService] purge failed: $e');
    }
  }
}