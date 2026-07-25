import 'package:flutter/material.dart';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import '../models/app_models.dart';
import '../services/generation_manager.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/file_selection_list.dart';
import '../widgets/responsive_center.dart';
import '../widgets/math_markdown.dart';
import 'source_pdf_upload_screen.dart';
import '../platform/io_shim.dart';
import '../services/b2_service.dart';

class PyqTabScreen extends StatefulWidget {
  final Book book;
  final VoidCallback onBookUpdated;

  /// The module currently open on the Path tab. Extraction and the displayed
  /// question list are scoped to this module.
  final ValueNotifier<int>? activeModule;

  const PyqTabScreen({
    super.key,
    required this.book,
    required this.onBookUpdated,
    this.activeModule,
  });

  @override
  State<PyqTabScreen> createState() => _PyqTabScreenState();
}

class _PyqTabScreenState extends State<PyqTabScreen> {
  final List<PlatformFile> _selectedFiles = [];
  String? _selectedSectionId;
  final TextEditingController _customPromptCtrl = TextEditingController();
  String? _cacheDirPath;
  late Book _currentBook;
  StreamSubscription<Book>? _bookSub;

  @override
  void initState() {
    super.initState();
    _currentBook = widget.book;
    _initCacheDir();
    _bookSub = GenerationManager.instance.bookUpdates.listen((updatedBook) {
      if (updatedBook.id == widget.book.id && mounted) {
        setState(() {
          _currentBook = updatedBook;
        });
        widget.onBookUpdated();
      }
    });
  }

