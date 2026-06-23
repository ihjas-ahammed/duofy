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
bool get useFiredart => !kIsWeb && (Platform.isLinux || Platform.isWindows);

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
      if (!_file.existsSync()) {
        print("[_FileTokenStore] Token file does not exist at ${_file.path}");
        return null;
      }
      final raw = _file.readAsStringSync();
      if (raw.trim().isEmpty) {
        print("[_FileTokenStore] Token file is empty");
        return null;
      }
      final token = fd.Token.fromMap(Map<String, dynamic>.from(jsonDecode(raw)));
      print("[_FileTokenStore] Token read successfully. UserId: ${token.toMap()['userId']}");
      return token;
    } catch (e, s) {
      print("[_FileTokenStore] Error reading token file: $e\n$s");
      return null;
    }
  }

  @override
  void write(fd.Token? token) {
    try {
      if (token == null) {
        print("[_FileTokenStore] Deleting token file...");
        if (_file.existsSync()) _file.deleteSync();
      } else {
        print("[_FileTokenStore] Writing token file for userId: ${token.toMap()['userId']}...");
        _file.writeAsStringSync(jsonEncode(token.toMap()));
      }
    } catch (e, s) {
      print("[_FileTokenStore] Error writing token file: $e\n$s");
    }
  }

  @override
  void delete() {
    try {
      print("[_FileTokenStore] Deleting token file...");
      if (_file.existsSync()) _file.deleteSync();
    } catch (e, s) {
      print("[_FileTokenStore] Error deleting token file: $e\n$s");
    }
  }
}
