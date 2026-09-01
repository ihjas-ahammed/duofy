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

  // Multi-file state
  Map<String, String> _files = {};
  List<String> _openTabs = [];
  String _activeFileName = 'main.tex';
  String _mainFileName = 'main.tex';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSaving = false;

  static String get _authorName {
    final u = FbAuth.instance.currentUser;
    if (u != null && u.displayName != null && u.displayName!.trim().isNotEmpty) {
      return u.displayName!.trim();
    }
    return 'Flow Learner';
  }

  Map<String, Map<String, String>> get _multiFileTemplates => {
    'Academic Paper (BibTeX)': {
      'main.tex': r'''\documentclass[11pt,a4paper]{article}
\usepackage[utf8]{inputenc}
\usepackage{amsmath,amssymb,amsfonts}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{cite}

\title{\textbf{Deep Neural Representations \& Autonomous Reasoning}}
\author{\textbf{''' + _authorName + r'''} \\ Department of Computer Science}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
This paper presents a formal analysis of neural network optimization and mathematical foundations of deep representation learning. Bibliographical sources are organized in the companion \texttt{references.bib} file.
\end{abstract}

\section{Introduction}
Modern machine learning models rely heavily on loss minimization \cite{goodfellow2016}. Given a dataset $\mathcal{D} = \{(x_i, y_i)\}_{i=1}^N$, we optimize the loss function:
\begin{equation}
\mathcal{L}(\theta) = \frac{1}{N} \sum_{i=1}^N \ell(f(x_i; \theta), y_i) + \lambda \|\theta\|^2_2
\end{equation}

\section{Transformer Architectures}
Attention mechanisms allow sequence-to-sequence mapping with quadratic scaling \cite{vaswani2017}:
\begin{equation}
\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{QK^T}{\sqrt{d_k}}\right) V
\end{equation}

\section{Algorithmic Complexity}
Foundational algorithms in computational complexity follow established asymptotic principles \cite{knuth1997, lamport1994}.

\bibliographystyle{plain}
\bibliography{references}

\end{document}''',
      'references.bib': r'''@article{vaswani2017,
  author    = {Vaswani, Ashish and Shazeer, Noam and Parmar, Niki and Uszkoreit, Jakob and Jones, Llion and Gomez, Aidan N. and Kaiser, Lukasz and Polosukhin, Illia},
  title     = {Attention Is All You Need},
  journal   = {Advances in Neural Information Processing Systems},
  volume    = {30},
  year      = {2017}
}

@book{goodfellow2016,
  author    = {Goodfellow, Ian and Bengio, Yoshua and Courville, Aaron},
  title     = {Deep Learning},
  publisher = {MIT Press},
  year      = {2016}
}

@book{knuth1997,
  author    = {Knuth, Donald E.},
  title     = {The Art of Computer Programming, Vol 1},
  publisher = {Addison-Wesley},
  year      = {1997}
}

@book{lamport1994,
  author    = {Lamport, Leslie},
  title     = {\LaTeX: A Document Preparation System},
  publisher = {Addison-Wesley},
  year      = {1994}
}''',
    },

    'Multi-Chapter Report': {
      'main.tex': r'''\documentclass[11pt,a4paper]{report}
\usepackage[utf8]{inputenc}
\usepackage{amsmath,amssymb}
\usepackage{cite}

\title{\textbf{Principles of Computation \& Modern AI}}
\author{''' + _authorName + r'''}
\date{\today}

\begin{document}
\maketitle
\tableofcontents

\include{chapter1}
\include{chapter2}

\bibliographystyle{plain}
\bibliography{references}

\end{document}''',
      'chapter1.tex': r'''\chapter{Foundations of Computation}
\section{Automata \& Formal Grammars}
A Turing machine is defined as a 7-tuple $M = \langle Q, \Sigma, \Gamma, \delta, q_0, q_{accept}, q_{reject} \rangle$.
Complexity classes evaluate algorithmic efficiency \cite{knuth1997}:
\begin{equation}
T(n) = \mathcal{O}(n \log n)
\end{equation}''',
      'chapter2.tex': r'''\chapter{Deep Learning Architectures}
\section{Transformers \& Self-Attention}
Self-attention transforms inputs into key, query, and value subspaces \cite{vaswani2017, goodfellow2016}.
\begin{equation}
\mathbf{h}_i = \sum_{j=1}^N \alpha_{ij} \mathbf{v}_j
\end{equation}''',
      'references.bib': r'''@article{vaswani2017,
  author  = {Vaswani, Ashish and others},
  title   = {Attention Is All You Need},
  journal = {NeurIPS},
  year    = {2017}
}

@book{goodfellow2016,
  author    = {Goodfellow, Ian and others},
  title     = {Deep Learning},
  publisher = {MIT Press},
  year      = {2016}
}

@book{knuth1997,
  author    = {Knuth, Donald E.},
  title     = {The Art of Computer Programming},
  publisher = {Addison-Wesley},
  year      = {1997}
}''',
    },

    'Hello World': {
      'main.tex': r'''\documentclass{article}
\usepackage{cite}
\begin{document}

\title{Hello World with BibTeX}
\author{''' + _authorName + r'''}
\maketitle

\section{Introduction}
Hello World! Welcome to multi-file LaTeX typesetting \cite{lamport1994}.

\section{Mathematics}
Here is a simple equation:
\[ E = mc^2 \]

\bibliographystyle{plain}
\bibliography{references}

\end{document}''',
      'references.bib': r'''@book{lamport1994,
  author    = {Lamport, Leslie},
  title     = {\LaTeX: A Document Preparation System},
  publisher = {Addison-Wesley},
  year      = {1994}
}''',
    },

    'Math & Physics': {
      'main.tex': r'''\documentclass[12pt]{article}
\usepackage{amsmath,amssymb,amsthm}
\usepackage{cite}

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

\bibliographystyle{plain}
\bibliography{references}

\end{document}''',
      'references.bib': r'''@book{euler1748,
  author    = {Euler, Leonhard},
  title     = {Introductio in analysin infinitorum},
  year      = {1748}
}

@article{maxwell1865,
  author    = {Maxwell, James Clerk},
  title     = {A Dynamical Theory of the Electromagnetic Field},
  journal   = {Philosophical Transactions of the Royal Society of London},
  year      = {1865}
}''',
    },

    'Beamer Slides': {
      'main.tex': r'''\documentclass{beamer}
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

\begin{frame}[allowframebreaks]{References}
\bibliographystyle{plain}
\bibliography{references}
\end{frame}

\end{document}''',
      'references.bib': r'''@book{nielsen2010,
  author    = {Nielsen, Michael A. and Chuang, Isaac L.},
  title     = {Quantum Computation and Quantum Information},
  publisher = {Cambridge University Press},
  year      = {2010}
}''',
    },

    'Resume / CV': {
      'main.tex': r'''\documentclass[11pt,a4paper]{article}
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

\bibliographystyle{plain}
\bibliography{references}

\end{document}''',
      'references.bib': r'''@article{flow2026,
  author  = {Flow Research},
  title   = {Client-side WebAssembly TeX compilation engine},
  journal = {Duofy Systems},
  year    = {2026}
}''',
    },
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

    // Initialize files from project or default template
    if (widget.existingProject?.files.isNotEmpty == true) {
      _files = Map<String, String>.from(widget.existingProject!.files);
      _activeFileName = widget.existingProject!.activeFile ?? _files.keys.first;
      _mainFileName = _files.containsKey('main.tex')
          ? 'main.tex'
          : _files.keys.firstWhere((k) => k.endsWith('.tex'), orElse: () => _files.keys.first);
    } else {
      final existingCode = widget.existingProject?.codeContent ?? '';
      if (existingCode.isNotEmpty) {
        _files = {'main.tex': existingCode, 'references.bib': _defaultBibContent};
        _activeFileName = 'main.tex';
        _mainFileName = 'main.tex';
      } else {
        final defaultTemplate = _multiFileTemplates['Academic Paper (BibTeX)']!;
        _files = Map<String, String>.from(defaultTemplate);
        _activeFileName = 'main.tex';
        _mainFileName = 'main.tex';
      }
    }

    _openTabs = _files.keys.toList();
    if (!_openTabs.contains(_activeFileName)) {
      _openTabs.insert(0, _activeFileName);
    }

    final initialCode = _files[_activeFileName] ?? '';
    _texController = CodeEditingController(
      text: initialCode,
      language: _getLanguageForFile(_activeFileName),
    );

    _texController.addListener(_onTextChanged);
    _titleController.addListener(_onTextChanged);
  }

  static String get _defaultBibContent => r'''@article{example2026,
  author  = {Author, Sample},
  title   = {Sample Reference Title},
  journal = {Journal of Modern LaTeX},
  year    = {2026}
}''';

  String _getLanguageForFile(String filename) {
    if (filename.endsWith('.bib')) return 'bibtex';
    if (filename.endsWith('.tex') || filename.endsWith('.sty') || filename.endsWith('.cls')) {
      return 'latex';
    }
    return 'latex';
  }

  IconData _getIconForFile(String filename) {
    if (filename.endsWith('.bib')) return LucideIcons.bookMarked;
    if (filename.endsWith('.sty') || filename.endsWith('.cls')) return LucideIcons.palette;
    if (filename.endsWith('.tex')) return LucideIcons.fileText;
    return LucideIcons.file;
  }

  Color _getColorForFile(String filename) {
    if (filename.endsWith('.bib')) return AppTheme.duoViolet;
    if (filename.endsWith('.sty') || filename.endsWith('.cls')) return AppTheme.duoOrange;
    if (filename.endsWith('.tex')) return AppTheme.duoBlue;
    return Colors.grey;
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
    _files[_activeFileName] = _texController.text;
    _autosaveTimer?.cancel();
    _autosaveTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _saveProject(silent: true);
      }
    });
  }

  void _switchToFile(String fileName) {
    if (_activeFileName == fileName) return;

    // Save current active text
    _files[_activeFileName] = _texController.text;

    if (!_openTabs.contains(fileName)) {
      _openTabs.add(fileName);
    }

    setState(() {
      _activeFileName = fileName;
      _texController.text = _files[fileName] ?? '';
      _texController.language = _getLanguageForFile(fileName);
    });
  }

  void _closeTab(String fileName) {
    if (_openTabs.length <= 1) return;

    final index = _openTabs.indexOf(fileName);
    setState(() {
      _openTabs.remove(fileName);
      if (_activeFileName == fileName) {
        final newIndex = index.clamp(0, _openTabs.length - 1);
        _activeFileName = _openTabs[newIndex];
        _texController.text = _files[_activeFileName] ?? '';
        _texController.language = _getLanguageForFile(_activeFileName);
      }
    });
  }

  void _promptCreateNewFile() {
    final nameCtrl = TextEditingController(text: 'references.bib');
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) {
          return AlertDialog(
            backgroundColor: context.colors.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              children: [
                const Icon(LucideIcons.filePlus, color: AppTheme.duoGreen, size: 20),
                const SizedBox(width: 8),
                Text(
                  'New File',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: context.colors.textPrimary,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter filename with extension (.tex, .bib, .sty):',
                  style: TextStyle(fontSize: 13, color: context.colors.textSecondary),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nameCtrl,
                  autofocus: true,
                  style: TextStyle(color: context.colors.textPrimary, fontFamily: 'monospace'),
                  decoration: InputDecoration(
                    hintText: 'e.g. references.bib, chapter1.tex',
                    filled: true,
                    fillColor: context.colors.background,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  children: [
                    ActionChip(
                      label: const Text('references.bib', style: TextStyle(fontSize: 11)),
                      onPressed: () => setDialogState(() => nameCtrl.text = 'references.bib'),
                    ),
                    ActionChip(
                      label: const Text('chapter1.tex', style: TextStyle(fontSize: 11)),
                      onPressed: () => setDialogState(() => nameCtrl.text = 'chapter1.tex'),
                    ),
                    ActionChip(
                      label: const Text('macros.sty', style: TextStyle(fontSize: 11)),
                      onPressed: () => setDialogState(() => nameCtrl.text = 'macros.sty'),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Cancel', style: TextStyle(color: context.colors.textFaint)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.duoGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  final name = nameCtrl.text.trim();
                  if (name.isEmpty) return;
                  if (_files.containsKey(name)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('File "$name" already exists.')),
                    );
                    return;
                  }

                  Navigator.pop(ctx);

                  String defaultContent = '';
                  if (name.endsWith('.bib')) {
                    defaultContent = _defaultBibContent;
                  } else if (name.endsWith('.tex')) {
                    defaultContent = '% $name\n\\section{${name.replaceAll('.tex', '')}}\n\n';
                  }

                  setState(() {
                    _files[name] = defaultContent;
                    if (!_openTabs.contains(name)) _openTabs.add(name);
                    _activeFileName = name;
                    _texController.text = defaultContent;
                    _texController.language = _getLanguageForFile(name);
                  });
                  _saveProject(silent: true);
                },
                child: const Text('Create File'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _promptRenameFile(String oldName) {
    final nameCtrl = TextEditingController(text: oldName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Rename File',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.colors.textPrimary,
          ),
        ),
        content: TextField(
          controller: nameCtrl,
          autofocus: true,
          style: TextStyle(color: context.colors.textPrimary, fontFamily: 'monospace'),
          decoration: InputDecoration(
            hintText: 'New file name',
            filled: true,
            fillColor: context.colors.background,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: context.colors.textFaint)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.duoBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              final newName = nameCtrl.text.trim();
              if (newName.isEmpty || newName == oldName) {
                Navigator.pop(ctx);
                return;
              }
              if (_files.containsKey(newName)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('File "$newName" already exists.')),
                );
                return;
              }

              Navigator.pop(ctx);
              final content = _files.remove(oldName) ?? '';
              _files[newName] = content;

              final tabIdx = _openTabs.indexOf(oldName);
              if (tabIdx != -1) {
                _openTabs[tabIdx] = newName;
              }

              if (_activeFileName == oldName) {
                _activeFileName = newName;
              }
              if (_mainFileName == oldName) {
                _mainFileName = newName;
              }

              setState(() {});
              _saveProject(silent: true);
            },
            child: const Text('Rename'),
          ),
        ],
      ),
    );
  }

  void _promptDeleteFile(String fileName) {
    if (_files.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot delete the only file in the project.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete "$fileName"?',
          style: TextStyle(fontWeight: FontWeight.bold, color: context.colors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to permanently delete this file from your LaTeX project?',
          style: TextStyle(color: context.colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: context.colors.textFaint)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _files.remove(fileName);
                _openTabs.remove(fileName);

                if (_mainFileName == fileName) {
                  _mainFileName = _files.keys.firstWhere(
                    (k) => k.endsWith('.tex'),
                    orElse: () => _files.keys.first,
                  );
                }

                if (_activeFileName == fileName) {
                  _activeFileName = _openTabs.isNotEmpty ? _openTabs.first : _files.keys.first;
                  _texController.text = _files[_activeFileName] ?? '';
                  _texController.language = _getLanguageForFile(_activeFileName);
                }
              });
              _saveProject(silent: true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _setAsMainFile(String fileName) {
    setState(() {
      _mainFileName = fileName;
    });
    _saveProject(silent: true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Root compilation file set to "$fileName"'),
        backgroundColor: AppTheme.duoGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _loadTemplate(String name) {
    if (_multiFileTemplates.containsKey(name)) {
      final template = _multiFileTemplates[name]!;
      setState(() {
        _files = Map<String, String>.from(template);
        _openTabs = _files.keys.toList();
        _mainFileName = _files.containsKey('main.tex')
            ? 'main.tex'
            : _files.keys.firstWhere((k) => k.endsWith('.tex'), orElse: () => _files.keys.first);
        _activeFileName = _mainFileName;
        _texController.text = _files[_activeFileName] ?? '';
        _texController.language = _getLanguageForFile(_activeFileName);
      });
      _saveProject(silent: true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Loaded "$name" multi-file template'),
          backgroundColor: AppTheme.duoGreen,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _openPdfPreview() async {
    final title = _titleController.text.trim().isEmpty
        ? 'LaTeX Studio'
        : _titleController.text.trim();

    // Sync active editor buffer to files
    _files[_activeFileName] = _texController.text;

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
                      'Compiling Multi-file LaTeX...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Resolving BibTeX & TeX Live dependencies...',
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
      // Build resources array with ALL project files
      final resources = _files.entries.map((entry) {
        final isMain = (entry.key == _mainFileName);
        final content = (entry.key == _activeFileName) ? _texController.text : entry.value;
        return {
          'main': isMain,
          'path': entry.key,
          'content': content,
        };
      }).toList();

      final response = await http.post(
        Uri.parse('https://latex.ytotech.com/builds/sync'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'compiler': 'pdflatex',
          'resources': resources,
        }),
      ).timeout(const Duration(seconds: 40));

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

        await _openPdfInViewer(file.path, title, 'Compiled Multi-file TeX Live Output PDF');
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
              if (decoded['shape_errors'] != null) {
                extractedLog += '\n${decoded['shape_errors']}';
              }
            }
          }
        } catch (_) {}

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
          final offlineFile = await _generateOfflinePdf(title);
          await _openPdfInViewer(offlineFile.path, '$title (Offline)', 'Offline Generated Multi-file LaTeX PDF');
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
        final mainContent = _files[_mainFileName] ?? _texController.text;
        _showCompilationErrorDialog(onlineErrorMessage, mainContent);
      }
    }
  }

  Future<void> _saveProject({bool silent = false}) async {
    if (!_isSaving && mounted) {
      setState(() {
        _isSaving = true;
      });
    }

    // Sync active editor buffer
    _files[_activeFileName] = _texController.text;

    final project = IdeProject(
      id: _projectId,
      title: _titleController.text.trim().isEmpty
          ? 'LaTeX Studio'
          : _titleController.text.trim(),
      type: 'latex_ide',
      language: 'latex',
      codeContent: _files[_mainFileName] ?? _texController.text,
      files: Map<String, String>.from(_files),
      activeFile: _activeFileName,
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
            content: Text('LaTeX Multi-file Project saved!'),
            backgroundColor: AppTheme.duoGreen,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (_files.isEmpty) {
      _files = {'main.tex': _texController.text};
    }
    if (!_files.containsKey(_activeFileName)) {
      _activeFileName = _files.keys.first;
    }
    if (!_openTabs.contains(_activeFileName)) {
      _openTabs.add(_activeFileName);
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

        return CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.enter, control: true): _openPdfPreview,
            const SingleActivator(LogicalKeyboardKey.enter, meta: true): _openPdfPreview,
            const SingleActivator(LogicalKeyboardKey.keyB, control: true): () {
              if (_scaffoldKey.currentState?.isDrawerOpen == true) {
                Navigator.of(context).pop();
              } else {
                _scaffoldKey.currentState?.openDrawer();
              }
            },
            const SingleActivator(LogicalKeyboardKey.keyB, meta: true): () {
              if (_scaffoldKey.currentState?.isDrawerOpen == true) {
                Navigator.of(context).pop();
              } else {
                _scaffoldKey.currentState?.openDrawer();
              }
            },
          },
          child: Scaffold(
            key: _scaffoldKey,
            drawer: _buildFileDrawer(isDark),
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(LucideIcons.arrowLeft),
                onPressed: () => Navigator.pop(context),
              ),
              title: TextField(
                controller: _titleController,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'LaTeX Project Title...',
                  isDense: true,
                ),
              ),
              actions: [
                // Open File Explorer Drawer
                IconButton(
                  icon: const Icon(
                    LucideIcons.folderGit2,
                    size: 20,
                    color: AppTheme.duoBlue,
                  ),
                  tooltip: 'Project Files',
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                // Play Icon Button
                IconButton(
                  icon: const Icon(LucideIcons.play, color: AppTheme.duoGreen, size: 20),
                  tooltip: 'Run / Compile PDF',
                  onPressed: _openPdfPreview,
                ),
                // Menu Button for options & templates
                PopupMenuButton<String>(
                  icon: const Icon(LucideIcons.moreVertical, size: 20),
                  tooltip: 'More Options',
                  onSelected: (val) {
                    if (val.startsWith('template:')) {
                      _loadTemplate(val.replaceFirst('template:', ''));
                    } else if (val == 'new_file') {
                      _promptCreateNewFile();
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
                          const Text('Save Project'),
                          const Spacer(),
                          const Text('Autosave On', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'new_file',
                      child: Row(
                        children: [
                          Icon(LucideIcons.filePlus, size: 16, color: AppTheme.duoBlue),
                          SizedBox(width: 10),
                          Text('New Project File'),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      enabled: false,
                      child: Text('MULTI-FILE TEMPLATES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ),
                    const PopupMenuItem(
                      value: 'template:Academic Paper (BibTeX)',
                      child: Row(
                        children: [
                          Icon(LucideIcons.bookOpen, size: 16, color: AppTheme.duoBlue),
                          SizedBox(width: 8),
                          Text('Academic Paper (with BibTeX)'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'template:Multi-Chapter Report',
                      child: Row(
                        children: [
                          Icon(LucideIcons.layers, size: 16, color: AppTheme.duoGreen),
                          SizedBox(width: 8),
                          Text('Multi-Chapter Report (Includes)'),
                        ],
                      ),
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
              child: Column(
                children: [
                  _buildTopTabBar(isDark),
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

  Widget _buildFileDrawer(bool isDark) {
    final drawerBg = isDark ? const Color(0xFF161B22) : const Color(0xFFF8FAFC);
    final surfaceBg = isDark ? const Color(0xFF0D1117) : Colors.white;
    final borderColor = context.colors.outline.withValues(alpha: 0.2);

    return Drawer(
      backgroundColor: drawerBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: surfaceBg,
                border: Border(bottom: BorderSide(color: borderColor)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.duoBlue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(LucideIcons.folderGit2, color: AppTheme.duoBlue, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Project Files',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: context.colors.textPrimary,
                              ),
                            ),
                            Text(
                              '${_files.length} file${_files.length == 1 ? '' : 's'} in project',
                              style: TextStyle(
                                fontSize: 11,
                                color: context.colors.textFaint,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.x, size: 18),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.duoGreen,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(LucideIcons.plus, size: 15),
                          label: const Text('New File', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.pop(context);
                            _promptCreateNewFile();
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppTheme.duoViolet.withValues(alpha: 0.5)),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(LucideIcons.bookMarked, size: 15, color: AppTheme.duoViolet),
                          label: const Text('Add BibTeX', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.duoViolet)),
                          onPressed: () {
                            Navigator.pop(context);
                            if (_files.containsKey('references.bib')) {
                              _switchToFile('references.bib');
                            } else {
                              setState(() {
                                _files['references.bib'] = _defaultBibContent;
                                if (!_openTabs.contains('references.bib')) _openTabs.add('references.bib');
                                _activeFileName = 'references.bib';
                                _texController.text = _defaultBibContent;
                                _texController.language = 'bibtex';
                              });
                              _saveProject(silent: true);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // File list header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                'WORKSPACE EXPLORER',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                  color: context.colors.textFaint,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                children: _files.keys.map((fileName) {
                  final isActive = (fileName == _activeFileName);
                  final isMain = (fileName == _mainFileName);
                  final icon = _getIconForFile(fileName);
                  final iconColor = _getColorForFile(fileName);

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                      color: isActive
                          ? (isDark ? const Color(0xFF21262D) : const Color(0xFFE2E8F0))
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: isActive
                          ? Border.all(color: AppTheme.duoBlue.withValues(alpha: 0.5), width: 1.2)
                          : null,
                    ),
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.only(left: 12, right: 6),
                      leading: Icon(icon, size: 18, color: iconColor),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              fileName,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
                                color: isActive ? context.colors.textPrimary : context.colors.textSecondary,
                                fontFamily: 'monospace',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isMain)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.duoGreen.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'MAIN',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.duoGreen,
                                ),
                              ),
                            ),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        icon: Icon(LucideIcons.moreVertical, size: 16, color: context.colors.textFaint),
                        padding: EdgeInsets.zero,
                        onSelected: (val) {
                          if (val == 'set_main') {
                            _setAsMainFile(fileName);
                          } else if (val == 'rename') {
                            _promptRenameFile(fileName);
                          } else if (val == 'delete') {
                            _promptDeleteFile(fileName);
                          }
                        },
                        itemBuilder: (ctx) => [
                          if (fileName.endsWith('.tex') && !isMain)
                            const PopupMenuItem(
                              value: 'set_main',
                              child: Row(
                                children: [
                                  Icon(LucideIcons.checkCheck, size: 15, color: AppTheme.duoGreen),
                                  SizedBox(width: 8),
                                  Text('Set as Main TeX Root', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          const PopupMenuItem(
                            value: 'rename',
                            child: Row(
                              children: [
                                Icon(LucideIcons.edit2, size: 15),
                                SizedBox(width: 8),
                                Text('Rename', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          if (_files.length > 1)
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(LucideIcons.trash2, size: 15, color: Colors.redAccent),
                                  SizedBox(width: 8),
                                  Text('Delete', style: TextStyle(fontSize: 12, color: Colors.redAccent)),
                                ],
                              ),
                            ),
                        ],
                      ),
                      onTap: () {
                        _switchToFile(fileName);
                        Navigator.pop(context);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            // Bottom Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: surfaceBg,
                border: Border(top: BorderSide(color: borderColor)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.sparkles, size: 15, color: AppTheme.duoGreen),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Multi-file LaTeX Engine',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: context.colors.textFaint,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      IdeConfigDialog.show(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(LucideIcons.slidersHorizontal, size: 16, color: context.colors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTabBar(bool isDark) {
    final tabBg = isDark ? const Color(0xFF161B22) : const Color(0xFFE2E8F0);
    final borderColor = context.colors.outline.withValues(alpha: 0.25);

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: tabBg,
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Row(
        children: [
          // Drawer trigger button
          InkWell(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: borderColor)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.folderGit2, size: 15, color: AppTheme.duoBlue),
                  const SizedBox(width: 5),
                  Text(
                    'Files',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _openTabs.map((fileName) {
                  final isActive = (fileName == _activeFileName);
                  final isMain = (fileName == _mainFileName);
                  final icon = _getIconForFile(fileName);
                  final iconColor = _getColorForFile(fileName);

                  final activeBg = isDark ? const Color(0xFF0D1117) : const Color(0xFFF8FAFC);
                  final inactiveBg = Colors.transparent;

                  return InkWell(
                    onTap: () => _switchToFile(fileName),
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isActive ? activeBg : inactiveBg,
                        border: Border(
                          right: BorderSide(color: borderColor),
                          top: isActive
                              ? BorderSide(color: iconColor, width: 2)
                              : BorderSide.none,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon, size: 14, color: iconColor),
                          const SizedBox(width: 6),
                          Text(
                            fileName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                              color: isActive ? context.colors.textPrimary : context.colors.textSecondary,
                              fontFamily: 'monospace',
                            ),
                          ),
                          if (isMain) ...[
                            const SizedBox(width: 4),
                            Text(
                              '(main)',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.duoGreen.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                          const SizedBox(width: 8),
                          if (_openTabs.length > 1)
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => _closeTab(fileName),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Icon(
                                  LucideIcons.x,
                                  size: 13,
                                  color: context.colors.textFaint,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // New file icon button in tab bar
          IconButton(
            icon: const Icon(LucideIcons.plus, size: 16),
            tooltip: 'New File',
            onPressed: _promptCreateNewFile,
          ),
        ],
      ),
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
                hintText: _activeFileName.endsWith('.bib')
                    ? r'Write BibTeX entries (e.g. @article{...}, @book{...})...'
                    : r'Write LaTeX code...',
                hintStyle: TextStyle(
                  color: isDark ? const Color(0xFF6E7781) : const Color(0xFF8C959F),
                  fontSize: 12,
                ),
              ),
            ),
          ),
          // Bottom status bar (Line, Column & Active File tracking)
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
                    Icon(_getIconForFile(_activeFileName), size: 12, color: _getColorForFile(_activeFileName)),
                    const SizedBox(width: 6),
                    Text(
                      _activeFileName,
                      style: TextStyle(
                        fontSize: 11,
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 12),
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
            _files[_activeFileName] = newCode;
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

  Future<File> _generateOfflinePdf(String title) async {
    final pdf = pw.Document();

    // Start with the main TeX file
    var mainTex = _files[_mainFileName] ?? _texController.text;

    // Inline \include{...} and \input{...}
    final includeRegex = RegExp(r'\\(?:include|input)\{([^}]+)\}');
    mainTex = mainTex.replaceAllMapped(includeRegex, (match) {
      var incName = match.group(1)?.trim() ?? '';
      if (!incName.endsWith('.tex')) incName = '$incName.tex';
      return _files[incName] ?? '';
    });

    String docTitle = title;
    String docAuthor = '';
    String docDate = '';

    final tMatch = RegExp(r'\\title\{([\s\S]*?)\}').firstMatch(mainTex);
    if (tMatch != null && tMatch.group(1)!.trim().isNotEmpty) {
      docTitle = tMatch.group(1)!.replaceAll(RegExp(r'\\[a-zA-Z]+'), '').trim();
    }
    final aMatch = RegExp(r'\\author\{([\s\S]*?)\}').firstMatch(mainTex);
    if (aMatch != null) {
      docAuthor = aMatch.group(1)!.replaceAll(RegExp(r'\\[a-zA-Z]+'), '').trim();
    }
    final dMatch = RegExp(r'\\date\{([\s\S]*?)\}').firstMatch(mainTex);
    if (dMatch != null) {
      final nowStr = DateTime.now().toString().split(' ')[0];
      docDate = dMatch.group(1)!.replaceAll(r'\today', nowStr).replaceAll(RegExp(r'\\[a-zA-Z]+'), '').trim();
    }

    // Parse custom macros
    final customMacros = <String, String>{};
    final macroRegex = RegExp(r'\\(?:newcommand|def)\{?\\([a-zA-Z]+)\}?\{([\s\S]*?)\}');
    for (final match in macroRegex.allMatches(mainTex)) {
      final name = match.group(1);
      final body = match.group(2);
      if (name != null && body != null) {
        customMacros[name] = body;
      }
    }

    var processedTex = mainTex;
    customMacros.forEach((name, replacement) {
      processedTex = processedTex.replaceAll('\\$name', replacement);
    });

    // Parse BibTeX bibliography files
    final bibEntries = <String, String>{};
    final bibKeyToNumber = <String, int>{};
    int bibCounter = 1;

    for (final entry in _files.entries) {
      if (entry.key.endsWith('.bib')) {
        final bibContent = entry.value;
        final entryRegex = RegExp(r'@([a-zA-Z]+)\s*\{\s*([^,]+),([\s\S]*?)(?=\n@|\Z)');
        for (final m in entryRegex.allMatches(bibContent)) {
          final key = m.group(2)?.trim() ?? '';
          final body = m.group(3) ?? '';

          String parseField(String field) {
            final fMatch = RegExp('$field\\s*=\\s*[\\{"]([\\s\\S]*?)[\\}"]', caseSensitive: false).firstMatch(body);
            return fMatch?.group(1)?.trim().replaceAll(RegExp(r'[\r\n\t]+'), ' ') ?? '';
          }

          final author = parseField('author');
          final entryTitle = parseField('title');
          final journal = parseField('journal');
          final publisher = parseField('publisher');
          final year = parseField('year');

          var formatted = '';
          if (author.isNotEmpty) formatted += '$author. ';
          if (entryTitle.isNotEmpty) formatted += '"$entryTitle". ';
          if (journal.isNotEmpty) formatted += '$journal, ';
          if (publisher.isNotEmpty) formatted += '$publisher, ';
          if (year.isNotEmpty) formatted += '($year).';

          if (key.isNotEmpty) {
            bibKeyToNumber[key] = bibCounter;
            bibEntries[key] = formatted.isNotEmpty ? formatted : key;
            bibCounter++;
          }
        }
      }
    }

    final lines = processedTex.split('\n');
    final contentWidgets = <pw.Widget>[];

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
          line.startsWith(r'\makeindex') ||
          line.startsWith(r'\bibliographystyle')) {
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

      if (line.startsWith(r'\bibliography{') || line.startsWith(r'\begin{thebibliography}')) {
        contentWidgets.add(pw.SizedBox(height: 14));
        contentWidgets.add(pw.Text('References', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)));
        contentWidgets.add(pw.Divider(thickness: 0.5, color: PdfColors.blue900));
        contentWidgets.add(pw.SizedBox(height: 4));

        if (bibEntries.isNotEmpty) {
          bibEntries.forEach((key, val) {
            final numTag = bibKeyToNumber[key] ?? 1;
            contentWidgets.add(
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 4, bottom: 2),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 28, child: pw.Text('[$numTag]', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900))),
                    pw.Expanded(child: pw.Text(val, style: const pw.TextStyle(fontSize: 10, lineSpacing: 2))),
                  ],
                ),
              ),
            );
          });
        }
        continue;
      }

      // Replace \cite{key} with [num]
      var cleanLine = line.replaceAllMapped(RegExp(r'\\cite\{([^}]+)\}'), (match) {
        final key = match.group(1)?.trim() ?? '';
        final numTag = bibKeyToNumber[key];
        return numTag != null ? '[$numTag]' : '[1]';
      });

      cleanLine = cleanLine
          .replaceAll(RegExp(r'\\index\{([^}]+)\}'), r'$1')
          .replaceAll(RegExp(r'\\textbf\{([^}]+)\}'), r'$1')
          .replaceAll(RegExp(r'\\textit\{([^}]+)\}'), r'$1')
          .replaceAll(RegExp(r'\\underline\{([^}]+)\}'), r'$1')
          .replaceAll(RegExp(r'\\texttt\{([^}]+)\}'), r'$1')
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
                            color: textFaint,
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
              child: _isLoading
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(color: AppTheme.duoGreen),
                          const SizedBox(height: 16),
                          Text(
                            'Analyzing TeX compilation log with AI...',
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    )
                  : _errorMessage != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  LucideIcons.alertCircle,
                                  color: Colors.redAccent,
                                  size: 36,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Analysis Failed',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _errorMessage!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textFaint,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.duoGreen,
                                    foregroundColor: Colors.white,
                                  ),
                                  icon: const Icon(LucideIcons.rotateCw, size: 16),
                                  label: const Text('Retry'),
                                  onPressed: _fetchExplanation,
                                ),
                              ],
                            ),
                          ),
                        )
                      : _buildResultView(isDark, textPrimary, textSecondary, textFaint),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView(
    bool isDark,
    Color textPrimary,
    Color textSecondary,
    Color textFaint,
  ) {
    final explanation = _explanationResult?['explanation'] as String? ?? 'No explanation provided.';
    final fixedCode = _explanationResult?['fixedCode'] as String?;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Explanation Box
          Row(
            children: [
              const Icon(LucideIcons.info, size: 16, color: AppTheme.duoBlue),
              const SizedBox(width: 6),
              Text(
                'WHY THIS ERROR OCCURRED',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: textFaint,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF161B22) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.colors.outline.withValues(alpha: 0.3),
              ),
            ),
            child: MarkdownBody(
              data: explanation,
              selectable: true,
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                p: TextStyle(fontSize: 13, height: 1.4, color: textPrimary),
                code: TextStyle(
                  backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF1D4ED8),
                ),
                codeblockDecoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0D1117) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.colors.outline.withValues(alpha: 0.2)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                border: Border.all(color: AppTheme.duoGreen.withValues(alpha: 0.4)),
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
