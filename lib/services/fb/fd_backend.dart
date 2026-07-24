import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firedart/firedart.dart' as fd;
// firedart's `User` model lives in user_gateway.dart but isn't re-exported by
// firedart.dart, so we reach for it directly.
import 'package:firedart/auth/user_gateway.dart' as fd_user;
import 'package:grpc/grpc.dart';
import 'package:path_provider/path_provider.dart';

import '../../firebase_options.dart';
import 'fb_auth.dart';
import 'fb_firestore.dart';

/// Everything firedart/grpc/dart:io lives in THIS file only, selected via
/// conditional import from the fb facades (`fd_backend_stub.dart` on web).
/// That keeps the web build free of IO-only packages at compile time while
/// Linux/Windows desktop keep their pure-Dart Firebase stack.

Future<void> initializeFiredart() async {
  final dir = await getApplicationDocumentsDirectory();
  final tokenFile = File('${dir.path}/firedart_token.json');
  final store = _FileTokenStore(tokenFile);
  if (!fd.FirebaseAuth.initialized) {
    fd.FirebaseAuth.initialize(DefaultFirebaseOptions.linuxApiKey, store);
  }
  if (!fd.Firestore.initialized) {
    fd.Firestore.initialize(DefaultFirebaseOptions.linuxProjectId);
  }
}

/// A firedart [fd.TokenStore] that mirrors its token to disk so the signed-in
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

// ---------------------------------------------------------------------------
// Auth backend
// ---------------------------------------------------------------------------

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

class FdAuthBackend implements FbAuth {
  final StreamController<FbUser?> _ctrl = StreamController<FbUser?>.broadcast();
  FbUser? _current;
  late final Future<void> _bootstrap;

  FdAuthBackend() {
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
        print("[FdAuthBackend] Hydrated user successfully: ${u.id}");
      } catch (e, s) {
        print("[FdAuthBackend] Hydration failed: $e\n$s");
        _current = null;
      }
    } else {
      print("[FdAuthBackend] Hydration skipped: not signed in");
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

// ---------------------------------------------------------------------------
// Firestore backend
// ---------------------------------------------------------------------------

class FdFirestoreBackend implements FbFirestore {
  @override
  FbCollectionRef collection(String path) =>
      _FdCollection(fd.Firestore.instance.collection(path));
}

class _FdCollection implements FbCollectionRef {
  final fd.CollectionReference _ref;
  _FdCollection(this._ref);
  @override
  FbDocRef doc(String id) => _FdDoc(_ref.document(id));
  @override
  Future<FbQuerySnapshot> get() async {
    final List<FbDocSnapshot> docs = [];
    var page = await _ref.get();
    docs.addAll(page.map((d) => FbDocSnapshot(id: d.id, exists: true, data: d.map)));
    while (page.hasNextPage) {
      page = await _ref.get(nextPageToken: page.nextPageToken);
      docs.addAll(page.map((d) => FbDocSnapshot(id: d.id, exists: true, data: d.map)));
    }
    return FbQuerySnapshot(docs);
  }
}

class _FdDoc implements FbDocRef {
  final fd.DocumentReference _ref;
  _FdDoc(this._ref);
  @override
  String get id => _ref.id;
  @override
  Future<void> set(Map<String, dynamic> data) => _ref.set(data);
  @override
  Future<FbDocSnapshot> get() async {
    try {
      final d = await _ref.get();
      return FbDocSnapshot(id: d.id, exists: true, data: d.map);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        return FbDocSnapshot(id: _ref.id, exists: false);
      }
      rethrow;
    }
  }
  @override
  Future<void> delete() => _ref.delete();
  @override
  FbCollectionRef collection(String id) => _FdCollection(_ref.collection(id));
}