import 'package:flutter/painting.dart';

import 'file_image_io.dart' if (dart.library.html) 'file_image_web.dart' as impl;
import 'io_shim.dart';

/// Framework image APIs (FileImage / Image.file) are typed against the REAL
/// dart:io File, which our io_shim's web stub can't satisfy at compile time.
/// This helper bridges the two: real FileImage on IO, an inert 1×1
/// transparent image on web (the call sites are unreachable there — both sit
/// behind kIsWeb / picker-path guards).
ImageProvider fileImageProvider(File file) => impl.fileImageProvider(file);