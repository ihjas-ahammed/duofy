import 'fb_auth.dart';
import 'fb_firestore.dart';

/// Web stand-in for fd_backend.dart. `useFiredart` is always false on web,
/// so none of this is ever called — it exists only so the conditional import
/// resolves without pulling firedart/grpc/dart:io into the web build.

Future<void> initializeFiredart() async {
  throw UnsupportedError('firedart backend is not available on this platform');
}

class FdAuthBackend implements FbAuth {
  FdAuthBackend() {
    throw UnsupportedError('firedart backend is not available on this platform');
  }
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('firedart backend is not available on this platform');
}

class FdFirestoreBackend implements FbFirestore {
  FdFirestoreBackend() {
    throw UnsupportedError('firedart backend is not available on this platform');
  }
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('firedart backend is not available on this platform');
}
