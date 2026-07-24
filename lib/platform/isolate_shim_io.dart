import 'dart:async';
import 'dart:isolate';

Future<R> isolateRun<R>(FutureOr<R> Function() computation) =>
    Isolate.run(computation);