import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart' as fc;

import '../../firebase_options.dart';
import 'fd_backend.dart' if (dart.library.html) 'fd_backend_stub.dart' as fdb;

/// firebase_core / firebase_auth / cloud_firestore don't support Linux (and
/// our Windows desktop build also routes around them). On those platforms we
/// use firedart (pure Dart) via the conditionally imported fd_backend; on
/// Android / iOS / macOS / Web we use the native FlutterFire stack. This flag
/// is the single source of truth — the [FbAuth] and [FbFirestore] facades
/// branch on it too.
///
/// Uses [defaultTargetPlatform] instead of dart:io's Platform so this file
/// (and everything importing it) compiles on web.
bool get useFiredart =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows);

class FbCore {
  static bool _initialized = false;

  static Future<void> initializeApp() async {
    if (_initialized) return;
    if (useFiredart) {
      await fdb.initializeFiredart();
    } else {
      await fc.Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    _initialized = true;
  }
}
