import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:serious_python/serious_python.dart';

class PythonExecutionResult {
  final String stdout;
  final String stderr;
  final List<String> graphicsBase64;
  final int exitCode;
  final Duration duration;

  PythonExecutionResult({
    required this.stdout,
    required this.stderr,
    required this.graphicsBase64,
    required this.exitCode,
    required this.duration,
  });
}

/// Service for executing Python code natively on Linux, Desktop, and Mobile
/// using SeriousPython and system CPython, with full Jupyter-style inline
/// graphics/matplotlib support and real-time interactive input() handling.
class PythonRunnerService {
  static final PythonRunnerService _instance = PythonRunnerService._internal();
  static PythonRunnerService get instance => _instance;
  PythonRunnerService._internal();

  /// Wraps user Python code to intercept stdout/stderr, handle real-time interactive
  /// input() socket requests, and capture matplotlib figures as base64 PNG data.
  String _prepareWrapperCode(String userCode, {int serverPort = 0, List<String> inputs = const []}) {
    final encodedUserCode = jsonEncode(userCode);
    final encodedInputs = jsonEncode(inputs);
    return '''
import sys
import io
import json
import base64
import builtins
import socket

_orig_stdout = sys.stdout
_orig_stderr = sys.stderr

_stdout_buffer = io.StringIO()
_stderr_buffer = io.StringIO()
sys.stdout = _stdout_buffer
sys.stderr = _stderr_buffer

_user_inputs = $encodedInputs
_input_idx = 0
_server_port = $serverPort

def _interactive_input(prompt=''):
    global _input_idx
    if prompt:
        _stdout_buffer.write(str(prompt))
    if _server_port > 0:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect(('127.0.0.1', _server_port))
            req = json.dumps({'type': 'input_request', 'prompt': str(prompt)}) + '\\n'
            s.sendall(req.encode('utf-8'))
            data = b''
            while True:
                chunk = s.recv(1024)
                if not chunk:
                    break
                data += chunk
                if b'\\n' in data:
                    break
            s.close()
            res = json.loads(data.decode('utf-8'))
            reply = str(res.get('reply', ''))
            _stdout_buffer.write(reply + '\\n')
            return reply
        except Exception:
            pass
    if _input_idx < len(_user_inputs):
        val = str(_user_inputs[_input_idx])
        _input_idx += 1
        _stdout_buffer.write(val + '\\n')
        return val
    _stdout_buffer.write('\\n')
    return ''

builtins.input = _interactive_input
sys.stdin = io.StringIO('\\n'.join([str(x) for x in _user_inputs]) + ('\\n' if _user_inputs else ''))

_graphics_list = []

try:
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt

    def _capture_plt():
        if plt.get_fignums():
            for num in plt.get_fignums():
                fig = plt.figure(num)
                buf = io.BytesIO()
                fig.savefig(buf, format='png', bbox_inches='tight', dpi=130)
                buf.seek(0)
                _graphics_list.append(base64.b64encode(buf.read()).decode('ascii'))
            plt.close('all')
except Exception:
    def _capture_plt():
        pass

try:
    exec($encodedUserCode)
    _capture_plt()
except Exception as e:
    import traceback
    traceback.print_exc(file=_stderr_buffer)

try:
    _capture_plt()
except Exception:
    pass

sys.stdout = _orig_stdout
sys.stderr = _orig_stderr

out_str = _stdout_buffer.getvalue()
err_str = _stderr_buffer.getvalue()

payload = {
    "stdout": out_str,
    "stderr": err_str,
    "graphics": _graphics_list
}

print("===DUOFY_PY_RESULT_START===")
print(json.dumps(payload))
print("===DUOFY_PY_RESULT_END===")
''';
  }

  /// Executes user python code and returns stdout, stderr, execution duration, and inline graphics.
  /// If [onInputRequest] is provided, real-time input() prompts from Python will invoke it.
  Future<PythonExecutionResult> runCode(
    String code, {
    List<String> inputs = const [],
    Future<String> Function(String prompt)? onInputRequest,
  }) async {
    final sw = Stopwatch()..start();
    ServerSocket? serverSocket;
    int serverPort = 0;

    if (onInputRequest != null && !kIsWeb) {
      try {
        serverSocket = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
        serverPort = serverSocket.port;
        serverSocket.listen((socket) {
          socket.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter()).listen(
            (line) async {
              try {
                final Map<String, dynamic> req = jsonDecode(line);
                if (req['type'] == 'input_request') {
                  final prompt = req['prompt'] ?? '';
                  final reply = await onInputRequest(prompt);
                  socket.write('${jsonEncode({'reply': reply})}\n');
                  await socket.flush();
                  await socket.close();
                }
              } catch (_) {
                socket.close();
              }
            },
            onError: (_) => socket.close(),
          );
        });
      } catch (_) {}
    }

    final wrapperCode = _prepareWrapperCode(code, serverPort: serverPort, inputs: inputs);

    if (kIsWeb) {
      sw.stop();
      await serverSocket?.close();
      return PythonExecutionResult(
        stdout: "Web execution utilizes browser engine.",
        stderr: "",
        graphicsBase64: [],
        exitCode: 0,
        duration: sw.elapsed,
      );
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final pyFile = File(path.join(tempDir.path, 'duofy_runner_${DateTime.now().millisecondsSinceEpoch}.py'));
      await pyFile.writeAsString(wrapperCode);

      ProcessResult? procResult;
      try {
        procResult = await Process.run('python3', [pyFile.path], workingDirectory: tempDir.path);
      } catch (_) {
        try {
          procResult = await Process.run('python', [pyFile.path], workingDirectory: tempDir.path);
        } catch (_) {}
      }

      String rawStdout = '';
      String rawStderr = '';
      int exitCode = 0;

      if (procResult != null) {
        rawStdout = procResult.stdout.toString();
        rawStderr = procResult.stderr.toString();
        exitCode = procResult.exitCode;
      } else {
        try {
          final res = await SeriousPython.runProgram(pyFile.path, sync: true);
          rawStdout = res ?? '';
        } catch (e) {
          rawStderr = "SeriousPython runtime exception: $e";
          exitCode = 1;
        }
      }

      try {
        if (await pyFile.exists()) await pyFile.delete();
      } catch (_) {}

      await serverSocket?.close();

      String stdOutText = rawStdout;
      String stdErrText = rawStderr;
      List<String> graphics = [];

      if (rawStdout.contains("===DUOFY_PY_RESULT_START===")) {
        final parts = rawStdout.split("===DUOFY_PY_RESULT_START===");
        final preLogs = parts[0];
        final postParts = parts[1].split("===DUOFY_PY_RESULT_END===");
        final jsonStr = postParts[0].trim();
        final postLogs = postParts.length > 1 ? postParts[1] : '';

        try {
          final Map<String, dynamic> data = jsonDecode(jsonStr);
          stdOutText = preLogs + (data['stdout'] ?? '') + postLogs;
          stdErrText = (data['stderr'] ?? '') + rawStderr;
          graphics = List<String>.from(data['graphics'] ?? []);
        } catch (_) {}
      }

      sw.stop();
      return PythonExecutionResult(
        stdout: stdOutText.trimRight(),
        stderr: stdErrText.trimRight(),
        graphicsBase64: graphics,
        exitCode: exitCode,
        duration: sw.elapsed,
      );
    } catch (e) {
      await serverSocket?.close();
      sw.stop();
      return PythonExecutionResult(
        stdout: '',
        stderr: 'Execution Error: $e',
        graphicsBase64: [],
        exitCode: 1,
        duration: sw.elapsed,
      );
    }
  }
}