  @override
  void didUpdateWidget(PyqTabScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.book != widget.book) {
      _currentBook = widget.book;
    }
  }

  Future<void> _initCacheDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    if (mounted) {
      setState(() {
        _cacheDirPath = '${appDir.path}/b2_cache';
      });
    }
  }

  Future<void> _selectFromStore() async {
    final configured = await B2Service.instance.isConfigured();
    if (!configured) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: context.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Cloud Storage Required',
            style: TextStyle(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Backblaze B2 is not configured. Please setup cloud storage in the Document Store tab first.',
            style: TextStyle(color: context.colors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: AppTheme.duoGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    if (!mounted) return;
    final B2Object? selected = await showDialog<B2Object>(
      context: context,
      builder: (ctx) => const DocumentStorePickerDialog(forPyq: true),
    );

    if (selected != null && mounted) {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${appDir.path}/b2_cache');
      final file = File('${cacheDir.path}/${selected.key}');

      if (file.existsSync()) {
        final bytes = file.readAsBytesSync();
        final name = file.path.split('/').last.split('\\').last;
        final pFile = PlatformFile(
          path: file.path,
          name: name,
          size: bytes.length,
          bytes: bytes,
        );
        setState(() {
          _selectedFiles.add(pFile);
        });
        return;
      }

      if (!mounted) return;
      final File? downloadedFile = await showDialog<File>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => DownloadProgressDialog(b2Obj: selected),
      );

      if (downloadedFile != null && downloadedFile.existsSync() && mounted) {
        final bytes = downloadedFile.readAsBytesSync();
        final name = downloadedFile.path.split('/').last.split('\\').last;
        final pFile = PlatformFile(
          path: downloadedFile.path,
          name: name,
          size: bytes.length,
          bytes: bytes,
        );
        setState(() {
          _selectedFiles.add(pFile);
        });
      }
    }
  }

  // Fallback when no shared notifier is supplied (e.g. previews/tests).
  ValueNotifier<int>? _ownModuleNotifier;
  ValueNotifier<int> get _moduleNotifier =>
      widget.activeModule ?? (_ownModuleNotifier ??= ValueNotifier<int>(0));

  int get _moduleIdx {
    if (_currentBook.modules.isEmpty) return 0;
    return _moduleNotifier.value.clamp(0, _currentBook.modules.length - 1);
  }

  @override
  void dispose() {
    _bookSub?.cancel();
    _customPromptCtrl.dispose();
    _ownModuleNotifier?.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _selectedFiles.addAll(result.files);
      });
    }
  }

  void _startAnalysis() {
    final pyqTask = GenerationManager.instance.activePyqTasks[_currentBook.id];
    if (pyqTask != null) {
      print('[PYQ_DIAGNOSTIC] _startAnalysis ignored: pyqTask is already running for book ${_currentBook.id}');
      return;
    }

    if (_selectedFiles.isEmpty) {
      print('[PYQ_DIAGNOSTIC] _startAnalysis failed: _selectedFiles is empty');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one exam paper PDF/Image.'),
        ),
      );
      return;
    }

    if (_currentBook.modules.isEmpty) {
      print('[PYQ_DIAGNOSTIC] _startAnalysis warning: _currentBook.modules is empty');
    }
    final moduleIdx = _moduleIdx;
    final customInstructions = _customPromptCtrl.text.trim();

    for (int i = 0; i < _selectedFiles.length; i++) {
      final sf = _selectedFiles[i];
      print('[PYQ_DIAGNOSTIC] Selected File #$i: ${sf.name} (path: ${sf.path ?? "memory"})');
    }

    GenerationManager.instance.startPyqAnalysis(
      _currentBook.id,
      _selectedFiles,
      _currentBook,
      customInstructions: customInstructions.isNotEmpty
          ? customInstructions
          : null,
      moduleIndex: moduleIdx,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Processing Exam in Background! You can continue browsing.',
        ),
      ),
    );

    setState(() {
      _selectedFiles.clear();
      _customPromptCtrl.clear();
    });
  }

  Future<void> _updateBookAndSave(Book updatedBook) async {
    setState(() {
      _currentBook = updatedBook;
    });
    await DatabaseService().saveGeneratedBook(updatedBook);
    widget.onBookUpdated();
  }

  Future<void> _saveAllQuestions() async {
    final freshest = (await DatabaseService().getBookFromCache(_currentBook.id)) ?? _currentBook;
    await DatabaseService().saveGeneratedBook(freshest);
    widget.onBookUpdated();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All questions saved successfully! Available in Practice tab.'),
          backgroundColor: AppTheme.duoGreen,
        ),
      );
    }
  }

  void _addQuestion(Section section) async {
    final titleCtrl = TextEditingController(
      text: 'Question ${section.pyqQuestions.length + 1}',
    );
    final contentCtrl = TextEditingController();
    final answerCtrl = TextEditingController();
    String selectedType = 'one_word';

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: context.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: context.colors.outline),
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.duoGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  LucideIcons.plusCircle,
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
                      'Add Question',
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      section.title,
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'QUESTION TYPE',
                    style: TextStyle(
                      color: context.colors.textFaint,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setDialogState(() => selectedType = 'one_word'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: selectedType == 'one_word'
                                  ? AppTheme.duoBlue.withValues(alpha: 0.2)
                                  : context.colors.surfaceAlt,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedType == 'one_word'
                                    ? AppTheme.duoBlue
                                    : context.colors.outline,
                                width: selectedType == 'one_word' ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.fileText,
                                  size: 16,
                                  color: selectedType == 'one_word'
                                      ? AppTheme.duoBlue
                                      : context.colors.textFaint,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'One Word / Short',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: selectedType == 'one_word'
                                        ? AppTheme.duoBlue
                                        : context.colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setDialogState(() => selectedType = 'proof'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: selectedType == 'proof'
                                  ? AppTheme.duoViolet.withValues(alpha: 0.2)
                                  : context.colors.surfaceAlt,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedType == 'proof'
                                    ? AppTheme.duoViolet
                                    : context.colors.outline,
                                width: selectedType == 'proof' ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.binary,
                                  size: 16,
                                  color: selectedType == 'proof'
                                      ? AppTheme.duoViolet
                                      : context.colors.textFaint,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Proof / Long Q',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: selectedType == 'proof'
                                        ? AppTheme.duoViolet
                                        : context.colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'QUESTION TITLE',
                    style: TextStyle(
                      color: context.colors.textFaint,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: titleCtrl,
                    style: TextStyle(color: context.colors.textPrimary, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'e.g. Question 1',
                      hintStyle: TextStyle(color: context.colors.textFaint),
                      filled: true,
                      fillColor: context.colors.surfaceAlt,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: context.colors.outline),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: context.colors.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppTheme.duoBlue, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'QUESTION STATEMENT / CONTENT',
                    style: TextStyle(
                      color: context.colors.textFaint,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: contentCtrl,
                    maxLines: 4,
                    minLines: 3,
                    style: TextStyle(color: context.colors.textPrimary, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Enter question text or math equation (e.g. Prove that \$E = mc^2\$)...',
                      hintStyle: TextStyle(color: context.colors.textFaint),
                      filled: true,
                      fillColor: context.colors.surfaceAlt,
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: context.colors.outline),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: context.colors.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppTheme.duoBlue, width: 2),
                      ),
                    ),
                  ),
                  if (selectedType == 'one_word') ...[
                    const SizedBox(height: 16),
                    Text(
                      'REFERENCE ANSWER',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: answerCtrl,
                      style: TextStyle(color: context.colors.textPrimary, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Enter expected answer...',
                        hintStyle: TextStyle(color: context.colors.textFaint),
                        filled: true,
                        fillColor: context.colors.surfaceAlt,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: context.colors.outline),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: context.colors.outline),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.duoGreen, width: 2),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: context.colors.textFaint,
                side: BorderSide(color: context.colors.outline),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.duoGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              icon: const Icon(LucideIcons.check, size: 16),
              label: const Text('Save Question', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                if (contentCtrl.text.trim().isEmpty) return;
                Navigator.pop(ctx, true);
              },
            ),
          ],
        ),
      ),
    );

    if (result == true) {
      final title = titleCtrl.text.trim().isNotEmpty
          ? titleCtrl.text.trim()
          : 'Question ${section.pyqQuestions.length + 1}';
      final content = contentCtrl.text.trim();
      final answer = answerCtrl.text.trim();

      final newSlide = Slide(
        id: 'pyq_${DateTime.now().millisecondsSinceEpoch}',
        type: selectedType,
        title: title,
        content: content,
        blankAnswer: selectedType == 'one_word' ? (answer.isNotEmpty ? answer : null) : null,
        source: 'generated',
      );

      final updatedQuestions = List<Slide>.from(section.pyqQuestions)..add(newSlide);
      final updatedModules = _currentBook.modules.map((m) {
        final updatedSecs = m.sections.map((s) {
          if (s.id == section.id) {
            return s.copyWith(pyqQuestions: updatedQuestions);
          }
          return s;
        }).toList();
        return m.copyWith(sections: updatedSecs);
      }).toList();

      final newBook = _currentBook.copyWith(modules: updatedModules);
      await _updateBookAndSave(newBook);
    }

    titleCtrl.dispose();
    contentCtrl.dispose();
    answerCtrl.dispose();
  }

  void _editQuestion(Section section, int slideIndex, Slide slide) async {
    final titleCtrl = TextEditingController(text: slide.title);
    final contentCtrl = TextEditingController(text: slide.content);
    final answerCtrl = TextEditingController(text: slide.blankAnswer ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Verify & Edit Question',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Question Title',
                style: TextStyle(
                  color: context.colors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              TextField(
                controller: titleCtrl,
                style: TextStyle(color: context.colors.textPrimary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context.colors.surfaceAlt,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Question Content',
                style: TextStyle(
                  color: context.colors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              TextField(
                controller: contentCtrl,
                maxLines: null,
                style: TextStyle(color: context.colors.textPrimary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: context.colors.surfaceAlt,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              if (slide.type == 'one_word') ...[
                Text(
                  'Correct Answer',
                  style: TextStyle(
                    color: context.colors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: answerCtrl,
                  style: TextStyle(color: context.colors.textPrimary),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.colors.surfaceAlt,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Save',
              style: TextStyle(
                color: AppTheme.duoBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (result == true) {
      final updatedSlide = slide.copyWith(
        title: titleCtrl.text.trim(),
        content: contentCtrl.text.trim(),
        blankAnswer: slide.type == 'one_word' ? answerCtrl.text.trim() : null,
      );

      final updatedQuestions = List<Slide>.from(section.pyqQuestions);
      updatedQuestions[slideIndex] = updatedSlide;

      final updatedModules = widget.book.modules.map((m) {
        final updatedSecs = m.sections.map((s) {
          if (s.id == section.id) {
            return s.copyWith(pyqQuestions: updatedQuestions);
          }
          return s;
        }).toList();
        return m.copyWith(sections: updatedSecs);
      }).toList();

      final newBook = widget.book.copyWith(modules: updatedModules);
      await DatabaseService().saveGeneratedBook(newBook);
      widget.onBookUpdated();
      if (mounted) {
        setState(() {});
      }
    }

    titleCtrl.dispose();
    contentCtrl.dispose();
    answerCtrl.dispose();
  }

  void _deleteQuestion(Section section, int slideIndex) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Delete Question?',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will permanently delete this question from this section.',
          style: TextStyle(color: context.colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Delete',
              style: TextStyle(
                color: AppTheme.duoRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final updatedQuestions = List<Slide>.from(section.pyqQuestions)
        ..removeAt(slideIndex);
      final updatedModules = widget.book.modules.map((m) {
        final updatedSecs = m.sections.map((s) {
          if (s.id == section.id) {
            return s.copyWith(pyqQuestions: updatedQuestions);
          }
          return s;
        }).toList();
        return m.copyWith(sections: updatedSecs);
      }).toList();

      final newBook = widget.book.copyWith(modules: updatedModules);
      await DatabaseService().saveGeneratedBook(newBook);
      widget.onBookUpdated();
      if (mounted) {
        setState(() {});
      }
    }
  }

  /// Tag distinguishing AI-generated questions from those extracted out of an
  /// uploaded paper. Legacy questions (no source) are treated as extracted,
  /// since historically the PYQ pool was extraction-only.
  Widget _buildSourceTag(String? source) {
    final isGenerated = source == 'generated';
    final color = isGenerated ? AppTheme.duoOrange : AppTheme.duoGreen;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isGenerated ? 'GENERATED' : 'EXTRACTED',
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  bool _alertShownForTaskId = false;

  void _checkAndShowNoQuestionsAlert(QpGenTask? task) {
    if (task != null && task.isError && !_alertShownForTaskId) {
      _alertShownForTaskId = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: context.colors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: AppTheme.duoRed.withValues(alpha: 0.5)),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.duoRed.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    LucideIcons.alertCircle,
                    color: AppTheme.duoRed,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'No Questions Found',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              task.status.isNotEmpty
                  ? task.status
                  : 'No exam questions were found in the uploaded document. Please ensure the file contains legible questions.',
              style: TextStyle(
                color: context.colors.textSecondary,
                fontSize: 14,
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.duoRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                  GenerationManager.instance.clearPyqError(_currentBook.id);
                },
                child: const Text('OK', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      });
    } else if (task == null || !task.isError) {
      _alertShownForTaskId = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        GenerationManager.instance,
        _moduleNotifier,
      ]),
      builder: (context, _) {
        final pyqTask =
            GenerationManager.instance.activePyqTasks[_currentBook.id];
        _checkAndShowNoQuestionsAlert(pyqTask);

        final currentModule = _currentBook.modules.isEmpty
            ? null
            : _currentBook.modules[_moduleIdx];

        // Only show questions extracted for the currently open module.
        final List<Section> sectionsWithPyqs = [];
        if (currentModule != null) {
          for (final s in currentModule.sections) {
            if (s.pyqQuestions.isNotEmpty) {
              sectionsWithPyqs.add(s);
            }
          }
        }

        return Scaffold(
          body: ResponsiveCenter(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                if (pyqTask != null)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      padding: const EdgeInsets.all(18),
                      decoration: AppTheme.glassOf(context).copyWith(
                        border: Border.all(
                          color: pyqTask.isError
                              ? AppTheme.duoRed
                              : AppTheme.duoBlue,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              if (pyqTask.isError)
                                const Icon(
                                  LucideIcons.alertTriangle,
                                  color: AppTheme.duoRed,
                                  size: 24,
                                )
                              else
                                const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: AppTheme.duoBlue,
                                    strokeWidth: 3,
                                  ),
                                ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  pyqTask.status,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: pyqTask.isError
                                        ? AppTheme.duoRed
                                        : context.colors.textPrimary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (!pyqTask.isError && pyqTask.progress != null) ...[
                                const SizedBox(width: 8),
                                Text(
                                  '${((pyqTask.progress ?? 0) * 100).toInt()}%',
                                  style: const TextStyle(
                                    color: AppTheme.duoBlue,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                              if (pyqTask.isError)
                                IconButton(
                                  icon: Icon(
                                    LucideIcons.x,
                                    color: context.colors.textFaint,
                                  ),
                                  onPressed: () => GenerationManager.instance
                                      .clearPyqError(widget.book.id),
                                ),
                            ],
                          ),
                          if (!pyqTask.isError) ...[
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: pyqTask.progress,
                                minHeight: 8,
                                backgroundColor: AppTheme.duoBlue.withValues(alpha: 0.2),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppTheme.duoBlue,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Upload Previous Year Question Papers',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: context.colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        if (currentModule != null)
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.duoBlue.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppTheme.duoBlue.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  LucideIcons.package,
                                  size: 14,
                                  color: AppTheme.duoBlue,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Extracting into: ${currentModule.title}',
                                    style: const TextStyle(
                                      color: AppTheme.duoBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Text(
                          'Select PDF papers or image snapshots. The AI extracts questions for the current module (chosen on the Path tab), splits them across its sections with generated lessons, and solves them interactively. Questions can then be solved in the Practice Arena.',
                          style: TextStyle(
                            color: context.colors.textFaint,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 24),
                        FileSelectionList(
                          files: _selectedFiles,
                          onAddMore: _pickFiles,
                          onSelectFromStore: _selectFromStore,
                          onRemove: (idx) =>
                              setState(() => _selectedFiles.removeAt(idx)),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Custom Prompt / Generation Instructions',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: context.colors.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: AppTheme.glassOf(context),
                          child: TextField(
                            controller: _customPromptCtrl,
                            maxLines: 4,
                            minLines: 2,
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  "e.g. Focus on multiple choice questions, explain formula derivations.",
                              hintStyle: TextStyle(
                                color: context.colors.textFaint,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        DuoButton(
                          text: 'Analyze & Split Questions',
                          color: _selectedFiles.isNotEmpty && pyqTask == null
                              ? AppTheme.duoBlue
                              : Colors.grey.shade700,
                          shadowColor:
                              _selectedFiles.isNotEmpty && pyqTask == null
                              ? AppTheme.duoBlueDark
                              : Colors.grey.shade800,
                          onPressed: _startAnalysis,
                        ),
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Divider(color: context.colors.outline, thickness: 1),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'VERIFY',
                          style: TextStyle(
                            color: context.colors.textFaint,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        if (sectionsWithPyqs.isNotEmpty)
                          ElevatedButton.icon(
                            icon: const Icon(LucideIcons.checkCheck, size: 16),
                            label: const Text('Save Questions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.duoGreen,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: _saveAllQuestions,
                          ),
                      ],
                    ),
                  ),
                ),

                if (sectionsWithPyqs.isEmpty)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(24),
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceAlt,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            LucideIcons.fileSearch,
                            size: 40,
                            color: context.colors.textFaint,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No extracted questions yet',
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Upload a PDF or image paper above to get started.',
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else ...[
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final section = sectionsWithPyqs[index];
                        final isExpanded = _selectedSectionId == section.id;
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: context.colors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: context.colors.outline),
                          ),
                          child: Column(
                            children: [
                              Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                                clipBehavior: Clip.antiAlias,
                                child: ListTile(
                                  title: Text(
                                    section.title,
                                    style: TextStyle(
                                      color: context.colors.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${section.pyqQuestions.length} questions extracted',
                                    style: TextStyle(
                                      color: context.colors.textFaint,
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton.icon(
                                        icon: const Icon(
                                          LucideIcons.plus,
                                          size: 14,
                                          color: AppTheme.duoBlue,
                                        ),
                                        label: const Text(
                                          'Add Q',
                                          style: TextStyle(
                                            color: AppTheme.duoBlue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () => _addQuestion(section),
                                      ),
                                      Icon(
                                        isExpanded
                                            ? LucideIcons.chevronUp
                                            : LucideIcons.chevronDown,
                                        color: context.colors.textFaint,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedSectionId = isExpanded
                                          ? null
                                          : section.id;
                                    });
                                  },
                                ),
                              ),
                              if (isExpanded) ...[
                                Divider(
                                  color: context.colors.outline,
                                  height: 1,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: section.pyqQuestions.length,
                                  itemBuilder: (context, qIdx) {
                                    final slide = section.pyqQuestions[qIdx];
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: context.colors.outline,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: slide.type == 'one_word'
                                                      ? AppTheme.duoBlue.withValues(alpha: 0.15)
                                                      : AppTheme.duoViolet.withValues(alpha: 0.15),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  slide.type == 'one_word' ? 'One Word' : 'Proof',
                                                  style: TextStyle(
                                                    color: slide.type == 'one_word'
                                                        ? AppTheme.duoBlue
                                                        : AppTheme.duoViolet,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  slide.title,
                                                  style: TextStyle(
                                                    color: context.colors.textPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  LucideIcons.trash2,
                                                  size: 16,
                                                  color: context.colors.textFaint,
                                                ),
                                                onPressed: () async {
                                                  final updatedQuestions = List<Slide>.from(section.pyqQuestions)..removeAt(qIdx);
                                                  final updatedModules = _currentBook.modules.map((m) {
                                                    final updatedSecs = m.sections.map((s) {
                                                      if (s.id == section.id) {
                                                        return s.copyWith(pyqQuestions: updatedQuestions);
                                                      }
                                                      return s;
                                                    }).toList();
                                                    return m.copyWith(sections: updatedSecs);
                                                  }).toList();

                                                  final newBook = _currentBook.copyWith(modules: updatedModules);
                                                  await _updateBookAndSave(newBook);
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            slide.content,
                                            style: TextStyle(
                                              color: context.colors.textSecondary,
                                              fontSize: 12,
                                            ),
                                          ),
                                          if (slide.blankAnswer != null && slide.blankAnswer!.isNotEmpty) ...[
                                            const SizedBox(height: 6),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Reference Answer: ',
                                                    style: TextStyle(
                                                      color: context.colors.textFaint,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: slide.blankAnswer,
                                                    style: const TextStyle(
                                                      color: AppTheme.duoGreen,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: OutlinedButton.icon(
                                    icon: const Icon(LucideIcons.plus, size: 16),
                                    label: const Text('Add Question to Section'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppTheme.duoBlue,
                                      side: const BorderSide(color: AppTheme.duoBlue),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () => _addQuestion(section),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      }, childCount: sectionsWithPyqs.length),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(LucideIcons.save, size: 18),
                          label: const Text(
                            'Save All Questions to Course',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.duoGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 2,
                          ),
                          onPressed: _saveAllQuestions,
                        ),
                      ),
                    ),
                  ),
                ],
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),
          ),
        );
      },
    );
  }
}