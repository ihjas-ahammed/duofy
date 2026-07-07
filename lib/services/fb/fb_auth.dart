import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'fb_core.dart';
import 'fd_backend.dart' if (dart.library.html) 'fd_backend_stub.dart' as fdb;

class FbAuthException implements Exception {
  final String? message;
  FbAuthException(this.message);
  @override
  String toString() => message ?? 'Authentication error';
}

/// Platform-agnostic user. On non-Linux this wraps a `firebase_auth` [User];
/// on Linux it wraps a firedart `User`. The fields are the subset the app
/// actually reads.
abstract class FbUser {
  String get uid;
  String? get displayName;
  String? get email;

  /// Updates the user's display name in the auth provider. The native side
  /// updates the underlying [fa.User] in place; on firedart we re-fetch the
  /// user so subsequent reads return the new value.
  Future<void> updateDisplayName(String? name);
}

class _FaUser implements FbUser {
  final fa.User _u;
  _FaUser(this._u);
  @override
  String get uid => _u.uid;
  @override
  String? get displayName => _u.displayName;
  @override
  String? get email => _u.email;
  @override
  Future<void> updateDisplayName(String? name) => _u.updateDisplayName(name);
}

abstract class FbAuth {
  static final FbAuth instance = useFiredart ? fdb.FdAuthBackend() : _FaAuth();

  Stream<FbUser?> authStateChanges();
  FbUser? get currentUser;
  Future<FbUser> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<FbUser> createUserWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signOut();
}

class _FaAuth implements FbAuth {
  @override
  Stream<FbUser?> authStateChanges() => fa.FirebaseAuth.instance
      .authStateChanges()
      .map((u) => u == null ? null : _FaUser(u));

  @override
  FbUser? get currentUser {
    final u = fa.FirebaseAuth.instance.currentUser;
    return u == null ? null : _FaUser(u);
  }

  @override
  Future<FbUser> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final cred = await fa.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return _FaUser(cred.user!);
    } on fa.FirebaseAuthException catch (e) {
      throw FbAuthException(e.message);
    }
  }

  @override
  Future<FbUser> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final cred = await fa.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return _FaUser(cred.user!);
    } on fa.FirebaseAuthException catch (e) {
      throw FbAuthException(e.message);
    }
  }

  @override
  Future<void> signOut() => fa.FirebaseAuth.instance.signOut();
}
