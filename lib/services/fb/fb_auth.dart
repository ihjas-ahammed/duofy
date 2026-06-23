import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:firedart/firedart.dart' as fd;
// firedart's `User` model lives in user_gateway.dart but isn't re-exported by
// firedart.dart, so we reach for it directly.
import 'package:firedart/auth/user_gateway.dart' as fd_user;
import 'fb_core.dart';

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

class _FdUser implements FbUser {
  fd_user.User _u;
  _FdUser(this._u);
  @override
  String get uid => _u.id;
  @override
  String? get displayName => _u.displayName;
  @override
  String? get email => _u.email;
  @override
  Future<void> updateDisplayName(String? name) async {
    if (name == null) return;
    await fd.FirebaseAuth.instance.updateProfile(displayName: name);
    _u = await fd.FirebaseAuth.instance.getUser();
  }
}

abstract class FbAuth {
  static final FbAuth instance = useFiredart ? _FdAuth() : _FaAuth();

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

class _FdAuth implements FbAuth {
  final StreamController<FbUser?> _ctrl =
      StreamController<FbUser?>.broadcast();
  FbUser? _current;
  late final Future<void> _bootstrap;

  _FdAuth() {
    // firedart's signInState only emits on *changes*, never an initial value.
    // We hydrate _current from the persisted token (if any) on construction
    // and emit a synthetic event so AuthGate's StreamBuilder leaves
    // ConnectionState.waiting on first frame.
    _bootstrap = _hydrate();
    fd.FirebaseAuth.instance.signInState.listen((signedIn) async {
      if (signedIn) {
        try {
          final u = await fd.FirebaseAuth.instance.getUser();
          _current = _FdUser(u);
        } catch (_) {
          _current = null;
        }
      } else {
        _current = null;
      }
      _ctrl.add(_current);
    });
  }

  Future<void> _hydrate() async {
    if (fd.FirebaseAuth.instance.isSignedIn) {
      try {
        final u = await fd.FirebaseAuth.instance.getUser();
        _current = _FdUser(u);
        print("[_FdAuth] Hydrated user successfully: ${u.id}");
      } catch (e, s) {
        print("[_FdAuth] Hydration failed: $e\n$s");
        _current = null;
      }
    } else {
      print("[_FdAuth] Hydration skipped: not signed in");
      _current = null;
    }
  }

  @override
  Stream<FbUser?> authStateChanges() async* {
    await _bootstrap;
    yield _current;
    yield* _ctrl.stream;
  }

  @override
  FbUser? get currentUser => _current;

  @override
  Future<FbUser> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final u = await fd.FirebaseAuth.instance.signIn(email, password);
      _current = _FdUser(u);
      _ctrl.add(_current);
      return _current!;
    } catch (e) {
      throw FbAuthException(_extractFiredartError(e));
    }
  }

  @override
  Future<FbUser> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final u = await fd.FirebaseAuth.instance.signUp(email, password);
      _current = _FdUser(u);
      _ctrl.add(_current);
      return _current!;
    } catch (e) {
      throw FbAuthException(_extractFiredartError(e));
    }
  }

  @override
  Future<void> signOut() async {
    fd.FirebaseAuth.instance.signOut();
    _current = null;
    _ctrl.add(null);
  }
}

/// firedart wraps the Identity Toolkit response in an exception whose toString
/// includes the JSON error body. Pull the human-readable `message` out so the
/// UI sees "INVALID_PASSWORD" rather than a wall of JSON.
String _extractFiredartError(Object e) {
  final s = e.toString();
  final m = RegExp(r'"message"\s*:\s*"([^"]+)"').firstMatch(s);
  if (m != null) return m.group(1)!;
  return s;
}
