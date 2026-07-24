import 'dart:async';

import 'isolate_shim_io.dart' if (dart.library.html) 'isolate_shim_web.dart' as impl;

/// Runs [computation] on a background isolate on IO platforms (mirrors
/// `Isolate.run`) and inline on web, which has no isolates. Used by the PDF
/// pipeline so the same code path compiles everywhere.
Future<R> isolateRun<R>(FutureOr<R> Function() computation) =>
    impl.isolateRun(computation);