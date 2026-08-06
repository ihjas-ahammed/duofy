import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/app_models.dart';
import '../../services/code_storage_service.dart';
import '../../services/ide_settings_service.dart';
import '../../services/fb/fb_auth.dart';
import '../../theme/app_theme.dart';
import '../../widgets/code_highlighter.dart';
import '../../widgets/ide_config_dialog.dart';
import '../../widgets/platform_webview.dart';
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
  String _selectedTemplate = 'Hello World';
  List<Map<String, String>> _activeCompletions = [];

  static String get _authorName {
    final u = FbAuth.instance.currentUser;
    if (u != null && u.displayName != null && u.displayName!.trim().isNotEmpty) {
      return u.displayName!.trim();
    }
    return 'Flow Learner';
  }

  final List<Map<String, String>> _snippets = [
    {'label': 'Cite', 'snippet': r'\cite{key}'},
    {'label': 'BibTeX Item', 'snippet': "\\bibitem{key}\nAuthor (Year). \\textit{Title}."},
    {'label': 'Index Term', 'snippet': r'\index{KeyTerm}'},
    {'label': 'Print Index', 'snippet': r'\printindex'},
    {'label': 'Fraction', 'snippet': r'\frac{a}{b}'},
    {'label': 'Exponent', 'snippet': r'x^{2}'},
    {'label': 'Subscript', 'snippet': r'x_{i}'},
    {'label': 'Square Root', 'snippet': r'\sqrt{x}'},
    {'label': 'Integral', 'snippet': r'\int_{0}^{\infty} f(x) \, dx'},
    {'label': 'Summation', 'snippet': r'\sum_{n=1}^{\infty} a_n'},
    {'label': 'Limit', 'snippet': r'\lim_{x \to 0}'},
    {'label': 'Matrix', 'snippet': "\\begin{bmatrix}\n a & b \\\\\n c & d\n\\end{bmatrix}"},
    {'label': 'Align Eq', 'snippet': "\\begin{align}\n f(x) &= a x^2 + b x + c \\\\\n g(x) &= \\sin(x)\n\\end{align}"},
    {'label': 'Use Package', 'snippet': r'\usepackage{makeidx,amsmath,graphicx,hyperref}'},
    {'label': 'Alpha', 'snippet': r'\alpha'},
    {'label': 'Beta', 'snippet': r'\beta'},
    {'label': 'Theta', 'snippet': r'\theta'},
    {'label': 'Pi', 'snippet': r'\pi'},
    {'label': 'Infinity', 'snippet': r'\infty'},
  ];

  final List<Map<String, String>> _completionDatabase = [
    {'trigger': r'\cite', 'display': r'\cite{key}', 'insert': r'\cite{}'},
    {'trigger': r'\bibitem', 'display': r'\bibitem{key}', 'insert': r'\bibitem{}'},
    {'trigger': r'\bibliography', 'display': r'\begin{thebibliography}{99} ... \end{thebibliography}', 'insert': "\\begin{thebibliography}{99}\n\\bibitem{key}\nAuthor. \\textit{Title}.\n\\end{thebibliography}"},
    {'trigger': r'\makeindex', 'display': r'\makeindex', 'insert': r'\makeindex'},
    {'trigger': r'\index', 'display': r'\index{term}', 'insert': r'\index{}'},
    {'trigger': r'\printindex', 'display': r'\printindex', 'insert': r'\printindex'},
    {'trigger': r'\begin', 'display': r'\begin{...} ... \end{...}', 'insert': "\\begin{matrix}\n  \n\\end{matrix}"},
    {'trigger': r'\section', 'display': r'\section{Title}', 'insert': r'\section{}'},
    {'trigger': r'\subsection', 'display': r'\subsection{Title}', 'insert': r'\subsection{}'},
    {'trigger': r'\subsubsection', 'display': r'\subsubsection{Title}', 'insert': r'\subsubsection{}'},
    {'trigger': r'\frac', 'display': r'\frac{num}{den}', 'insert': r'\frac{}{}'},
    {'trigger': r'\sqrt', 'display': r'\sqrt{x}', 'insert': r'\sqrt{}'},
    {'trigger': r'\usepackage', 'display': r'\usepackage{package}', 'insert': r'\usepackage{}'},
    {'trigger': r'\documentclass', 'display': r'\documentclass[11pt]{article}', 'insert': r'\documentclass[11pt]{article}'},
    {'trigger': r'\textbf', 'display': r'\textbf{bold text}', 'insert': r'\textbf{}'},
    {'trigger': r'\textit', 'display': r'\textit{italic text}', 'insert': r'\textit{}'},
    {'trigger': r'\sum', 'display': r'\sum_{i=1}^{n}', 'insert': r'\sum_{i=1}^{n}'},
    {'trigger': r'\int', 'display': r'\int_{a}^{b}', 'insert': r'\int_{a}^{b}'},
    {'trigger': r'\lim', 'display': r'\lim_{x \to 0}', 'insert': r'\lim_{x \to 0}'},
    {'trigger': r'\align', 'display': r'\begin{align} ... \end{align}', 'insert': "\\begin{align}\n  \n\\end{align}"},
    {'trigger': r'\matrix', 'display': r'\begin{bmatrix} ... \end{bmatrix}', 'insert': "\\begin{bmatrix}\n  a & b \\\\\n  c & d\n\\end{bmatrix}"},
    {'trigger': r'\table', 'display': r'\begin{table} ... \end{table}', 'insert': "\\begin{table}[h]\n  \\centering\n  \\begin{tabular}{cc}\n    a & b \\\\\n  \\end{tabular}\n  \\caption{Caption}\n\\end{table}"},
    {'trigger': r'\figure', 'display': r'\begin{figure} ... \end{figure}', 'insert': "\\begin{figure}[h]\n  \\centering\n  \\caption{Caption}\n\\end{figure}"},
    {'trigger': r'\alpha', 'display': r'\alpha', 'insert': r'\alpha'},
    {'trigger': r'\beta', 'display': r'\beta', 'insert': r'\beta'},
    {'trigger': r'\gamma', 'display': r'\gamma', 'insert': r'\gamma'},
    {'trigger': r'\theta', 'display': r'\theta', 'insert': r'\theta'},
    {'trigger': r'\pi', 'display': r'\pi', 'insert': r'\pi'},
    {'trigger': r'\sigma', 'display': r'\sigma', 'insert': r'\sigma'},
    {'trigger': r'\omega', 'display': r'\omega', 'insert': r'\omega'},
    {'trigger': r'\infty', 'display': r'\infty', 'insert': r'\infty'},
    {'trigger': r'\partial', 'display': r'\partial', 'insert': r'\partial'},
    {'trigger': r'\nabla', 'display': r'\nabla', 'insert': r'\nabla'},
  ];

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
  }

  @override
  void dispose() {
    _texController.removeListener(_onTextChanged);
    _titleController.dispose();
    _texController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _texController.text;
    final selection = _texController.selection;

    if (!selection.isCollapsed || selection.start <= 0) {
      if (_activeCompletions.isNotEmpty) {
        setState(() {
          _activeCompletions = [];
        });
      }
      return;
    }

    final pos = selection.start;
    final lastBackslash = text.lastIndexOf('\\', pos - 1);

    if (lastBackslash != -1 && pos - lastBackslash <= 15) {
      final query = text.substring(lastBackslash, pos).toLowerCase();
      final matches = _completionDatabase.where((item) {
        return item['trigger']!.toLowerCase().startsWith(query) ||
            item['display']!.toLowerCase().contains(query);
      }).toList();

      setState(() {
        _activeCompletions = matches;
      });
    } else {
      if (_activeCompletions.isNotEmpty) {
        setState(() {
          _activeCompletions = [];
        });
      }
    }
  }

  void _applyCompletion(Map<String, String> item) {
    final text = _texController.text;
    final selection = _texController.selection;
    final pos = selection.start >= 0 ? selection.start : text.length;
    final lastBackslash = text.lastIndexOf('\\', pos - 1);

    final start = lastBackslash != -1 ? lastBackslash : pos;
    final insertText = item['insert']!;
    final newText = text.replaceRange(start, pos, insertText);

    int cursorOffset = start + insertText.length;
    final emptyBraceIndex = insertText.indexOf('{}');
    if (emptyBraceIndex != -1) {
      cursorOffset = start + emptyBraceIndex + 1;
    }

    _texController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursorOffset),
    );

    setState(() {
      _activeCompletions = [];
    });
  }

  void _insertSnippet(String snippet) {
    final text = _texController.text;
    final selection = _texController.selection;
    final start = selection.start >= 0 ? selection.start : text.length;
    final end = selection.end >= 0 ? selection.end : text.length;
    final newText = text.replaceRange(start, end, snippet);
    _texController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: start + snippet.length),
    );
  }

  void _loadTemplate(String name) {
    if (_templates.containsKey(name)) {
      setState(() {
        _selectedTemplate = name;
        _texController.text = _templates[name]!;
      });
    }
  }

  void _openPdfPreview() {
    final title = _titleController.text.trim().isEmpty
        ? 'LaTeX Studio'
        : _titleController.text.trim();

    debugPrint('[LaTeX Op] User triggered RUN LaTeX for project "$title"');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LatexPdfPreviewScreen(
          title: title,
          texCode: _texController.text,
        ),
      ),
    );
  }

  Future<void> _saveProject() async {
    setState(() {
      _isSaving = true;
    });

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('LaTeX Project saved!'),
          backgroundColor: AppTheme.duoGreen,
        ),
      );
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
              titleSpacing: 0,
              title: Container(
                constraints: const BoxConstraints(maxWidth: 160),
                child: TextField(
                  controller: _titleController,
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'LaTeX Title...',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
              actions: [
                // Prominent Mobile Compact RUN LaTeX Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: ElevatedButton.icon(
                    onPressed: _openPdfPreview,
                    icon: const Icon(LucideIcons.play, size: 12, color: Colors.white),
                    label: const Text(
                      'RUN',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.duoGreen,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(60, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                // Template Selector Menu
                PopupMenuButton<String>(
                  icon: const Icon(LucideIcons.fileText, size: 20),
                  tooltip: 'Load Template',
                  onSelected: _loadTemplate,
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: 'Hello World',
                      child: Row(
                        children: [
                          Icon(LucideIcons.fileText, size: 16, color: AppTheme.duoGreen),
                          SizedBox(width: 8),
                          Text('Hello World (Minimal)'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Indexed Book (makeidx)',
                      child: Row(
                        children: [
                          Icon(LucideIcons.bookmark, size: 16, color: AppTheme.duoViolet),
                          SizedBox(width: 8),
                          Text('Indexed Book (makeidx Package)'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Academic Paper',
                      child: Row(
                        children: [
                          Icon(LucideIcons.bookOpen, size: 16, color: AppTheme.duoBlue),
                          SizedBox(width: 8),
                          Text('Academic Paper (Citations & Bib)'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Math & Physics',
                      child: Row(
                        children: [
                          Icon(LucideIcons.zap, size: 16, color: AppTheme.duoViolet),
                          SizedBox(width: 8),
                          Text('Math & Physics Formulas'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Beamer Slides',
                      child: Row(
                        children: [
                          Icon(LucideIcons.presentation, size: 16, color: AppTheme.duoOrange),
                          SizedBox(width: 8),
                          Text('Beamer Presentation Slides'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Resume / CV',
                      child: Row(
                        children: [
                          Icon(LucideIcons.userCheck, size: 16, color: AppTheme.duoGreen),
                          SizedBox(width: 8),
                          Text('Resume / Curriculum Vitae'),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(LucideIcons.slidersHorizontal, size: 20),
                  tooltip: 'Settings',
                  onPressed: () => IdeConfigDialog.show(context),
                ),
                IconButton(
                  icon: _isSaving
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(LucideIcons.save, size: 20),
                  tooltip: 'Save Document',
                  onPressed: _saveProject,
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  // Snippet & Symbol Toolbar
                  SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      itemCount: _snippets.length,
                      itemBuilder: (ctx, i) {
                        final sym = _snippets[i];
                        return Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: ActionChip(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            backgroundColor: context.colors.glassStrong,
                            side: BorderSide(color: context.colors.outline),
                            label: Text(
                              sym['label']!,
                              style: const TextStyle(
                                color: AppTheme.duoViolet,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => _insertSnippet(sym['snippet']!),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  // Full Height Code Editor Page
                  Expanded(
                    child: _buildCodeInput(isDark, settings),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCodeInput(bool isDark, IdeSettings settings) {
    final editorBg = isDark ? const Color(0xFF0D1117) : const Color(0xFFF8FAFC);
    final editorText = isDark ? const Color(0xFFE6EDF3) : const Color(0xFF0F172A);

    final lineCount = _texController.text.split('\n').length;
    final lineNumbersText = List.generate(lineCount, (i) => '${i + 1}').join('\n');

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (settings.showLineNumbers) ...[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      lineNumbersText,
                      strutStyle: strut,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: settings.fontSize,
                        color: isDark ? const Color(0xFF6E7781) : const Color(0xFF8C959F),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: (lineCount * (settings.fontSize * 1.4)).clamp(24, 2000),
                    color: context.colors.outline.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: 10),
                ],
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
                      hintText: r'Write LaTeX code... Type \ for instant autocompletion',
                      hintStyle: TextStyle(
                        color: isDark ? const Color(0xFF6E7781) : const Color(0xFF8C959F),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Instant Autocomplete Bar
          if (_activeCompletions.isNotEmpty) ...[
            Container(
              height: 44,
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.duoViolet.withValues(alpha: 0.4)),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _activeCompletions.length,
                itemBuilder: (ctx, i) {
                  final item = _activeCompletions[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: ChoiceChip(
                      selected: false,
                      backgroundColor: AppTheme.duoViolet.withValues(alpha: 0.15),
                      side: const BorderSide(color: AppTheme.duoViolet),
                      label: Row(
                        children: [
                          Icon(LucideIcons.code, size: 12, color: AppTheme.duoViolet),
                          const SizedBox(width: 4),
                          Text(
                            item['display']!,
                            style: const TextStyle(
                              color: AppTheme.duoViolet,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                      onSelected: (_) => _applyCompletion(item),
                    ),
                  );
                },
              ),
            ),
          ],
          // Bottom hint bar (Overflow-safe)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: context.colors.outline.withValues(alpha: 0.3))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Template: $_selectedTemplate | Type \\ for instant autocomplete',
                    style: TextStyle(
                      fontSize: 11,
                      color: context.colors.textFaint,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${_texController.text.length} chars | $lineCount lines',
                  style: TextStyle(
                    fontSize: 11,
                    color: context.colors.textFaint,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Dedicated PDF Preview Screen with latexonline.cc TeX Live GET API Integration & Built-in Document Viewer Launching
class LatexPdfPreviewScreen extends StatefulWidget {
  final String title;
  final String texCode;

  const LatexPdfPreviewScreen({
    super.key,
    required this.title,
    required this.texCode,
  });

  @override
  State<LatexPdfPreviewScreen> createState() => _LatexPdfPreviewScreenState();
}

class _LatexPdfPreviewScreenState extends State<LatexPdfPreviewScreen> {
  final List<String> _opLogs = [];
  bool _isCompilingPdf = false;

  void _addLog(String message) {
    final timeStr = DateTime.now().toIso8601String().split('T')[1].substring(0, 8);
    final logLine = '[$timeStr] $message';
    debugPrint('[LaTeX Op Log] $logLine');
    if (mounted) {
      setState(() {
        _opLogs.add(logLine);
      });
    }
  }

  Future<void> _compileAndOpenDocumentViewer() async {
    if (_isCompilingPdf) return;

    setState(() {
      _isCompilingPdf = true;
    });

    _addLog('Starting latexonline.cc TeX Live GET API compilation request...');

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
                      'Compiling TeX Live PDF...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Connecting to latexonline.cc API',
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

    try {
      final encodedTex = Uri.encodeComponent(widget.texCode);
      final uri = Uri.parse('https://latexonline.cc/compile?text=$encodedTex');
      final response = await http.get(uri).timeout(const Duration(seconds: 35));

      if (mounted) Navigator.of(context).pop(); // Dismiss loading dialog

      setState(() {
        _isCompilingPdf = false;
      });

      if (response.statusCode == 200 &&
          response.bodyBytes.length > 100 &&
          response.bodyBytes[0] == 37 &&
          response.bodyBytes[1] == 80) { // %P
        _addLog('SUCCESS: TeX Live PDF compiled (${response.bodyBytes.length} bytes).');

        final tempDir = await getTemporaryDirectory();
        final sanitizedTitle = widget.title
            .replaceAll(RegExp(r'[^\w\s-]'), '_')
            .replaceAll(' ', '_');
        final filePath = '${tempDir.path}/${sanitizedTitle}_compiled.pdf';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        _addLog('Saved PDF to local storage: $filePath');

        if (!mounted) return;

        final sec = Section(
          id: 'sec_latex_1',
          title: widget.title,
          description: 'Compiled TeX Live Output PDF',
          color: '#22c55e',
          units: const [],
          pdfPath: file.path,
        );

        final defaultFormats = LessonFormat.defaultFormats;
        final book = Book(
          id: 'latex_output_${DateTime.now().millisecondsSinceEpoch}',
          title: widget.title,
          description: 'LaTeX Document',
          icon: 'file-text',
          modules: const [],
          lessonFormats: defaultFormats,
          defaultFormatId: defaultFormats.isNotEmpty ? defaultFormats.first.id : 'default',
        );

        // Open directly in our Document Viewer!
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReferencePdfViewerScreen(
              book: book,
              initialSection: sec,
            ),
          ),
        );
      } else {
        _addLog('ERROR: Online TeX Live compilation failed with HTTP ${response.statusCode}');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('TeX Live Online compilation error (HTTP ${response.statusCode}).'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      if (mounted) Navigator.of(context).pop();
      setState(() {
        _isCompilingPdf = false;
      });
      _addLog('ERROR: Request exception: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Compilation request error: $e'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
    }
  }

  String get _htmlPreviewEngine {
    final b64Code = base64Encode(utf8.encode(widget.texCode));
    return r'''<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>LaTeX PDF Preview</title>
  <script>
    function sendLog(msg) {
      console.log("[JS Op Log] " + msg);
      if (window.DuoMessageChannel) {
        window.DuoMessageChannel.postMessage(msg);
      }
    }
    sendLog("1. WebView DOM Initialized. Preparing LaTeX parser & package polyfills...");

    function triggerCompileAndOpenPdf() {
      sendLog("Save/Print PDF clicked: Triggering latexonline.cc compilation...");
      if (window.DuoMessageChannel) {
        window.DuoMessageChannel.postMessage("ACTION_COMPILE_TEX_LIVE");
      } else {
        window.print();
      }
    }
  </script>
  <script src="https://cdn.jsdelivr.net/npm/latex.js/dist/latex.min.js" 
          onload="sendLog('2. latex.js CDN script loaded successfully.')" 
          onerror="sendLog('2. WARNING: CDN script load failed! Activating fallback parser.')"></script>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      background-color: #0f172a;
      color: #f8fafc;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }
    .toolbar {
      background: #1e293b;
      border-bottom: 1px solid #334155;
      padding: 8px 12px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 8px;
      position: sticky;
      top: 0;
      z-index: 100;
      flex-wrap: wrap;
    }
    .tabs {
      display: flex;
      gap: 4px;
      background: #0f172a;
      padding: 3px;
      border-radius: 8px;
    }
    .tab {
      padding: 6px 12px;
      font-size: 11px;
      font-weight: 700;
      border-radius: 6px;
      cursor: pointer;
      color: #94a3b8;
      transition: all 0.2s;
    }
    .tab.active {
      background: #334155;
      color: #ffffff;
    }
    .btn {
      background: #22c55e;
      color: #ffffff;
      border: none;
      padding: 6px 14px;
      border-radius: 6px;
      font-size: 11px;
      font-weight: 700;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 4px;
    }
    .btn:hover { background: #16a34a; }
    .content-area {
      flex: 1;
      padding: 16px;
      display: flex;
      justify-content: center;
      background: #090d16;
      overflow-y: auto;
    }
    #document-paper {
      background: #ffffff;
      color: #0f172a;
      padding: 24px;
      border-radius: 8px;
      width: 100%;
      max-width: 850px;
      box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.7);
      min-height: 800px;
      font-size: 14px;
      line-height: 1.6;
    }
    #log-wrapper {
      background: #0f172a;
      color: #38bdf8;
      font-family: monospace;
      font-size: 12px;
      padding: 16px;
      width: 100%;
      max-width: 850px;
      border-radius: 8px;
      white-space: pre-wrap;
      display: none;
      border: 1px solid #334155;
    }
    .loading-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 40px;
      gap: 16px;
    }
    .spinner {
      width: 36px;
      height: 36px;
      border: 4px solid #334155;
      border-top-color: #6366f1;
      border-radius: 50%;
      animation: spin 0.8s linear infinite;
    }
    @keyframes spin { to { transform: rotate(360deg); } }
  </style>
</head>
<body>
  <div class="toolbar">
    <div class="tabs">
      <div id="tab-doc" class="tab active" onclick="switchView('doc')">Document View</div>
      <div id="tab-log" class="tab" onclick="switchView('log')">Compiler Log</div>
    </div>
    <div>
      <button class="btn" onclick="triggerCompileAndOpenPdf()">Save / Print PDF</button>
    </div>
  </div>

  <div class="content-area">
    <div id="document-paper">
      <div class="loading-container">
        <div class="spinner"></div>
        <div style="font-weight: 600; color: #64748b;">Typesetting LaTeX Document...</div>
      </div>
    </div>
    <div id="log-wrapper"></div>
  </div>

  <script>
    const b64Data = "''' + b64Code + r'''";
    const rawCode = decodeURIComponent(escape(atob(b64Data)));
    sendLog("3. Decoded base64 TeX payload (" + rawCode.length + " characters).");

    function switchView(view) {
      document.getElementById('tab-doc').classList.toggle('active', view === 'doc');
      document.getElementById('tab-log').classList.toggle('active', view === 'log');
      document.getElementById('document-paper').style.display = view === 'doc' ? 'block' : 'none';
      document.getElementById('log-wrapper').style.display = view === 'log' ? 'block' : 'none';
    }

    function preprocessTeX(inputCode) {
      let src = inputCode;

      // 1. Move preamble \title{}, \author{}, \date{} inside \begin{document} if placed before it
      if (src.includes('\\begin{document}')) {
        const docParts = src.split('\\begin{document}');
        let preamble = docParts[0];
        let body = docParts.slice(1).join('\\begin{document}');
        
        let movedHeaders = '';
        const headerRegex = /\\(title|author|date)\{([\s\S]*?)\}/g;
        preamble = preamble.replace(headerRegex, function(match) {
          movedHeaders += match + '\n';
          return '';
        });

        src = preamble + '\\begin{document}\n' + movedHeaders + body;
      }

      // 2. Polyfill & strip package declarations latex.js doesn't natively parse
      src = src.replace(/\\usepackage(\[[^\]]*\])?\{[^}]*\}/g, '% package loaded');
      src = src.replace(/\\makeindex/g, '% makeindex polyfill initialized');
      src = src.replace(/\\geometry\{[^}]*\}/g, '% geometry settings');
      src = src.replace(/\\hypersetup\{[^}]*\}/g, '% hypersetup settings');
      src = src.replace(/\\usetheme\{[^}]*\}/g, '% beamer theme');
      src = src.replace(/\\usecolortheme\{[^}]*\}/g, '% beamer color theme');
      src = src.replace(/\\newtheorem\{([^}]+)\}\{([^}]+)\}/g, '% newtheorem $1');
      src = src.replace(/\\centerline\{([^}]+)\}/g, '\\begin{center} $1 \\end{center}');
      src = src.replace(/\\vspace\{[^}]*\}/g, '\n');
      src = src.replace(/\\hrule/g, '\\rule{\\linewidth}{0.4pt}');

      // 3. Inline macro safety replacements (e.g. \textsuperscript, \textsubscript)
      src = src.replace(/\\textsuperscript\{([^}]+)\}/g, '^{$1}');
      src = src.replace(/\\textsubscript\{([^}]+)\}/g, '_{$1}');

      // 4. Citation key polyfill: convert \cite{key} to [1], [2] or [key] so latex.js never throws unknown macro
      const bibKeys = [];
      const bibRegex = /\\bibitem\{([^}]+)\}/g;
      let bMatch;
      while ((bMatch = bibRegex.exec(src)) !== null) {
        bibKeys.push(bMatch[1]);
      }

      src = src.replace(/\\cite\{([^}]+)\}/g, function(fullMatch, key) {
        const idx = bibKeys.indexOf(key);
        if (idx !== -1) {
          return '[' + (idx + 1) + ']';
        }
        return '[' + key + ']';
      });

      // 5. Polyfill thebibliography environment for latex.js
      if (src.includes('\\begin{thebibliography}')) {
        let bibCounter = 1;
        src = src.replace(/\\begin\{thebibliography\}(\{[^}]*\})?/g, '\n\\section*{References}\n\\begin{description}\n');
        src = src.replace(/\\bibitem\{([^}]+)\}/g, function(match, key) {
          const itemTag = '[' + bibCounter + ']';
          bibCounter++;
          return '\\item[' + itemTag + '] ';
        });
        src = src.replace(/\\end\{thebibliography\}/g, '\\end{description}\n');
      }

      // 6. makeidx support: collect \index{...} terms
      const indexTerms = [];
      src = src.replace(/\\index\{([^}]+)\}/g, function(match, term) {
        if (!indexTerms.includes(term)) indexTerms.push(term);
        return term;
      });

      // Handle \printindex -> format Index section using standard description environment
      if (src.includes('\\printindex')) {
        indexTerms.sort();
        let indexHtml = '\n\\section*{Index}\n\\begin{description}\n';
        indexTerms.forEach(function(t) {
          indexHtml += '  \\item[' + t + '] Page 1\n';
        });
        indexHtml += '\\end{description}\n';
        src = src.replace(/\\printindex/g, indexHtml);
      }

      // 7. Beamer slides support
      src = src.replace(/\\begin\{frame\}\{([^}]+)\}/g, '\\section{$1}\n\\begin{quote}');
      src = src.replace(/\\end\{frame\}/g, '\\end{quote}');
      src = src.replace(/\\begin\{block\}\{([^}]+)\}/g, '\\textbf{$1:}\n');
      src = src.replace(/\\end\{block\}/g, '');
      src = src.replace(/\\frame\{\\titlepage\}/g, '\\maketitle');

      // 8. Hyperref & url support
      src = src.replace(/\\href\{([^}]+)\}\{([^}]+)\}/g, '$2 ($1)');
      src = src.replace(/\\url\{([^}]+)\}/g, '$1');

      // 9. Sanitize unescaped & in titles or text mode (outside matrix/align/tabular)
      src = src.replace(/([^\\])&/g, '$1\\&');

      return src;
    }

    function renderLaTeX() {
      const startTime = Date.now();
      sendLog("4. Executing renderLaTeX()...");
      const processedCode = preprocessTeX(rawCode);
      
      try {
        if (typeof latexjs !== 'undefined' && latexjs.parse) {
          sendLog("5. Using latexjs AST parser with citation & bibliography polyfills...");
          const generator = new latexjs.HtmlGenerator({ hyphenate: false });
          const doc = latexjs.parse(processedCode, { generator: generator });
          const paper = document.getElementById('document-paper');
          paper.innerHTML = '';
          paper.appendChild(doc.domFragment());
          const elapsed = Date.now() - startTime;
          sendLog("6. SUCCESS: LaTeX document rendered in " + elapsed + " ms.");
        } else {
          sendLog("5. Fallback: latexjs not available, using instant HTML formatter...");
          const paper = document.getElementById('document-paper');
          let html = processedCode;
          html = html.replace(/\\section\*?\{([^}]+)\}/g, '<h2>$1</h2>');
          html = html.replace(/\\subsection\*?\{([^}]+)\}/g, '<h3>$1</h3>');
          html = html.replace(/\\textbf\{([^}]+)\}/g, '<b>$1</b>');
          html = html.replace(/\\textit\{([^}]+)\}/g, '<i>$1</i>');
          html = html.replace(/\\\[([\s\S]*?)\\\]/g, '<div style="font-family:monospace; margin:12px 0; background:#f1f5f9; padding:10px; border-radius:4px; font-weight:bold;">$1</div>');
          html = html.replace(/\\begin\{document\}/g, '');
          html = html.replace(/\\end\{document\}/g, '');
          html = html.replace(/\\documentclass.*?\n/g, '');
          html = html.replace(/\\title\{([^}]+)\}/g, '<h1 style="text-align:center; margin-bottom:8px;">$1</h1>');
          html = html.replace(/\\author\{([^}]+)\}/g, '<div style="text-align:center; color:#64748b; font-weight:bold;">$1</div>');
          html = html.replace(/\\maketitle/g, '<hr style="margin:16px 0; border:none; border-top:1px solid #cbd5e1;"/>');
          html = html.replace(/\n/g, '<br/>');

          paper.innerHTML = '<div style="font-family:serif; padding:10px;">' + html + '</div>';
          const elapsed = Date.now() - startTime;
          sendLog("6. SUCCESS: Fallback document rendered in " + elapsed + " ms.");
        }
      } catch (e) {
        sendLog("6. ERROR: LaTeX Exception: " + e.message);
        document.getElementById('document-paper').innerHTML = '<div style="color:#ef4444; font-weight:bold; padding:20px;">LaTeX Render Error: ' + e.message + '</div>';
        document.getElementById('log-wrapper').textContent = 'LaTeX Operations & Diagnostics Log:\nError: ' + e.message + '\n\nSource Code:\n' + rawCode;
        switchView('log');
      }
    }

    setTimeout(renderLaTeX, 20);
  </script>
</body>
</html>''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        title: Text(
          '${widget.title} - PDF Preview',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.fileDown),
            tooltip: 'Compile & Open in Document Viewer',
            onPressed: _compileAndOpenDocumentViewer,
          ),
          IconButton(
            icon: const Icon(LucideIcons.terminal),
            tooltip: 'View Operations Log',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: context.colors.surface,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (ctx) => Container(
                  padding: const EdgeInsets.all(16),
                  height: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LaTeX Operations & Diagnostic Logs',
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            itemCount: _opLogs.length,
                            itemBuilder: (c, idx) => Text(
                              _opLogs[idx],
                              style: const TextStyle(
                                color: Color(0xFF38BDF8),
                                fontFamily: 'monospace',
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: PlatformWebView(
          html: _htmlPreviewEngine,
          onMessage: (msg) {
            if (msg == 'ACTION_COMPILE_TEX_LIVE') {
              _compileAndOpenDocumentViewer();
            } else {
              _addLog(msg);
            }
          },
          onJsError: (err) => _addLog('JS ERROR: $err'),
        ),
      ),
    );
  }
}
