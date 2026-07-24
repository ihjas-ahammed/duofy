import 'dart:async';

Future<R> isolateRun<R>(FutureOr<R> Function() computation) async =>
    await computation();