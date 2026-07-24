/// Platform-conditional `dart:io`.
///
/// App code imports THIS instead of `dart:io`. On IO platforms it re-exports
/// the real `dart:io`, so nothing changes. On web it resolves to
/// `io_stub.dart`, whose minimal stand-ins let shared code COMPILE — file
/// system calls still throw (or report non-existence), so call sites keep
/// their `kIsWeb` runtime guards for feature degradation.
library;

// dart:io is the default so the analyzer (and every IO platform) resolves
// the real library; only the web compiler takes the stub branch.
export 'dart:io' if (dart.library.html) 'io_stub.dart';