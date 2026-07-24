import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'fb_core.dart';
import 'fd_backend.dart' if (dart.library.html) 'fd_backend_stub.dart' as fdb;

/// Snapshot of a single document; mirrors the relevant parts of both
/// `cloud_firestore`'s `DocumentSnapshot` and firedart's `Document`.
class FbDocSnapshot {
  final String id;
  final bool exists;
  final Map<String, dynamic>? _data;
  FbDocSnapshot({required this.id, required this.exists, Map<String, dynamic>? data}) : _data = data;
  Map<String, dynamic>? data() => _data;
}

class FbQuerySnapshot {
  final List<FbDocSnapshot> docs;
  FbQuerySnapshot(this.docs);
}

abstract class FbDocRef {
  String get id;
  Future<void> set(Map<String, dynamic> data);
  Future<FbDocSnapshot> get();
  Future<void> delete();
  FbCollectionRef collection(String id);
}

abstract class FbCollectionRef {
  FbDocRef doc(String id);
  Future<FbQuerySnapshot> get();
}

abstract class FbFirestore {
  static final FbFirestore instance =
      useFiredart ? fdb.FdFirestoreBackend() : _CfFirestore();
  FbCollectionRef collection(String path);
}

// ---------------------------------------------------------------------------
// cloud_firestore backend (Android / iOS / macOS / Windows / Web)
// ---------------------------------------------------------------------------

class _CfFirestore implements FbFirestore {
  final cf.FirebaseFirestore _db = cf.FirebaseFirestore.instance;
  @override
  FbCollectionRef collection(String path) => _CfCollection(_db.collection(path));
}

class _CfCollection implements FbCollectionRef {
  final cf.CollectionReference<Map<String, dynamic>> _ref;
  _CfCollection(this._ref);
  @override
  FbDocRef doc(String id) => _CfDoc(_ref.doc(id));
  @override
  Future<FbQuerySnapshot> get() async {
    final snap = await _ref.get();
    return FbQuerySnapshot(snap.docs
        .map((d) => FbDocSnapshot(id: d.id, exists: d.exists, data: d.data()))
        .toList());
  }
}

class _CfDoc implements FbDocRef {
  final cf.DocumentReference<Map<String, dynamic>> _ref;
  _CfDoc(this._ref);
  @override
  String get id => _ref.id;
  @override
  Future<void> set(Map<String, dynamic> data) => _ref.set(data);
  @override
  Future<FbDocSnapshot> get() async {
    final snap = await _ref.get();
    return FbDocSnapshot(id: snap.id, exists: snap.exists, data: snap.data());
  }
  @override
  Future<void> delete() => _ref.delete();
  @override
  FbCollectionRef collection(String id) => _CfCollection(_ref.collection(id));
}

// The firedart backend (Linux/Windows desktop) lives in fd_backend.dart,
// conditionally imported above so web builds never see firedart/grpc.