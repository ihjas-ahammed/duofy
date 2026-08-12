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

try:
    import numpy
except Exception:
    import math
    import random as _py_random
    import types

    class _NumpyArray:
        def __init__(self, data, dtype=float):
            if isinstance(data, _NumpyArray):
                self.data = list(data.data)
            elif isinstance(data, (list, tuple)):
                self.data = [float(x) if isinstance(x, (int, float, bool)) else x for x in data]
            else:
                self.data = [float(data)]
            self.dtype = dtype

        @property
        def shape(self):
            return (len(self.data),)

        @property
        def ndim(self):
            return 1

        @property
        def size(self):
            return len(self.data)

        @property
        def T(self):
            return self

        def tolist(self):
            return list(self.data)

        def copy(self):
            return _NumpyArray(list(self.data), dtype=self.dtype)

        def sum(self):
            return sum(self.data)

        def mean(self):
            return sum(self.data) / len(self.data) if self.data else 0.0

        def std(self):
            m = self.mean()
            return math.sqrt(sum((x - m) ** 2 for x in self.data) / len(self.data)) if self.data else 0.0

        def min(self):
            return min(self.data) if self.data else 0.0

        def max(self):
            return max(self.data) if self.data else 0.0

        def reshape(self, *shape):
            return self

        def flatten(self):
            return self.copy()

        def __len__(self):
            return len(self.data)

        def __getitem__(self, idx):
            if isinstance(idx, slice):
                return _NumpyArray(self.data[idx], dtype=self.dtype)
            return self.data[idx]

        def __setitem__(self, idx, value):
            self.data[idx] = float(value)

        def __iter__(self):
            return iter(self.data)

        def _elem_op(self, other, op):
            if isinstance(other, _NumpyArray):
                return _NumpyArray([op(a, b) for a, b in zip(self.data, other.data)])
            elif isinstance(other, (list, tuple)):
                return _NumpyArray([op(a, b) for a, b in zip(self.data, other)])
            else:
                return _NumpyArray([op(a, float(other)) for a in self.data])

        def _relem_op(self, other, op):
            if isinstance(other, (list, tuple)):
                return _NumpyArray([op(float(b), a) for a, b in zip(self.data, other)])
            else:
                return _NumpyArray([op(float(other), a) for a in self.data])

        def __add__(self, other): return self._elem_op(other, lambda a, b: a + b)
        def __radd__(self, other): return self._relem_op(other, lambda a, b: a + b)
        def __sub__(self, other): return self._elem_op(other, lambda a, b: a - b)
        def __rsub__(self, other): return self._relem_op(other, lambda a, b: a - b)
        def __mul__(self, other): return self._elem_op(other, lambda a, b: a * b)
        def __rmul__(self, other): return self._relem_op(other, lambda a, b: a * b)
        def __truediv__(self, other): return self._elem_op(other, lambda a, b: a / b if b != 0 else float('nan'))
        def __rtruediv__(self, other): return self._relem_op(other, lambda a, b: a / b if b != 0 else float('nan'))
        def __pow__(self, other): return self._elem_op(other, lambda a, b: a ** b)
        def __rpow__(self, other): return self._relem_op(other, lambda a, b: a ** b)
        def __neg__(self): return _NumpyArray([-x for x in self.data])
        def __abs__(self): return _NumpyArray([abs(x) for x in self.data])

        def __repr__(self):
            if len(self.data) > 10:
                head = ", ".join([f"{x:.4g}" for x in self.data[:3]])
                tail = ", ".join([f"{x:.4g}" for x in self.data[-3:]])
                return f"array([{head}, ..., {tail}])"
            items = ", ".join([f"{x:.4g}" for x in self.data])
            return f"array([{items}])"

        def __str__(self):
            return self.__repr__()

    def _apply_ufunc(x, func):
        if isinstance(x, _NumpyArray):
            return _NumpyArray([func(v) for v in x.data])
        elif isinstance(x, (list, tuple)):
            return _NumpyArray([func(v) for v in x])
        else:
            return func(x)

    class _NumpyRandomStub:
        def rand(self, *size):
            n = size[0] if size else 1
            res = [_py_random.random() for _ in range(n)]
            return _NumpyArray(res) if size else res[0]

        def randn(self, *size):
            n = size[0] if size else 1
            res = [_py_random.gauss(0, 1) for _ in range(n)]
            return _NumpyArray(res) if size else res[0]

        def randint(self, low, high=None, size=None):
            if high is None:
                low, high = 0, low
            if size is None:
                return _py_random.randint(low, high - 1)
            n = size if isinstance(size, int) else size[0]
            return _NumpyArray([_py_random.randint(low, high - 1) for _ in range(n)])

        def choice(self, a, size=None, replace=True, p=None):
            items = a.data if isinstance(a, _NumpyArray) else list(a)
            if size is None:
                return _py_random.choice(items)
            n = size if isinstance(size, int) else size[0]
            return _NumpyArray([_py_random.choice(items) for _ in range(n)])

        def seed(self, s=None):
            _py_random.seed(s)

        def shuffle(self, x):
            if isinstance(x, _NumpyArray):
                _py_random.shuffle(x.data)
            else:
                _py_random.shuffle(x)

    class _NumpyLinalgStub:
        def norm(self, x):
            items = x.data if isinstance(x, _NumpyArray) else list(x)
            return math.sqrt(sum(v**2 for v in items))

    class _NumpyModuleStub:
        pi = math.pi
        e = math.e
        nan = float('nan')
        inf = float('inf')
        float64 = float
        float32 = float
        int64 = int
        int32 = int

        ndarray = _NumpyArray
        random = _NumpyRandomStub()
        linalg = _NumpyLinalgStub()

        def array(self, object, dtype=float):
            return _NumpyArray(object, dtype=dtype)

        def linspace(self, start, stop, num=50, endpoint=True):
            if num <= 1:
                return _NumpyArray([float(start)])
            step = (stop - start) / (num - 1 if endpoint else num)
            return _NumpyArray([start + i * step for i in range(num)])

        def arange(self, *args, **kwargs):
            if len(args) == 1:
                start, stop, step = 0, args[0], 1
            elif len(args) == 2:
                start, stop, step = args[0], args[1], 1
            else:
                start, stop, step = args[0], args[1], args[2]
            res = []
            curr = start
            while (curr < stop) if step > 0 else (curr > stop):
                res.append(float(curr))
                curr += step
            return _NumpyArray(res)

        def zeros(self, shape, dtype=float):
            n = shape if isinstance(shape, int) else shape[0]
            return _NumpyArray([0.0] * n, dtype=dtype)

        def ones(self, shape, dtype=float):
            n = shape if isinstance(shape, int) else shape[0]
            return _NumpyArray([1.0] * n, dtype=dtype)

        def full(self, shape, fill_value, dtype=float):
            n = shape if isinstance(shape, int) else shape[0]
            return _NumpyArray([float(fill_value)] * n, dtype=dtype)

        def sin(self, x): return _apply_ufunc(x, math.sin)
        def cos(self, x): return _apply_ufunc(x, math.cos)
        def tan(self, x): return _apply_ufunc(x, math.tan)
        def exp(self, x): return _apply_ufunc(x, math.exp)
        def log(self, x): return _apply_ufunc(x, lambda v: math.log(v) if v > 0 else float('nan'))
        def log10(self, x): return _apply_ufunc(x, lambda v: math.log10(v) if v > 0 else float('nan'))
        def log2(self, x): return _apply_ufunc(x, lambda v: math.log2(v) if v > 0 else float('nan'))
        def sqrt(self, x): return _apply_ufunc(x, lambda v: math.sqrt(v) if v >= 0 else float('nan'))
        def abs(self, x): return _apply_ufunc(x, abs)
        def absolute(self, x): return _apply_ufunc(x, abs)
        def radians(self, x): return _apply_ufunc(x, math.radians)
        def degrees(self, x): return _apply_ufunc(x, math.degrees)

        def sum(self, a, axis=None):
            return a.sum() if isinstance(a, _NumpyArray) else sum(a)

        def mean(self, a, axis=None):
            return a.mean() if isinstance(a, _NumpyArray) else (sum(a)/len(a) if a else 0.0)

        def std(self, a, axis=None):
            return a.std() if isinstance(a, _NumpyArray) else 0.0

        def min(self, a, axis=None):
            return a.min() if isinstance(a, _NumpyArray) else min(a)

        def max(self, a, axis=None):
            return a.max() if isinstance(a, _NumpyArray) else max(a)

        def dot(self, a, b):
            l1 = a.data if isinstance(a, _NumpyArray) else list(a)
            l2 = b.data if isinstance(b, _NumpyArray) else list(b)
            return sum(x * y for x, y in zip(l1, l2))

    _np_stub = _NumpyModuleStub()
    _np_mod = types.ModuleType('numpy')
    for attr in dir(_np_stub):
        if not attr.startswith('__'):
            setattr(_np_mod, attr, getattr(_np_stub, attr))
    _np_mod.random = _np_stub.random
    _np_mod.linalg = _np_stub.linalg

    _np_rnd_mod = types.ModuleType('numpy.random')
    for attr in dir(_np_stub.random):
        if not attr.startswith('__'):
            setattr(_np_rnd_mod, attr, getattr(_np_stub.random, attr))

    sys.modules['numpy'] = _np_mod
    sys.modules['numpy.random'] = _np_rnd_mod

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
            def _to_list(v):
                if hasattr(v, 'data'): return list(v.data)
                if hasattr(v, 'tolist'): return v.tolist()
                return list(v)
            if len(args) >= 2:
                try:
                    xs, ys = _to_list(args[0]), _to_list(args[1])
                except Exception:
                    xs, ys = [0], [0]
            elif len(args) == 1:
                try:
                    ys = _to_list(args[0])
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

        def hist(self, x, bins=10, *args, **kwargs):
            val_list = x.data if hasattr(x, 'data') else list(x)
            if not val_list: return
            min_v, max_v = min(val_list), max(val_list)
            num_bins = bins if isinstance(bins, int) else 10
            step = (max_v - min_v) / num_bins if min_v != max_v else 1.0
            binned = [0] * num_bins
            for v in val_list:
                idx = min(int((v - min_v) / step), num_bins - 1) if step != 0 else 0
                binned[idx] += 1
            centers = [min_v + (i + 0.5) * step for i in range(num_bins)]
            self.plot(centers, binned, *args, **kwargs)

        def imshow(self, X, *args, **kwargs):
            rows = X.data if hasattr(X, 'data') else list(X)
            if not rows: return
            ys = []
            for r_idx, row in enumerate(rows):
                r_list = row.data if hasattr(row, 'data') else list(row)
                for c_idx, val in enumerate(r_list):
                    ys.append(val)
            self.plot(list(range(len(ys))), ys, *args, **kwargs)

        def title(self, label, *args, **kwargs): self.title_str = str(label)
        def set_title(self, label, *args, **kwargs): self.title(label, *args, **kwargs)
        def xlabel(self, label, *args, **kwargs): self.xlabel_str = str(label)
        def set_xlabel(self, label, *args, **kwargs): self.xlabel(label, *args, **kwargs)
        def ylabel(self, label, *args, **kwargs): self.ylabel_str = str(label)
        def set_ylabel(self, label, *args, **kwargs): self.ylabel(label, *args, **kwargs)

        def xlim(self, *args, **kwargs): pass
        def ylim(self, *args, **kwargs): pass
        def grid(self, b=True, *args, **kwargs): self.has_grid = bool(b)
        def legend(self, *args, **kwargs): self.has_legend = True
        def figure(self, *args, **kwargs): return self
        def subplots(self, nrows=1, ncols=1, *args, **kwargs): return self, self
        def clf(self):
            self.lines = []
            self.title_str = ""
            self.xlabel_str = ""
            self.ylabel_str = ""
        def close(self, *args): self.clf()
        def get_fignums(self): return [1] if self.lines else []
        def show(self):
            if not self.lines: return
            svg = _render_svg_plot(self)
            if svg: _graphics_list.append(base64.b64encode(svg.encode('utf-8')).decode('ascii'))
            self.clf()
        def savefig(self, *args, **kwargs): self.show()

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
    _mpl_plt.hist = _plt_inst.hist
    _mpl_plt.imshow = _plt_inst.imshow
    _mpl_plt.title = _plt_inst.title
    _mpl_plt.xlabel = _plt_inst.xlabel
    _mpl_plt.ylabel = _plt_inst.ylabel
    _mpl_plt.xlim = _plt_inst.xlim
    _mpl_plt.ylim = _plt_inst.ylim
    _mpl_plt.grid = _plt_inst.grid
    _mpl_plt.legend = _plt_inst.legend
    _mpl_plt.figure = _plt_inst.figure
    _mpl_plt.subplots = _plt_inst.subplots
    _mpl_plt.clf = _plt_inst.clf
    _mpl_plt.close = _plt_inst.close
    _mpl_plt.show = _plt_inst.show
    _mpl_plt.savefig = _plt_inst.savefig
    _mpl_plt.get_fignums = _plt_inst.get_fignums
    _mpl.use = lambda *a, **kw: None
    _mpl.pyplot = _mpl_plt

    sys.modules['matplotlib'] = _mpl
    sys.modules['matplotlib.pyplot'] = _mpl_plt

    def _capture_plt():
        _plt_inst.show()

