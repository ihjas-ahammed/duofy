import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../models/app_models.dart';
import '../../services/ai_service.dart';
import '../../services/code_storage_service.dart';
import '../../services/ide_settings_service.dart';
import '../../services/fb/fb_auth.dart';
import '../../theme/app_theme.dart';
import '../../widgets/code_highlighter.dart';
import '../../widgets/ide_config_dialog.dart';
import '../reference_pdf_viewer_screen.dart';

class LatexIdeScreen extends StatefulWidget {
  final IdeProject? existingProject;

  const LatexIdeScreen({super.key, this.existingProject});

  @override
  State<LatexIdeScreen> createState() => _LatexIdeScreenState();
}

class _LatexIdeScreenState extends State<LatexIdeScreen> {
  late String _projectId;
  late TextEditingController _titleController;
  late CodeEditingController _texController;
  bool _isSaving = false;

  static String get _authorName {
    final u = FbAuth.instance.currentUser;
    if (u != null && u.displayName != null && u.displayName!.trim().isNotEmpty) {
      return u.displayName!.trim();
    }
    return 'Flow Learner';
  }

  Map<String, String> get _templates => {
    'Hello World': r'''\documentclass{article}
\begin{document}

\title{Hello World}
\author{''' + _authorName + r'''}
\maketitle

\section{Introduction}
Hello World! Welcome to LaTeX typesetting \cite{lamport1994}.

\section{Mathematics}
Here is a simple equation:
\[ E = mc^2 \]

\begin{thebibliography}{99}
\bibitem{lamport1994}
Lamport, L. (1994). \textit{\LaTeX: A Document Preparation System}. Addison-Wesley.
\end{thebibliography}

\end{document}''',

    'Indexed Book (makeidx)': r'''\documentclass{article}
\usepackage{makeidx}
\makeindex

\begin{document}

\title{Computer Science \& AI Index Guide}
\author{''' + _authorName + r'''}
\date{\today}
\maketitle

\section{Algorithms \& Complexity}
An \index{Algorithm} algorithm is a step-by-step method for solving computation problems \cite{knuth1997}.
We evaluate performance using \index{Time Complexity} time complexity and \index{Space Complexity} space complexity bounds.

\section{Artificial Intelligence}
Modern \index{Neural Network} neural networks enable automated pattern recognition in \index{Artificial Intelligence} artificial intelligence systems \cite{goodfellow2016}.
Optimization uses \index{Gradient Descent} gradient descent algorithms with \index{Backpropagation} backpropagation.

\printindex

\begin{thebibliography}{99}
\bibitem{knuth1997}
Knuth, D. E. (1997). \textit{The Art of Computer Programming}. Addison-Wesley.
\bibitem{goodfellow2016}
Goodfellow, I., Bengio, Y., \& Courville, A. (2016). \textit{Deep Learning}. MIT Press.
\end{thebibliography}

\end{document}''',

    'Academic Paper': r'''\documentclass[11pt,a4paper]{article}
\usepackage[utf8]{inputenc}
\usepackage{amsmath,amssymb,amsfonts}
\usepackage{graphicx}
\usepackage{hyperref}

\begin{document}

\title{\textbf{Advanced Deep Learning \& Neural Architectures}}
\author{\textbf{''' + _authorName + r'''} \\ Department of Computer Science}
\date{\today}
\maketitle

\begin{abstract}
This paper presents a formal analysis of neural network optimization and mathematical foundations of deep representation learning. We explore convergence bounds and empirical performance.
\end{abstract}

\section{Introduction}
Modern machine learning models rely heavily on loss minimization \cite{goodfellow2016}. Given a dataset $\mathcal{D} = \{(x_i, y_i)\}_{i=1}^N$, we optimize the loss function:
\begin{equation}
\mathcal{L}(\theta) = \frac{1}{N} \sum_{i=1}^N \ell(f(x_i; \theta), y_i) + \lambda \|\theta\|^2_2
\end{equation}

\section{Mathematical Foundations}
The gradient update rule for stochastic gradient descent with momentum is defined as:
\begin{align}
v_{t+1} &= \beta v_t + (1 - \beta) \nabla_\theta \mathcal{L}(\theta_t) \\
\theta_{t+1} &= \theta_t - \alpha v_{t+1}
\end{align}

\section{Matrix Operations}
Consider the transformation matrix $A \in \mathbb{R}^{3 \times 3}$:
\[
A = \begin{bmatrix}
\cos\theta & -\sin\theta & 0 \\
\sin\theta & \cos\theta & 0 \\
0 & 0 & 1
\end{bmatrix}
\]

\begin{thebibliography}{99}
\bibitem{goodfellow2016}
Goodfellow, I., Bengio, Y., \& Courville, A. (2016). \textit{Deep Learning}. MIT Press.
\bibitem{vaswani2017}
Vaswani, A., et al. (2017). \textit{Attention Is All You Need}. Advances in Neural Information Processing Systems.
\end{thebibliography}

\end{document}''',

    'Math & Physics': r'''\documentclass[12pt]{article}
\usepackage{amsmath,amssymb,amsthm}

\newtheorem{theorem}{Theorem}

\begin{document}

\title{Mathematical Theorems \& Physics Formulas}
\author{''' + _authorName + r'''}
\date{\today}
\maketitle

\section{Fundamental Theorems}
\begin{theorem}[Euler's Identity]
For any real number $\pi$, the relation holds \cite{euler1748}:
\[ e^{i\pi} + 1 = 0 \]
\end{theorem}

\section{Maxwell's Equations}
In electrodynamics, Maxwell's equations in differential form are \cite{maxwell1865}:
\begin{align*}
\nabla \cdot \mathbf{E} &= \frac{\rho}{\varepsilon_0} \\
\nabla \cdot \mathbf{B} &= 0 \\
\nabla \times \mathbf{E} &= -\frac{\partial \mathbf{B}}{\partial t} \\
\nabla \times \mathbf{B} &= \mu_0 \mathbf{J} + \mu_0 \varepsilon_0 \frac{\partial \mathbf{E}}{\partial t}
\end{align*}

\section{Integrals \& Series}
The Gaussian integral evaluation:
\[ \int_{-\infty}^{\infty} e^{-x^2} \, dx = \sqrt{\pi} \]

\begin{thebibliography}{99}
\bibitem{euler1748}
Euler, L. (1748). \textit{Introductio in analysin infinitorum}.
\bibitem{maxwell1865}
Maxwell, J. C. (1865). A dynamical theory of the electromagnetic field. \textit{Philosophical Transactions}.
\end{thebibliography}

\end{document}''',

    'Beamer Slides': r'''\documentclass{beamer}
\usetheme{Madrid}
\usecolortheme{beaver}

\begin{document}

\title{Quantum Computing Overview}
\subtitle{Principles \& Applications}
\author{''' + _authorName + r'''}
\institute{Flow Learning}
\date{\today}

\frame{\titlepage}

\begin{frame}{Introduction to Qubits}
\begin{block}{Qubit State}
A single qubit state $|\psi\rangle$ is a linear combination of basis states $|0\rangle$ and $|1\rangle$ \cite{nielsen2010}:
\[ |\psi\rangle = \alpha |0\rangle + \beta |1\rangle \]
where $|\alpha|^2 + |\beta|^2 = 1$.
\end{block}

\begin{itemize}
  \item \textbf{Superposition}: Ability to exist in multiple states simultaneously.
  \item \textbf{Entanglement}: Strong correlation between paired qubits.
\end{itemize}
\end{frame}

\begin{thebibliography}{99}
\bibitem{nielsen2010}
Nielsen, M. A., \& Chuang, I. L. (2010). \textit{Quantum Computation and Quantum Information}. Cambridge University Press.
\end{thebibliography}

\end{document}''',

    'Resume / CV': r'''\documentclass[11pt,a4paper]{article}
\usepackage{hyperref}

\begin{document}

\begin{center}
{\Huge \textbf{''' + _authorName + r'''}} \\
Email: learner@example.com | GitHub: github.com/flow
\end{center}

\vspace{10pt}

\section*{Education}
\textbf{Bachelor of Science in Computer Science} \hfill 2022 -- 2026 \\
Flow University \hfill GPA: 3.92/4.0

\section*{Publications}
\begin{itemize}
  \item High-throughput TeX Parsing and WebAssembly Render Optimization \cite{flow2026}.
\end{itemize}

\begin{thebibliography}{99}
\bibitem{flow2026}
Flow Research. (2026). Client-side WebAssembly TeX compilation engine. \textit{Duofy Systems}.
\end{thebibliography}

\end{document}''',
  };

