import 'dart:io';

import 'package:flutter/painting.dart';

ImageProvider fileImageProvider(File file) => FileImage(file);