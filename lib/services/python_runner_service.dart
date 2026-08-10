import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  /// input() socket requests, write results to JSON file, and capture matplotlib figures.
  String _prepareWrapperCode(
    String userCode, {
    int serverPort = 0,
    List<String> inputs = const [],
    String resultFilePath = '',
  }) {
    final encodedUserCode = jsonEncode(userCode);
    final encodedInputs = jsonEncode(inputs);
    final encodedResultFile = jsonEncode(resultFilePath);
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
_result_file = $encodedResultFile

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
    _stdout_buffer.write('1\\n')
    return '1'

builtins.input = _interactive_input
sys.stdin = io.StringIO('\\n'.join([str(x) for x in _user_inputs]) + ('\\n' if _user_inputs else ''))

_graphics_list = []

def _capture_plt():
    pass

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
    import types

    class _PyplotStub:
        def __init__(self):
            self.lines = []
            self.title_str = ""
            self.xlabel_str = ""
            self.ylabel_str = ""
            self.has_grid = False
            self.has_legend = False

        def plot(self, *args, **kwargs):
            color = kwargs.get('color', kwargs.get('c', '#38bdf8'))
            label = kwargs.get('label', '')
            if len(args) >= 2:
                try:
                    xs, ys = list(args[0]), list(args[1])
                except Exception:
                    xs, ys = [0], [0]
            elif len(args) == 1:
                try:
                    ys = list(args[0])
                    xs = list(range(len(ys)))
                except Exception:
                    xs, ys = [0], [0]
            else:
                return
            self.lines.append({'x': xs, 'y': ys, 'color': color, 'label': label})

        def scatter(self, x, y, *args, **kwargs):
            self.plot(x, y, *args, **kwargs)

        def bar(self, x, height, *args, **kwargs):
            self.plot(x, height, *args, **kwargs)

        def title(self, label, *args, **kwargs):
            self.title_str = str(label)

        def xlabel(self, label, *args, **kwargs):
            self.xlabel_str = str(label)

        def ylabel(self, label, *args, **kwargs):
            self.ylabel_str = str(label)

        def grid(self, b=True, *args, **kwargs):
            self.has_grid = bool(b)

        def legend(self, *args, **kwargs):
            self.has_legend = True

        def figure(self, *args, **kwargs):
            return self

        def clf(self):
            self.lines = []
            self.title_str = ""
            self.xlabel_str = ""
            self.ylabel_str = ""

        def close(self, *args):
            self.clf()

        def get_fignums(self):
            return [1] if self.lines else []

        def show(self):
            if not self.lines:
                return
            svg = _render_svg_plot(self)
            if svg:
                _graphics_list.append(base64.b64encode(svg.encode('utf-8')).decode('ascii'))
            self.clf()

    _plt_inst = _PyplotStub()

    def _render_svg_plot(p):
        all_x = [x for line in p.lines for x in line['x'] if isinstance(x, (int, float))]
        all_y = [y for line in p.lines for y in line['y'] if isinstance(y, (int, float))]
        if not all_x or not all_y:
            return ""
        min_x, max_x = min(all_x), max(all_x)
        min_y, max_y = min(all_y), max(all_y)
        if min_x == max_x: max_x += 1.0
        if min_y == max_y: max_y += 1.0

        w, h = 480, 280
        pad_l, pad_r, pad_t, pad_b = 55, 25, 35, 45
        pw = w - pad_l - pad_r
        ph = h - pad_t - pad_b

        def map_x(val):
            return pad_l + (val - min_x) / (max_x - min_x) * pw

        def map_y(val):
            return pad_t + ph - (val - min_y) / (max_y - min_y) * ph

        parts = [f'<svg width="{w}" height="{h}" viewBox="0 0 {w} {h}" xmlns="http://www.w3.org/2000/svg" style="background:#0d1117; font-family:sans-serif;">']
        parts.append(f'<rect width="{w}" height="{h}" rx="8" fill="#0d1117"/>')

        if p.has_grid:
            for i in range(5):
                gx = pad_l + (pw / 4) * i
                gy = pad_t + (ph / 4) * i
                parts.append(f'<line x1="{gx}" y1="{pad_t}" x2="{gx}" y2="{pad_t+ph}" stroke="#21262d" stroke-dasharray="3,3"/>')
                parts.append(f'<line x1="{pad_l}" y1="{gy}" x2="{pad_l+pw}" y2="{gy}" stroke="#21262d" stroke-dasharray="3,3"/>')

        parts.append(f'<line x1="{pad_l}" y1="{pad_t}" x2="{pad_l}" y2="{pad_t+ph}" stroke="#48515d" stroke-width="1.5"/>')
        parts.append(f'<line x1="{pad_l}" y1="{pad_t+ph}" x2="{pad_l+pw}" y2="{pad_t+ph}" stroke="#48515d" stroke-width="1.5"/>')

        if p.title_str:
            parts.append(f'<text x="{w/2}" y="22" fill="#e6edf3" font-size="13" font-weight="bold" text-anchor="middle">{p.title_str}</text>')
        if p.xlabel_str:
            parts.append(f'<text x="{pad_l+pw/2}" y="{h-10}" fill="#8b949e" font-size="11" text-anchor="middle">{p.xlabel_str}</text>')
        if p.ylabel_str:
            parts.append(f'<text x="16" y="{pad_t+ph/2}" fill="#8b949e" font-size="11" text-anchor="middle" transform="rotate(-90 16 {pad_t+ph/2})">{p.ylabel_str}</text>')

        for line in p.lines:
            pts = " ".join([f"{map_x(x):.1f},{map_y(y):.1f}" for x, y in zip(line['x'], line['y']) if isinstance(x, (int, float)) and isinstance(y, (int, float))])
            color = line['color']
            if color == 'blue': color = '#38bdf8'
            elif color == 'red': color = '#f87171'
            elif color == 'green': color = '#4ade80'
            elif color == 'yellow': color = '#facc15'
            parts.append(f'<polyline points="{pts}" fill="none" stroke="{color}" stroke-width="2.5" stroke-linecap="round"/>')

        parts.append('</svg>')
        return "".join(parts)

    _mpl = types.ModuleType('matplotlib')
    _mpl_plt = types.ModuleType('matplotlib.pyplot')
    _mpl_plt.plot = _plt_inst.plot
    _mpl_plt.scatter = _plt_inst.scatter
    _mpl_plt.bar = _plt_inst.bar
    _mpl_plt.title = _plt_inst.title
    _mpl_plt.xlabel = _plt_inst.xlabel
    _mpl_plt.ylabel = _plt_inst.ylabel
    _mpl_plt.grid = _plt_inst.grid
    _mpl_plt.legend = _plt_inst.legend
    _mpl_plt.figure = _plt_inst.figure
    _mpl_plt.clf = _plt_inst.clf
    _mpl_plt.close = _plt_inst.close
    _mpl_plt.show = _plt_inst.show
    _mpl_plt.get_fignums = _plt_inst.get_fignums
    _mpl.use = lambda *a, **kw: None
    _mpl.pyplot = _mpl_plt

    sys.modules['matplotlib'] = _mpl
    sys.modules['matplotlib.pyplot'] = _mpl_plt

    def _capture_plt():
        _plt_inst.show()

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

if _result_file:
    try:
        with open(_result_file, "w", encoding="utf-8") as _f:
            json.dump(payload, _f)
    except Exception:
        pass

print("===DUOFY_PY_RESULT_START===")
print(json.dumps(payload))
print("===DUOFY_PY_RESULT_END===")
''';
  }

  /// Checks if the bundled app.zip.hash asset has changed (e.g. after a new app update/build)
  /// and automatically purges the cached extracted directory to force a fresh re-extraction.
  Future<void> _checkAndSyncPythonAssets() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentHash = (await rootBundle.loadString('app/app.zip.hash')).trim();
      final lastExtractedHash = prefs.getString('last_python_asset_hash');
      if (lastExtractedHash != currentHash) {
        print('[PythonRunnerService] Asset hash changed ($lastExtractedHash -> $currentHash). Purging cached python assets...');
        final appDir = await getApplicationSupportDirectory();
        final netFletDir = Directory(path.join(appDir.path, 'net.flet.serious_python'));
        if (await netFletDir.exists()) {
          await netFletDir.delete(recursive: true);
        }
        await prefs.setString('last_python_asset_hash', currentHash);
      }
    } catch (e) {
      print('[PythonRunnerService] Asset hash check notice: $e');
    }
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
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final pyFile = File(path.join(tempDir.path, 'duofy_runner_$timestamp.py'));
      final resultFile = File(path.join(tempDir.path, 'duofy_py_out_$timestamp.json'));

      final wrapperCode = _prepareWrapperCode(
        code,
        serverPort: serverPort,
        inputs: inputs,
        resultFilePath: resultFile.path,
      );
      await pyFile.writeAsString(wrapperCode);

      ProcessResult? procResult;
      // Only use Process.run on Desktop operating systems.
      // Mobile platforms (Android / iOS) MUST use SeriousPython runtime.
      if (!Platform.isAndroid && !Platform.isIOS) {
        try {
          procResult = await Process.run('python3', [pyFile.path], workingDirectory: tempDir.path);
        } catch (_) {
          try {
            procResult = await Process.run('python', [pyFile.path], workingDirectory: tempDir.path);
          } catch (_) {}
        }
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
          await _checkAndSyncPythonAssets();
          final res = await SeriousPython.runProgram(pyFile.path, sync: false);
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

      // Priority 1: Read JSON result file produced by Python wrapper
      if (await resultFile.exists()) {
        try {
          final jsonContent = await resultFile.readAsString();
          final Map<String, dynamic> data = jsonDecode(jsonContent);
          stdOutText = data['stdout'] ?? '';
          final pyStderr = data['stderr'] ?? '';
          stdErrText = pyStderr.isNotEmpty
              ? pyStderr + (rawStderr.isNotEmpty ? '\n$rawStderr' : '')
              : rawStderr;
          graphics = List<String>.from(data['graphics'] ?? []);
        } catch (_) {}
        try {
          await resultFile.delete();
        } catch (_) {}
      } else if (rawStdout.contains("===DUOFY_PY_RESULT_START===")) {
        // Priority 2: Parse stdout delimiter
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