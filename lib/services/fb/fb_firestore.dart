import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:firedart/firedart.dart' as fd;
import 'package:grpc/grpc.dart';
import 'fb_core.dart';

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
      useFiredart ? _FdFirestore() : _CfFirestore();
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

// ---------------------------------------------------------------------------
// firedart backend (Linux desktop)
// ---------------------------------------------------------------------------

class _FdFirestore implements FbFirestore {
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
    // firedart `get()` returns a Page<Document>; we only care about the first
    // page for the small collections this app uses (per-user books, ~global
    // catalog). Paging through more than 1024 docs would be a separate task.
    final page = await _ref.get();
    return FbQuerySnapshot(page
        .map((d) => FbDocSnapshot(id: d.id, exists: true, data: d.map))
        .toList());
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