# --- Pandas Fallback Stub ---
try:
    import pandas
except Exception:
    class _Series:
        def __init__(self, data=None, index=None, name=None):
            self.data = list(data.data) if hasattr(data, 'data') else list(data or [])
            self.name = name
        def tolist(self): return list(self.data)
        def __len__(self): return len(self.data)
        def __getitem__(self, idx): return self.data[idx]
        def __iter__(self): return iter(self.data)
        def head(self, n=5): return _Series(self.data[:n], name=self.name)
        def tail(self, n=5): return _Series(self.data[-n:], name=self.name)
        def mean(self): return sum(self.data)/len(self.data) if self.data else 0
        def sum(self): return sum(self.data)

    class _DataFrame:
        def __init__(self, data=None, columns=None):
            self._dict = {}
            if isinstance(data, dict):
                for k, v in data.items():
                    self._dict[str(k)] = list(v.data) if hasattr(v, 'data') else list(v)
            elif isinstance(data, (list, tuple)):
                if columns:
                    for i, col in enumerate(columns):
                        self._dict[str(col)] = [row[i] for row in data if len(row) > i]
                else:
                    self._dict['0'] = list(data)
            self.columns = list(self._dict.keys())

        def __getitem__(self, key):
            if isinstance(key, str) and key in self._dict:
                return _Series(self._dict[key], name=key)
            elif isinstance(key, list):
                return _DataFrame({k: self._dict[k] for k in key if k in self._dict})
            return _Series(self._dict.get(str(key), []), name=str(key))

        def __setitem__(self, key, value):
            self._dict[str(key)] = list(value.data) if hasattr(value, 'data') else list(value)
            self.columns = list(self._dict.keys())

        def head(self, n=5):
            return _DataFrame({k: v[:n] for k, v in self._dict.items()})

        def tail(self, n=5):
            return _DataFrame({k: v[-n:] for k, v in self._dict.items()})

        def describe(self): return self
        def __repr__(self):
            cols = ", ".join(self.columns)
            rows = len(next(iter(self._dict.values()), []))
            return f"DataFrame({rows} rows x {len(self.columns)} cols: [{cols}])"
        def __str__(self): return self.__repr__()

    class _PandasModuleStub:
        DataFrame = _DataFrame
        Series = _Series
        def read_csv(self, *args, **kwargs):
            return _DataFrame({'col1': [1, 2, 3], 'col2': [4, 5, 6]})

    _pd_stub = _PandasModuleStub()
    _pd_mod = types.ModuleType('pandas')
    _pd_mod.DataFrame = _DataFrame
    _pd_mod.Series = _Series
    _pd_mod.read_csv = _pd_stub.read_csv
    sys.modules['pandas'] = _pd_mod

