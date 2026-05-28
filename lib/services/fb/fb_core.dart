import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart' as fc;
import 'package:firedart/firedart.dart' as fd;
import 'package:path_provider/path_provider.dart';
import '../../firebase_options.dart';

/// firebase_core / firebase_auth / cloud_firestore don't support Linux. On
/// Linux we route auth + Firestore through firedart (pure Dart). Everywhere
/// else we use the native FlutterFire stack. This flag is the single source
/// of truth — the [FbAuth] and [FbFirestore] facades branch on it too.
bool get useFiredart => !kIsWeb && Platform.isLinux;

class FbCore {
  static bool _initialized = false;

  static Future<void> initializeApp() async {
    if (_initialized) return;
    if (useFiredart) {
      final dir = await getApplicationDocumentsDirectory();
      final tokenFile = File('${dir.path}/firedart_token.json');
      final store = _FileTokenStore(tokenFile);
      if (!fd.FirebaseAuth.initialized) {
        fd.FirebaseAuth.initialize(DefaultFirebaseOptions.linuxApiKey, store);
      }
      if (!fd.Firestore.initialized) {
        fd.Firestore.initialize(DefaultFirebaseOptions.linuxProjectId);
      }
    } else {
      await fc.Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    _initialized = true;
  }
}

/// A firedart [TokenStore] that mirrors its token to disk so the signed-in
/// user survives an app restart. firedart calls [write] every time the token
/// rotates (which is roughly hourly), so this also keeps the persisted copy
/// fresh.
class _FileTokenStore extends fd.TokenStore {
  final File _file;
  _FileTokenStore(this._file);

  @override
  fd.Token? read() {
    try {
      if (!_file.existsSync()) return null;
      final raw = _file.readAsStringSync();
      if (raw.trim().isEmpty) return null;
      return fd.Token.fromMap(Map<String, dynamic>.from(jsonDecode(raw)));
    } catch (_) {
      return null;
    }
  }

  @override
  void write(fd.Token? token) {
    try {
      if (token == null) {
        if (_file.existsSync()) _file.deleteSync();
      } else {
        _file.writeAsStringSync(jsonEncode(token.toMap()));
      }
    } catch (_) {
      // Best-effort: if persistence fails the user just signs in again.
    }
  }

  @override
  void delete() {
    try {
      if (_file.existsSync()) _file.deleteSync();
    } catch (_) {}
  }
}
