/// Minimal `dart:io` stand-ins for the web build (see io_shim.dart).
///
/// Behavioural contract:
///  - existence checks report `false` (most call sites treat "missing" as a
///    graceful degradation path, e.g. the dashboard's missing-PDF banner);
///  - anything that would actually touch a file system throws
///    [UnsupportedError] so misuse is loud rather than silently wrong;
///  - [Platform] mirrors the real API with web-appropriate constants.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

Never _unsupported(String op) =>
    throw UnsupportedError('$op is not supported on the web build');

class Platform {
  Platform._();
  static const bool isLinux = false;
  static const bool isWindows = false;
  static const bool isMacOS = false;
  static const bool isAndroid = false;
  static const bool isIOS = false;
  static const bool isFuchsia = false;
  static const int numberOfProcessors = 1;
  static const String pathSeparator = '/';
  static const String operatingSystem = 'web';
  static const String operatingSystemVersion = 'web';
  static Map<String, String> get environment => const {};
}

abstract class FileSystemEntity {
  String get path;
  Future<bool> exists();
  bool existsSync();
  Future<FileSystemEntity> delete({bool recursive = false});
  void deleteSync({bool recursive = false});
  static Future<bool> isDirectory(String path) async => false;
  static Future<bool> isFile(String path) async => false;
}

class File implements FileSystemEntity {
  @override
  final String path;
  File(this.path);

  File get absolute => this;
  Directory get parent {
    final idx = path.replaceAll('\\', '/').lastIndexOf('/');
    return Directory(idx <= 0 ? '/' : path.substring(0, idx));
  }

  Uri get uri => Uri.parse(path);

  @override
  Future<bool> exists() async => false;
  @override
  bool existsSync() => false;

  Future<File> create({bool recursive = false, bool exclusive = false}) =>
      _unsupported('File.create');
  void createSync({bool recursive = false, bool exclusive = false}) =>
      _unsupported('File.createSync');
  File renameSync(String newPath) => _unsupported('File.renameSync');
  Future<Uint8List> readAsBytes() => _unsupported('File.readAsBytes');
  Uint8List readAsBytesSync() => _unsupported('File.readAsBytesSync');
  Future<String> readAsString({Encoding encoding = utf8}) =>
      _unsupported('File.readAsString');
  String readAsStringSync({Encoding encoding = utf8}) =>
      _unsupported('File.readAsStringSync');
  Future<List<String>> readAsLines({Encoding encoding = utf8}) =>
      _unsupported('File.readAsLines');
  Future<File> writeAsBytes(List<int> bytes,
          {dynamic mode, bool flush = false}) =>
      _unsupported('File.writeAsBytes');
  void writeAsBytesSync(List<int> bytes, {dynamic mode, bool flush = false}) =>
      _unsupported('File.writeAsBytesSync');
  Future<File> writeAsString(String contents,
          {dynamic mode, Encoding encoding = utf8, bool flush = false}) =>
      _unsupported('File.writeAsString');
  void writeAsStringSync(String contents,
          {dynamic mode, Encoding encoding = utf8, bool flush = false}) =>
      _unsupported('File.writeAsStringSync');
  Future<File> copy(String newPath) => _unsupported('File.copy');
  Future<File> rename(String newPath) => _unsupported('File.rename');
  Future<int> length() => _unsupported('File.length');
  int lengthSync() => _unsupported('File.lengthSync');
  Future<DateTime> lastModified() => _unsupported('File.lastModified');
  Stream<List<int>> openRead([int? start, int? end]) =>
      _unsupported('File.openRead');

  @override
  Future<FileSystemEntity> delete({bool recursive = false}) =>
      _unsupported('File.delete');
  @override
  void deleteSync({bool recursive = false}) => _unsupported('File.deleteSync');
}

class Directory implements FileSystemEntity {
  @override
  final String path;
  Directory(this.path);

  static Directory get systemTemp => Directory('/tmp');

  @override
  Future<bool> exists() async => false;
  @override
  bool existsSync() => false;

  Future<Directory> create({bool recursive = false}) =>
      _unsupported('Directory.create');
  void createSync({bool recursive = false}) => _unsupported('Directory.createSync');
  Future<Directory> createTemp([String? prefix]) =>
      _unsupported('Directory.createTemp');
  Directory createTempSync([String? prefix]) =>
      _unsupported('Directory.createTempSync');
  Stream<FileSystemEntity> list(
          {bool recursive = false, bool followLinks = true}) =>
      _unsupported('Directory.list');
  List<FileSystemEntity> listSync(
          {bool recursive = false, bool followLinks = true}) =>
      _unsupported('Directory.listSync');

  @override
  Future<FileSystemEntity> delete({bool recursive = false}) =>
      _unsupported('Directory.delete');
  @override
  void deleteSync({bool recursive = false}) =>
      _unsupported('Directory.deleteSync');
}

class ProcessResult {
  final int exitCode;
  final dynamic stdout;
  final dynamic stderr;
  final int pid;
  ProcessResult(this.pid, this.exitCode, this.stdout, this.stderr);
}

class Process {
  Process._();
  static Future<ProcessResult> run(String executable, List<String> arguments,
          {String? workingDirectory,
          Map<String, String>? environment,
          bool runInShell = false}) =>
      _unsupported('Process.run');
}

class FileSystemException implements Exception {
  final String message;
  final String? path;
  const FileSystemException([this.message = '', this.path]);
  @override
  String toString() => 'FileSystemException: $message ${path ?? ''}';
}

class IOException implements Exception {}

class SocketException implements IOException {
  final String message;
  const SocketException(this.message);
  @override
  String toString() => 'SocketException: $message';
}

class HttpException implements IOException {
  final String message;
  const HttpException(this.message);
  @override
  String toString() => 'HttpException: $message';
}

/// dart:io WebSocket stand-in (the live-chat assistant uses it; on web the
/// feature is disabled behind kIsWeb guards).
class WebSocket {
  WebSocket._();
  static Future<WebSocket> connect(String url,
          {Iterable<String>? protocols, Map<String, dynamic>? headers}) =>
      _unsupported('WebSocket.connect');
  void add(dynamic data) => _unsupported('WebSocket.add');
  StreamSubscription<dynamic> listen(void Function(dynamic)? onData,
          {Function? onError, void Function()? onDone, bool? cancelOnError}) =>
      _unsupported('WebSocket.listen');
  Future close([int? code, String? reason]) => _unsupported('WebSocket.close');
  int get readyState => 3;
  int? get closeCode => null;
  String? get closeReason => null;
}