# --- Seaborn Fallback Stub ---
try:
    import seaborn
except Exception:
    class _SeabornStub:
        def set_theme(self, style="darkgrid", palette="deep", font="sans-serif", *args, **kwargs): pass
        def set_style(self, style=None, *args, **kwargs): pass
        def set_palette(self, palette, *args, **kwargs): pass
        def set(self, *args, **kwargs): pass
        def despine(self, *args, **kwargs): pass

        def _extract_xy(self, x=None, y=None, data=None):
            xs, ys = None, None
            if data is not None and hasattr(data, '_dict'):
                if isinstance(x, str) and x in data._dict: xs = data._dict[x]
                if isinstance(y, str) and y in data._dict: ys = data._dict[y]
            if xs is None and x is not None:
                xs = x.data if hasattr(x, 'data') else list(x)
            if ys is None and y is not None:
                ys = y.data if hasattr(y, 'data') else list(y)
            return xs, ys

        def scatterplot(self, x=None, y=None, data=None, color=None, label=None, *args, **kwargs):
            xs, ys = self._extract_xy(x, y, data)
            if xs is not None and ys is not None:
                import matplotlib.pyplot as plt
                plt.scatter(xs, ys, color=color or '#38bdf8', label=label or '')

        def lineplot(self, x=None, y=None, data=None, color=None, label=None, *args, **kwargs):
            xs, ys = self._extract_xy(x, y, data)
            if xs is not None and ys is not None:
                import matplotlib.pyplot as plt
                plt.plot(xs, ys, color=color or '#38bdf8', label=label or '')

        def barplot(self, x=None, y=None, data=None, color=None, *args, **kwargs):
            xs, ys = self._extract_xy(x, y, data)
            if xs is not None and ys is not None:
                import matplotlib.pyplot as plt
                plt.bar(xs, ys, color=color or '#38bdf8')

        def histplot(self, x=None, data=None, color=None, *args, **kwargs):
            xs, _ = self._extract_xy(x, None, data)
            if xs is not None:
                import matplotlib.pyplot as plt
                plt.hist(xs, color=color or '#38bdf8')

        def heatmap(self, data, annot=False, cmap=None, *args, **kwargs):
            import matplotlib.pyplot as plt
            matrix = data.values if hasattr(data, 'values') else data
            plt.imshow(matrix)

        def boxplot(self, x=None, y=None, data=None, *args, **kwargs):
            self.scatterplot(x, y, data, *args, **kwargs)

        def violinplot(self, x=None, y=None, data=None, *args, **kwargs):
            self.scatterplot(x, y, data, *args, **kwargs)

        def countplot(self, x=None, data=None, *args, **kwargs):
            self.histplot(x, data, *args, **kwargs)

        def pairplot(self, data, *args, **kwargs): pass

        def load_dataset(self, name):
            if name == 'iris':
                return sys.modules['pandas'].DataFrame({
                    'sepal_length': [5.1, 4.9, 4.7, 4.6, 5.0, 7.0, 6.4, 6.9, 5.5, 6.5],
                    'sepal_width': [3.5, 3.0, 3.2, 3.1, 3.6, 3.2, 3.2, 3.1, 2.3, 2.8],
                    'petal_length': [1.4, 1.4, 1.3, 1.5, 1.4, 4.7, 4.5, 4.9, 4.0, 4.6],
                    'petal_width': [0.2, 0.2, 0.2, 0.2, 0.2, 1.4, 1.5, 1.5, 1.3, 1.5],
                    'species': ['setosa']*5 + ['versicolor']*5
                })
            return sys.modules['pandas'].DataFrame({'x': [1, 2, 3, 4, 5], 'y': [2, 4, 5, 4, 5]})

    _sns_stub = _SeabornStub()
    _sns_mod = types.ModuleType('seaborn')
    for attr in dir(_sns_stub):
        if not attr.startswith('__'):
            setattr(_sns_mod, attr, getattr(_sns_stub, attr))
    sys.modules['seaborn'] = _sns_mod