  Timer? _autosaveTimer;

  @override
  void initState() {
    super.initState();
    _projectId = widget.existingProject?.id ??
        'tex-${DateTime.now().millisecondsSinceEpoch}';
    _titleController = TextEditingController(
      text: widget.existingProject?.title ?? 'LaTeX Studio',
    );

    final existingCode = widget.existingProject?.codeContent ?? '';
    _texController = CodeEditingController(
      text: existingCode.isNotEmpty ? existingCode : _templates['Hello World']!,
      language: 'latex',
    );

    _texController.addListener(_onTextChanged);
    _titleController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _autosaveTimer?.cancel();
    _texController.removeListener(_onTextChanged);
    _titleController.removeListener(_onTextChanged);
    _titleController.dispose();
    _texController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    _autosaveTimer?.cancel();
    _autosaveTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _saveProject(silent: true);
      }
    });
  }

  void _loadTemplate(String name) {
    if (_templates.containsKey(name)) {
      setState(() {
        _texController.text = _templates[name]!;
      });
    }
  }

  Future<void> _openPdfPreview() async {
    final title = _titleController.text.trim().isEmpty
        ? 'LaTeX Studio'
        : _titleController.text.trim();
    final texCode = _texController.text;

    FocusScope.of(context).unfocus();
    _saveProject(silent: true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              const CircularProgressIndicator(color: AppTheme.duoGreen),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Compiling LaTeX PDF...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Connecting to online TeX Live API...',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colors.textFaint,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    bool isOnlineSuccess = false;
    bool isNetworkUnavailable = false;
    String? onlineErrorMessage;

    try {
      // 1. Primary: POST request with JSON payload to https://latex.ytotech.com/builds/sync
      // This completely overcomes HTTP GET / URL length limits (compiles documents of any size).
      final response = await http.post(
        Uri.parse('https://latex.ytotech.com/builds/sync'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'compiler': 'pdflatex',
          'resources': [
            {'main': true, 'content': texCode}
          ]
        }),
      ).timeout(const Duration(seconds: 35));

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.bodyBytes.length > 100 &&
          response.bodyBytes[0] == 37 &&
          response.bodyBytes[1] == 80) { // %PDF
        isOnlineSuccess = true;

        final tempDir = await getTemporaryDirectory();
        final sanitizedTitle = title
            .replaceAll(RegExp(r'[^\w\s-]'), '_')
            .replaceAll(' ', '_');
        final filePath = '${tempDir.path}/${sanitizedTitle}_compiled.pdf';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        if (mounted) Navigator.of(context).pop(); // Dismiss loading dialog

        await _openPdfInViewer(file.path, title, 'Compiled TeX Live Output PDF');
      } else {
        final rawBody = utf8.decode(response.bodyBytes, allowMalformed: true).trim();
        String extractedLog = rawBody;
        try {
          final decoded = jsonDecode(rawBody);
          if (decoded is Map) {
            final logFiles = decoded['log_files'];
            if (logFiles is Map && logFiles.isNotEmpty) {
              extractedLog = logFiles.values.first.toString();
            } else if (decoded['logs'] != null && decoded['logs'].toString().isNotEmpty) {
              extractedLog = decoded['logs'].toString();
            } else if (decoded['error'] != null) {
              extractedLog = decoded['error'].toString();
            }
          }
        } catch (_) {}

        // If primary returned a 5xx server failure and texCode is small, try fallback
        if (response.statusCode >= 500 && texCode.length < 2500) {
          try {
            final encodedTex = Uri.encodeComponent(texCode);
            final fallbackUri = Uri.parse('https://latexonline.cc/compile?text=$encodedTex');
            final fallbackResp = await http.get(fallbackUri).timeout(const Duration(seconds: 20));
            if (fallbackResp.statusCode == 200 &&
                fallbackResp.bodyBytes.length > 100 &&
                fallbackResp.bodyBytes[0] == 37 &&
                fallbackResp.bodyBytes[1] == 80) {
              isOnlineSuccess = true;
              final tempDir = await getTemporaryDirectory();
              final sanitizedTitle = title
                  .replaceAll(RegExp(r'[^\w\s-]'), '_')
                  .replaceAll(' ', '_');
              final filePath = '${tempDir.path}/${sanitizedTitle}_compiled.pdf';
              final file = File(filePath);
              await file.writeAsBytes(fallbackResp.bodyBytes);

              if (mounted) Navigator.of(context).pop();
              await _openPdfInViewer(file.path, title, 'Compiled TeX Live Output PDF');
              return;
            }
          } catch (_) {}
        }

        onlineErrorMessage = extractedLog.isNotEmpty
            ? extractedLog
            : 'Server returned HTTP status ${response.statusCode} with an empty body.';

        if (mounted) Navigator.of(context).pop();
      }
    } on SocketException catch (_) {
      isNetworkUnavailable = true;
      if (mounted) Navigator.of(context).pop();
    } on TimeoutException catch (_) {
      isNetworkUnavailable = true;
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      final errStr = e.toString().toLowerCase();
      if (errStr.contains('socket') ||
          errStr.contains('network') ||
          errStr.contains('clientexception') ||
          errStr.contains('failed to connect') ||
          errStr.contains('unreachable')) {
        isNetworkUnavailable = true;
      } else {
        onlineErrorMessage = e.toString();
      }
      if (mounted) Navigator.of(context).pop();
    }

    if (!isOnlineSuccess) {
      if (isNetworkUnavailable) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Network unavailable: Generating offline LaTeX document...'),
              backgroundColor: AppTheme.duoViolet,
              duration: Duration(seconds: 3),
            ),
          );
        }

        try {
          final offlineFile = await _generateOfflinePdf(title, texCode);
          await _openPdfInViewer(offlineFile.path, '$title (Offline)', 'Offline Generated LaTeX PDF');
        } catch (offlineErr) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Offline LaTeX generation error: $offlineErr'),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        }
      } else if (onlineErrorMessage != null && mounted) {
        _showCompilationErrorDialog(onlineErrorMessage, texCode);
      }
    }
  }

  Future<void> _saveProject({bool silent = false}) async {
    if (!_isSaving && mounted) {
      setState(() {
        _isSaving = true;
      });
    }

    final project = IdeProject(
      id: _projectId,
      title: _titleController.text.trim().isEmpty
          ? 'LaTeX Studio'
          : _titleController.text.trim(),
      type: 'latex_ide',
      language: 'latex',
      codeContent: _texController.text,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await CodeStorageService.instance.saveProject(project);

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
      if (!silent) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('LaTeX Project saved!'),
            backgroundColor: AppTheme.duoGreen,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: IdeSettingsService.instance,
      builder: (context, _) {
        final settings = IdeSettingsService.instance.settings;
        final appIsDark = context.colors.isDark;
        final isDark = settings.forceDarkMode ?? appIsDark;

        _texController.theme = isDark ? CodeTheme.dark : CodeTheme.light;

        return CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.enter, control: true): _openPdfPreview,
            const SingleActivator(LogicalKeyboardKey.enter, meta: true): _openPdfPreview,
          },
          child: Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: _titleController,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'LaTeX Title...',
                  isDense: true,
                ),
              ),
              actions: [
                // Play Icon Button Only (Normal Icon Button)
                IconButton(
                  icon: const Icon(LucideIcons.play, color: AppTheme.duoGreen, size: 20),
                  tooltip: 'Run / Preview PDF',
                  onPressed: _openPdfPreview,
                ),
                // Single Menu Button for ALL options to save space
                PopupMenuButton<String>(
                  icon: const Icon(LucideIcons.moreVertical, size: 20),
                  tooltip: 'More Options',
                  onSelected: (val) {
                    if (val.startsWith('template:')) {
                      _loadTemplate(val.replaceFirst('template:', ''));
                    } else if (val == 'settings') {
                      IdeConfigDialog.show(context);
                    } else if (val == 'save') {
                      _saveProject(silent: false);
                    }
                  },
                  itemBuilder: (ctx) => [
                    PopupMenuItem(
                      value: 'save',
                      child: Row(
                        children: [
                          Icon(_isSaving ? LucideIcons.loader : LucideIcons.save, size: 16, color: AppTheme.duoGreen),
                          const SizedBox(width: 10),
                          const Text('Save Document'),
                          const Spacer(),
                          const Text('Autosave On', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      enabled: false,
                      child: Text('LOAD TEMPLATE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ),
                    const PopupMenuItem(
                      value: 'template:Hello World',
                      child: Row(
                        children: [
                          Icon(LucideIcons.fileText, size: 16, color: AppTheme.duoGreen),
                          SizedBox(width: 8),
                          Text('Hello World (Minimal)'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'template:Indexed Book (makeidx)',
                      child: Row(
                        children: [
                          Icon(LucideIcons.bookmark, size: 16, color: AppTheme.duoViolet),
                          SizedBox(width: 8),
                          Text('Indexed Book (makeidx Package)'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'template:Academic Paper',
                      child: Row(
                        children: [
                          Icon(LucideIcons.bookOpen, size: 16, color: AppTheme.duoBlue),
                          SizedBox(width: 8),
                          Text('Academic Paper'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'template:Math & Physics',
                      child: Row(
                        children: [
                          Icon(LucideIcons.zap, size: 16, color: AppTheme.duoViolet),
                          SizedBox(width: 8),
                          Text('Math & Physics Formulas'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'template:Beamer Slides',
                      child: Row(
                        children: [
                          Icon(LucideIcons.presentation, size: 16, color: AppTheme.duoOrange),
                          SizedBox(width: 8),
                          Text('Beamer Presentation Slides'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'template:Resume / CV',
                      child: Row(
                        children: [
                          Icon(LucideIcons.userCheck, size: 16, color: AppTheme.duoGreen),
                          SizedBox(width: 8),
                          Text('Resume / CV'),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      value: 'settings',
                      child: Row(
                        children: [
                          Icon(LucideIcons.slidersHorizontal, size: 16),
                          SizedBox(width: 10),
                          Text('Editor Settings'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: SafeArea(
              child: _buildCodeInput(isDark, settings),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCodeInput(bool isDark, IdeSettings settings) {
    final editorBg = isDark ? const Color(0xFF0D1117) : const Color(0xFFF8FAFC);
    final editorText = isDark ? const Color(0xFFE6EDF3) : const Color(0xFF0F172A);

    final strut = StrutStyle(
      fontFamily: 'monospace',
      fontSize: settings.fontSize,
      height: 1.4,
      forceStrutHeight: true,
    );

    return Container(
      color: editorBg,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: _texController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              strutStyle: strut,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: settings.fontSize,
                color: editorText,
                height: 1.4,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                hintText: r'Write LaTeX code...',
                hintStyle: TextStyle(
                  color: isDark ? const Color(0xFF6E7781) : const Color(0xFF8C959F),
                  fontSize: 12,
                ),
              ),
            ),
          ),
          // Bottom status bar (Line & Column tracking)
          ListenableBuilder(
            listenable: _texController,
            builder: (context, _) {
              final selection = _texController.selection;
              final text = _texController.text;
              final lines = text.split('\n');
              final totalLines = lines.isEmpty ? 1 : lines.length;

              int currentLine = 1;
              int currentCol = 1;
              if (selection.start >= 0 && selection.start <= text.length) {
                final sub = text.substring(0, selection.start);
                currentLine = sub.split('\n').length;
                final lastNL = sub.lastIndexOf('\n');
                currentCol = selection.start - (lastNL == -1 ? 0 : lastNL + 1) + 1;
              }

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: context.colors.outline.withValues(alpha: 0.3))),
                ),
                child: Row(
                  children: [
                    Text(
                      'Line $currentLine of $totalLines',
                      style: TextStyle(
                        fontSize: 11,
                        color: context.colors.textFaint,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Col $currentCol  |  ${text.length} chars',
                      style: TextStyle(
                        fontSize: 11,
                        color: context.colors.textFaint,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _openPdfInViewer(String filePath, String pdfTitle, String description) async {
    if (!mounted) return;
    final sec = Section(
      id: 'sec_latex_1',
      title: pdfTitle,
      description: description,
      color: '#22c55e',
      units: const [],
      pdfPath: filePath,
    );

    final defaultFormats = LessonFormat.defaultFormats;
    final book = Book(
      id: 'latex_output_${DateTime.now().millisecondsSinceEpoch}',
      title: pdfTitle,
      description: 'LaTeX Document',
      icon: 'file-text',
      modules: const [],
      lessonFormats: defaultFormats,
      defaultFormatId: defaultFormats.isNotEmpty ? defaultFormats.first.id : 'default',
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReferencePdfViewerScreen(
          book: book,
          initialSection: sec,
        ),
      ),
    );
  }

  void _showCompilationErrorDialog(String fullErrorLog, String texCode) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Row(
          children: [
            const Icon(LucideIcons.alertTriangle, color: Colors.redAccent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Online Compilation Error',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxHeight: 320),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
          ),
          child: SingleChildScrollView(
            child: SelectableText(
              fullErrorLog,
              style: const TextStyle(
                color: Color(0xFFFCA5A5),
                fontFamily: 'monospace',
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.duoGreen,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            icon: const Icon(LucideIcons.sparkles, size: 16),
            label: const Text(
              'Explain Error with AI',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              _explainErrorWithAi(fullErrorLog, texCode);
            },
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _explainErrorWithAi(String fullErrorLog, String texCode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _LatexErrorAiExplainerSheet(
        texCode: texCode,
        errorLog: fullErrorLog,
        onApplyFix: (newCode) {
          setState(() {
            _texController.text = newCode;
          });
          _saveProject(silent: true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('AI Fix applied successfully!'),
              backgroundColor: AppTheme.duoGreen,
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  Future<File> _generateOfflinePdf(String title, String texCode) async {
    final pdf = pw.Document();

    String docTitle = title;
    String docAuthor = '';
    String docDate = '';

    final tMatch = RegExp(r'\\title\{([\s\S]*?)\}').firstMatch(texCode);
    if (tMatch != null && tMatch.group(1)!.trim().isNotEmpty) {
      docTitle = tMatch.group(1)!.replaceAll(RegExp(r'\\[a-zA-Z]+'), '').trim();
    }
    final aMatch = RegExp(r'\\author\{([\s\S]*?)\}').firstMatch(texCode);
    if (aMatch != null) {
      docAuthor = aMatch.group(1)!.replaceAll(RegExp(r'\\[a-zA-Z]+'), '').trim();
    }
    final dMatch = RegExp(r'\\date\{([\s\S]*?)\}').firstMatch(texCode);
    if (dMatch != null) {
      final nowStr = DateTime.now().toString().split(' ')[0];
      docDate = dMatch.group(1)!.replaceAll(r'\today', nowStr).replaceAll(RegExp(r'\\[a-zA-Z]+'), '').trim();
    }

    final customMacros = <String, String>{};
    final macroRegex = RegExp(r'\\(?:newcommand|def)\{?\\([a-zA-Z]+)\}?\{([\s\S]*?)\}');
    for (final match in macroRegex.allMatches(texCode)) {
      final name = match.group(1);
      final body = match.group(2);
      if (name != null && body != null) {
        customMacros[name] = body;
      }
    }

    var processedTex = texCode;
    customMacros.forEach((name, replacement) {
      processedTex = processedTex.replaceAll('\\$name', replacement);
    });

    final lines = processedTex.split('\n');
    final contentWidgets = <pw.Widget>[];

    final bibItems = <String, String>{};
    final indexTerms = <String>{};
    int citationCounter = 1;

    for (final rawLine in lines) {
      final line = rawLine.trim();
      final bMatch = RegExp(r'\\bibitem\{([^}]+)\}').firstMatch(line);
      if (bMatch != null) {
        bibItems[bMatch.group(1)!] = '[${citationCounter++}]';
      }
      final idxMatch = RegExp(r'\\index\{([^}]+)\}').firstMatch(line);
      if (idxMatch != null) {
        indexTerms.add(idxMatch.group(1)!);
      }
    }

    bool inCodeBlock = false;
    final codeBuffer = StringBuffer();

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i].trim();
      if (line.isEmpty || line.startsWith('%')) continue;

      if (line.startsWith(r'\documentclass') ||
          line.startsWith(r'\usepackage') ||
          line.startsWith(r'\begin{document}') ||
          line.startsWith(r'\end{document}') ||
          line.startsWith(r'\title') ||
          line.startsWith(r'\author') ||
          line.startsWith(r'\date') ||
          line.startsWith(r'\makeindex')) {
        continue;
      }

      if (line.startsWith(r'\maketitle')) {
        contentWidgets.add(
          pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(docTitle, style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900), textAlign: pw.TextAlign.center),
                if (docAuthor.isNotEmpty) ...[
                  pw.SizedBox(height: 4),
                  pw.Text(docAuthor, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.grey700)),
                ],
                if (docDate.isNotEmpty) ...[
                  pw.SizedBox(height: 2),
                  pw.Text(docDate, style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic, color: PdfColors.grey600)),
                ],
                pw.SizedBox(height: 12),
                pw.Divider(thickness: 0.5, color: PdfColors.grey400),
                pw.SizedBox(height: 12),
              ],
            ),
          ),
        );
        continue;
      }

      if (line.startsWith(r'\begin{lstlisting}') || line.startsWith(r'\begin{minted}')) {
        inCodeBlock = true;
        codeBuffer.clear();
        continue;
      }
      if (line.startsWith(r'\end{lstlisting}') || line.startsWith(r'\end{minted}')) {
        inCodeBlock = false;
        contentWidgets.add(
          pw.Container(
            width: double.infinity,
            margin: const pw.EdgeInsets.symmetric(vertical: 6),
            padding: const pw.EdgeInsets.all(10),
            decoration: const pw.BoxDecoration(
              color: PdfColors.grey900,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
            ),
            child: pw.Text(
              codeBuffer.toString(),
              style: pw.TextStyle(color: PdfColors.green300, fontSize: 10, font: pw.Font.courier()),
            ),
          ),
        );
        continue;
      }
      if (inCodeBlock) {
        codeBuffer.writeln(line);
        continue;
      }

      if (line.startsWith(r'\section')) {
        final secTitle = line.replaceAll(RegExp(r'\\section\*?\{([^}]+)\}'), r'$1');
        contentWidgets.add(pw.SizedBox(height: 14));
        contentWidgets.add(pw.Text(secTitle, style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)));
        contentWidgets.add(pw.Divider(thickness: 0.5, color: PdfColors.blue900));
        contentWidgets.add(pw.SizedBox(height: 4));
        continue;
      } else if (line.startsWith(r'\subsection')) {
        final subTitle = line.replaceAll(RegExp(r'\\subsection\*?\{([^}]+)\}'), r'$1');
        contentWidgets.add(pw.SizedBox(height: 10));
        contentWidgets.add(pw.Text(subTitle, style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColors.blue700)));
        contentWidgets.add(pw.SizedBox(height: 2));
        continue;
      }

      if (line.startsWith(r'\[') || line.endsWith(r'\]') || line.startsWith(r'\begin{equation') || line.startsWith(r'\begin{align')) {
        final eq = line
            .replaceAll(RegExp(r'\\(begin|end)\{(align\*?|equation\*?)\}'), '')
            .replaceAll(r'\[', '')
            .replaceAll(r'\]', '')
            .replaceAll(r'\\', ' ')
            .trim();
        if (eq.isNotEmpty) {
          contentWidgets.add(
            pw.Container(
              width: double.infinity,
              margin: const pw.EdgeInsets.symmetric(vertical: 8),
              padding: const pw.EdgeInsets.all(8),
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              child: pw.Center(child: pw.Text(eq, style: pw.TextStyle(fontStyle: pw.FontStyle.italic, fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.grey900))),
            ),
          );
        }
        continue;
      }

      if (line.startsWith(r'\begin{thebibliography}')) {
        contentWidgets.add(pw.SizedBox(height: 14));
        contentWidgets.add(pw.Text('References', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)));
        contentWidgets.add(pw.Divider(thickness: 0.5, color: PdfColors.blue900));
        contentWidgets.add(pw.SizedBox(height: 4));
        continue;
      }
      if (line.startsWith(r'\bibitem')) {
        final keyMatch = RegExp(r'\\bibitem\{([^}]+)\}').firstMatch(line);
        final key = keyMatch?.group(1) ?? '';
        final tag = bibItems[key] ?? '[1]';
        final textAfter = line.replaceAll(RegExp(r'\\bibitem\{[^}]+\}'), '').trim();
        contentWidgets.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 4, bottom: 2),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(width: 28, child: pw.Text(tag, style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900))),
                pw.Expanded(child: pw.Text(textAfter, style: const pw.TextStyle(fontSize: 10, lineSpacing: 2))),
              ],
            ),
          ),
        );
        continue;
      }

      if (line.startsWith(r'\printindex')) {
        if (indexTerms.isNotEmpty) {
          contentWidgets.add(pw.SizedBox(height: 14));
          contentWidgets.add(pw.Text('Index', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)));
          contentWidgets.add(pw.Divider(thickness: 0.5, color: PdfColors.blue900));
          contentWidgets.add(pw.SizedBox(height: 4));
          for (final term in indexTerms) {
            contentWidgets.add(pw.Text(term, style: const pw.TextStyle(fontSize: 10)));
          }
        }
        continue;
      }

      var cleanLine = line
          .replaceAll(RegExp(r'\\cite\{([^}]+)\}'), r'[1]')
          .replaceAll(RegExp(r'\\index\{([^}]+)\}'), r'$1')
          .replaceAll(RegExp(r'\\textbf\{([^}]+)\}'), r'$1')
          .replaceAll(RegExp(r'\\textit\{([^}]+)\}'), r'$1')
          .replaceAll(RegExp(r'\\underline\{([^}]+)\}'), r'$1')
          .replaceAll(RegExp(r'\\[a-zA-Z]+'), '');

      if (cleanLine.isNotEmpty) {
        contentWidgets.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Text(
              cleanLine,
              style: const pw.TextStyle(fontSize: 11, lineSpacing: 3),
            ),
          ),
        );
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (pw.Context ctx) => contentWidgets,
      ),
    );

    final outputDir = await getTemporaryDirectory();
    final file = File('${outputDir.path}/${title.replaceAll(' ', '_')}_offline.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}

class _LatexErrorAiExplainerSheet extends StatefulWidget {
  final String texCode;
  final String errorLog;
  final ValueChanged<String> onApplyFix;

  const _LatexErrorAiExplainerSheet({
    required this.texCode,
    required this.errorLog,
    required this.onApplyFix,
  });

  @override
  State<_LatexErrorAiExplainerSheet> createState() =>
      _LatexErrorAiExplainerSheetState();
}

class _LatexErrorAiExplainerSheetState
    extends State<_LatexErrorAiExplainerSheet> {
  bool _isLoading = true;
  String? _errorMessage;
  Map<String, dynamic>? _explanationResult;
  bool _isCopied = false;

  @override
  void initState() {
    super.initState();
    _fetchExplanation();
  }

  Future<void> _fetchExplanation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final res = await AiService().explainLatexError(
        texCode: widget.texCode,
        errorLog: widget.errorLog,
      );
      if (mounted) {
        setState(() {
          _explanationResult = res;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceAll('Exception:', '').trim();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.colors.isDark;
    final surfaceColor = context.colors.surface;
    final textPrimary = context.colors.textPrimary;
    final textSecondary = context.colors.textSecondary;
    final textFaint = context.colors.textFaint;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 6),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: textFaint.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.duoGreen.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      LucideIcons.sparkles,
                      color: AppTheme.duoGreen,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Error Diagnosis & Fix',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                        Text(
                          'Automated TeX debugging & correction',
                          style: TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.x, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Content
            Expanded(
              child: _buildBody(isDark, textPrimary, textSecondary, textFaint),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    bool isDark,
    Color textPrimary,
    Color textSecondary,
    Color textFaint,
  ) {
    if (_isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 44,
                height: 44,
                child: CircularProgressIndicator(
                  color: AppTheme.duoGreen,
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Analyzing LaTeX code & error log...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Detecting syntax typos, missing packages, and generating a validated fix.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.alertCircle,
                  color: Colors.redAccent, size: 40),
              const SizedBox(height: 12),
              Text(
                'Failed to generate AI diagnosis',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: textSecondary),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.duoGreen,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(LucideIcons.refreshCw, size: 16),
                label: const Text('Try Again'),
                onPressed: _fetchExplanation,
              ),
            ],
          ),
        ),
      );
    }

    final summary =
        _explanationResult?['summary']?.toString() ?? 'Error diagnosis';
    final lineHint = _explanationResult?['lineHint']?.toString();
    final explanation = _explanationResult?['explanation']?.toString() ?? '';
    final fixedCode = _explanationResult?['fixedCode']?.toString();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.redAccent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(LucideIcons.alertTriangle,
                        color: Colors.redAccent, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        summary,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                if (lineHint != null && lineHint.trim().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      lineHint,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Detailed Markdown Explanation
          Text(
            'DIAGNOSIS & SOLUTION',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              color: textFaint,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color:
                  isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.colors.outline.withValues(alpha: 0.3),
              ),
            ),
            child: MarkdownBody(
              data: explanation,
              selectable: true,
              styleSheet:
                  MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                p: TextStyle(fontSize: 13, height: 1.4, color: textPrimary),
                code: TextStyle(
                  backgroundColor: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFE2E8F0),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: isDark
                      ? const Color(0xFF93C5FD)
                      : const Color(0xFF1D4ED8),
                ),
                codeblockDecoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF0D1117)
                      : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: context.colors.outline.withValues(alpha: 0.2)),
                ),
              ),
            ),
          ),

          // Corrected Code Box if available
          if (fixedCode != null && fixedCode.trim().isNotEmpty) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'CORRECTED LATEX CODE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: textFaint,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  icon: Icon(
                    _isCopied ? LucideIcons.check : LucideIcons.copy,
                    size: 14,
                    color: _isCopied ? AppTheme.duoGreen : textSecondary,
                  ),
                  label: Text(
                    _isCopied ? 'Copied' : 'Copy Code',
                    style: TextStyle(
                      fontSize: 12,
                      color: _isCopied ? AppTheme.duoGreen : textSecondary,
                    ),
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: fixedCode));
                    setState(() => _isCopied = true);
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) setState(() => _isCopied = false);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxHeight: 220),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1117),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: AppTheme.duoGreen.withValues(alpha: 0.4)),
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  fixedCode,
                  style: const TextStyle(
                    color: Color(0xFFE6EDF3),
                    fontFamily: 'monospace',
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Apply Fix Button
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.duoGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(LucideIcons.checkCircle2, size: 18),
                label: const Text(
                  'Apply Fix to Editor',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onApplyFix(fixedCode);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