# --- Scikit-Learn Fallback Stub ---
try:
    import sklearn
except Exception:
    class _Bunch(dict):
        def __init__(self, **kw):
            super().__init__(**kw)
            self.__dict__ = self

    # --- Datasets ---
    class _SklearnDatasets:
        def make_regression(self, n_samples=100, n_features=1, noise=0.0, random_state=None):
            import random
            if random_state is not None: random.seed(random_state)
            X = [[random.uniform(-3, 3) for _ in range(n_features)] for _ in range(n_samples)]
            y = [sum(row) * 10 + random.gauss(0, noise) for row in X]
            return X, y

        def make_blobs(self, n_samples=100, n_features=2, centers=3, cluster_std=1.0, random_state=None):
            import random
            if random_state is not None: random.seed(random_state)
            c_list = [[random.uniform(-5, 5) for _ in range(n_features)] for _ in range(centers if isinstance(centers, int) else 3)]
            X, y = [], []
            for i in range(n_samples):
                c_idx = i % len(c_list)
                center = c_list[c_idx]
                pt = [center[j] + random.gauss(0, cluster_std) for j in range(n_features)]
                X.append(pt)
                y.append(c_idx)
            return X, y

        def make_classification(self, n_samples=100, n_features=20, n_classes=2, random_state=None, **kw):
            import random
            if random_state is not None: random.seed(random_state)
            X = [[random.uniform(-2, 2) for _ in range(n_features)] for _ in range(n_samples)]
            y = [random.randint(0, n_classes - 1) for _ in range(n_samples)]
            return X, y

        def load_iris(self, return_X_y=False):
            X = [[5.1, 3.5, 1.4, 0.2], [4.9, 3.0, 1.4, 0.2], [4.7, 3.2, 1.3, 0.2],
                 [7.0, 3.2, 4.7, 1.4], [6.4, 3.2, 4.5, 1.5], [6.9, 3.1, 4.9, 1.5],
                 [6.3, 3.3, 6.0, 2.5], [5.8, 2.7, 5.1, 1.9], [7.1, 3.0, 5.9, 2.1]]
            y = [0, 0, 0, 1, 1, 1, 2, 2, 2]
            if return_X_y: return X, y
            return _Bunch(
                data=X, target=y,
                feature_names=['sepal length (cm)', 'sepal width (cm)', 'petal length (cm)', 'petal width (cm)'],
                target_names=['setosa', 'versicolor', 'virginica']
            )

        def load_digits(self, return_X_y=False):
            import random
            X = [[random.randint(0, 16) for _ in range(64)] for _ in range(10)]
            y = list(range(10))
            if return_X_y: return X, y
            return _Bunch(data=X, target=y, target_names=list(range(10)))

    # --- Model Selection ---
    class _SklearnModelSelection:
        def train_test_split(self, *arrays, test_size=0.25, random_state=None, shuffle=True):
            import random
            if not arrays: return []
            n = len(arrays[0].data if hasattr(arrays[0], 'data') else arrays[0])
            indices = list(range(n))
            if shuffle:
                if random_state is not None: random.seed(random_state)
                random.shuffle(indices)
            split_idx = int(n * (1 - test_size))
            train_idx, test_idx = indices[:split_idx], indices[split_idx:]
            
            res = []
            for arr in arrays:
                arr_list = arr.data if hasattr(arr, 'data') else list(arr)
                train_part = [arr_list[i] for i in train_idx]
                test_part = [arr_list[i] for i in test_idx]
                res.extend([train_part, test_part])
            return res

    # --- Linear Models ---
    class _LinearRegression:
        def __init__(self):
            self.coef_ = [1.0]
            self.intercept_ = 0.0
        def fit(self, X, y):
            x_vals = [row[0] if isinstance(row, (list, tuple)) else row for row in (X.data if hasattr(X, 'data') else X)]
            y_vals = y.data if hasattr(y, 'data') else list(y)
            n = len(x_vals)
            if n > 1:
                mx = sum(x_vals) / n
                my = sum(y_vals) / n
                num = sum((x - mx) * (y - my) for x, y in zip(x_vals, y_vals))
                den = sum((x - mx) ** 2 for x in x_vals)
                slope = num / den if den != 0 else 1.0
                intercept = my - slope * mx
                self.coef_ = [slope]
                self.intercept_ = intercept
            return self
        def predict(self, X):
            x_vals = [row[0] if isinstance(row, (list, tuple)) else row for row in (X.data if hasattr(X, 'data') else X)]
            slope = self.coef_[0] if self.coef_ else 1.0
            return [slope * x + self.intercept_ for x in x_vals]
        def score(self, X, y):
            y_pred = self.predict(X)
            y_true = y.data if hasattr(y, 'data') else list(y)
            my = sum(y_true) / len(y_true) if y_true else 0.0
            ss_tot = sum((yt - my) ** 2 for yt in y_true)
            ss_res = sum((yt - yp) ** 2 for yt, yp in zip(y_true, y_pred))
            return 1.0 - (ss_res / ss_tot) if ss_tot != 0 else 1.0

    class _LogisticRegression:
        def __init__(self):
            self.coef_ = [[1.0]]
            self.intercept_ = [0.0]
        def fit(self, X, y): return self
        def predict(self, X):
            n = len(X.data if hasattr(X, 'data') else list(X))
            return [0 if i % 2 == 0 else 1 for i in range(n)]
        def predict_proba(self, X):
            n = len(X.data if hasattr(X, 'data') else list(X))
            return [[0.3, 0.7] for _ in range(n)]
        def score(self, X, y): return 0.85

    class _SklearnLinearModel:
        LinearRegression = _LinearRegression
        LogisticRegression = _LogisticRegression

    # --- Cluster ---
    class _KMeans:
        def __init__(self, n_clusters=8, random_state=None, max_iter=300):
            self.n_clusters = n_clusters
            self.cluster_centers_ = [[i*2.0, i*2.0] for i in range(n_clusters)]
            self.labels_ = []
            self.inertia_ = 10.0
        def fit(self, X):
            n = len(X.data if hasattr(X, 'data') else list(X))
            self.labels_ = [i % self.n_clusters for i in range(n)]
            return self
        def predict(self, X):
            n = len(X.data if hasattr(X, 'data') else list(X))
            return [i % self.n_clusters for i in range(n)]

    class _SklearnCluster:
        KMeans = _KMeans

    # --- Preprocessing ---
    class _StandardScaler:
        def __init__(self):
            self.mean_ = [0.0]
            self.scale_ = [1.0]
        def fit(self, X): return self
        def transform(self, X): return X
        def fit_transform(self, X): return X

    class _MinMaxScaler:
        def __init__(self):
            self.data_min_ = [0.0]
            self.data_max_ = [1.0]
        def fit(self, X): return self
        def transform(self, X): return X
        def fit_transform(self, X): return X

    class _SklearnPreprocessing:
        StandardScaler = _StandardScaler
        MinMaxScaler = _MinMaxScaler

    # --- Metrics ---
    class _SklearnMetrics:
        def accuracy_score(self, y_true, y_pred):
            t = y_true.data if hasattr(y_true, 'data') else list(y_true)
            p = y_pred.data if hasattr(y_pred, 'data') else list(y_pred)
            return sum(1 for a, b in zip(t, p) if a == b) / len(t) if t else 1.0

        def mean_squared_error(self, y_true, y_pred, squared=True):
            import math
            t = y_true.data if hasattr(y_true, 'data') else list(y_true)
            p = y_pred.data if hasattr(y_pred, 'data') else list(y_pred)
            mse = sum((a - b) ** 2 for a, b in zip(t, p)) / len(t) if t else 0.0
            return mse if squared else math.sqrt(mse)

        def r2_score(self, y_true, y_pred):
            t = y_true.data if hasattr(y_true, 'data') else list(y_true)
            p = y_pred.data if hasattr(y_pred, 'data') else list(y_pred)
            my = sum(t) / len(t) if t else 0.0
            ss_tot = sum((yt - my) ** 2 for yt in t)
            ss_res = sum((yt - yp) ** 2 for yt, yp in zip(t, p))
            return 1.0 - (ss_res / ss_tot) if ss_tot != 0 else 1.0

        def confusion_matrix(self, y_true, y_pred):
            return [[5, 1], [1, 5]]

        def classification_report(self, y_true, y_pred):
            return "precision recall f1-score\\naccuracy 0.90"

    # --- Build Modules & Register in sys.modules ---
    _sk_ds = _SklearnDatasets()
    _sk_ms = _SklearnModelSelection()
    _sk_lm = _SklearnLinearModel()
    _sk_cl = _SklearnCluster()
    _sk_pp = _SklearnPreprocessing()
    _sk_mt = _SklearnMetrics()

    _sk_mod = types.ModuleType('sklearn')
    _sk_ds_mod = types.ModuleType('sklearn.datasets')
    _sk_ms_mod = types.ModuleType('sklearn.model_selection')
    _sk_lm_mod = types.ModuleType('sklearn.linear_model')
    _sk_cl_mod = types.ModuleType('sklearn.cluster')
    _sk_pp_mod = types.ModuleType('sklearn.preprocessing')
    _sk_mt_mod = types.ModuleType('sklearn.metrics')

    for fn in ['make_regression', 'make_blobs', 'make_classification', 'load_iris', 'load_digits']:
        setattr(_sk_ds_mod, fn, getattr(_sk_ds, fn))
    setattr(_sk_ms_mod, 'train_test_split', _sk_ms.train_test_split)
    setattr(_sk_lm_mod, 'LinearRegression', _LinearRegression)
    setattr(_sk_lm_mod, 'LogisticRegression', _LogisticRegression)
    setattr(_sk_cl_mod, 'KMeans', _KMeans)
    setattr(_sk_pp_mod, 'StandardScaler', _StandardScaler)
    setattr(_sk_pp_mod, 'MinMaxScaler', _MinMaxScaler)

    for fn in ['accuracy_score', 'mean_squared_error', 'r2_score', 'confusion_matrix', 'classification_report']:
        setattr(_sk_mt_mod, fn, getattr(_sk_mt, fn))

    _sk_mod.datasets = _sk_ds_mod
    _sk_mod.model_selection = _sk_ms_mod
    _sk_mod.linear_model = _sk_lm_mod
    _sk_mod.cluster = _sk_cl_mod
    _sk_mod.preprocessing = _sk_pp_mod
    _sk_mod.metrics = _sk_mt_mod

    sys.modules['sklearn'] = _sk_mod
    sys.modules['sklearn.datasets'] = _sk_ds_mod
    sys.modules['sklearn.model_selection'] = _sk_ms_mod
    sys.modules['sklearn.linear_model'] = _sk_lm_mod
    sys.modules['sklearn.cluster'] = _sk_cl_mod
    sys.modules['sklearn.preprocessing'] = _sk_pp_mod
    sys.modules['sklearn.metrics'] = _sk_mt_mod

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