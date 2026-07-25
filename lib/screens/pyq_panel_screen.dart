import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import '../models/app_models.dart';
import '../models/pyq_models.dart';
import '../services/ai_service.dart';
import '../services/b2_service.dart';
import '../services/pyq_exam_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/math_markdown.dart';
import 'document_store_screen.dart';
import 'source_pdf_upload_screen.dart';
import 'pyq_exam_screen.dart';
import 'pyq_score_history_screen.dart';

class PyqPanelScreen extends StatefulWidget {
  final Book book;

  const PyqPanelScreen({
    super.key,
    required this.book,
  });

  @override
  State<PyqPanelScreen> createState() => _PyqPanelScreenState();
}

class _PyqPanelScreenState extends State<PyqPanelScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<PyqItem> _savedPyqs = [];
  bool _isLoadingBank = true;

  // Extract Tab state
  final List<PlatformFile> _selectedFiles = [];
  final TextEditingController _maxQuestionsCtrl = TextEditingController(text: '10');
  bool _isAnalyzing = false;
  double _analysisProgress = 0.0;
  String _analysisStatus = '';

  List<PyqItem> _extractedResults = [];
  List<PyqItem> _generatedResults = [];

  PyqAnalysisJob? _activeJob;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPyqBank();
    _attachBackgroundJobListener();
  }

  @override
  void dispose() {
    _activeJob?.removeListener(_onJobUpdated);
    _tabController.dispose();
    _maxQuestionsCtrl.dispose();
    super.dispose();
  }

  void _attachBackgroundJobListener() {
    _activeJob = PyqExamService.instance.getAnalysisJob(widget.book.id);
    if (_activeJob != null) {
      _activeJob!.addListener(_onJobUpdated);
      _syncStateWithJob();
    }
  }

  void _onJobUpdated() {
    if (!mounted) return;
    setState(() {
      _syncStateWithJob();
    });
    if (_activeJob != null && _activeJob!.isCompleted) {
      _loadPyqBank();
    }
  }

  void _syncStateWithJob() {
    if (_activeJob == null) return;
    _isAnalyzing = _activeJob!.isRunning;
    _analysisProgress = _activeJob!.progress;
    _analysisStatus = _activeJob!.status;
    if (_activeJob!.result != null) {
      _extractedResults = _activeJob!.result!.extractedQuestions;
      _generatedResults = _activeJob!.result!.generatedQuestions;
    }
  }

  Future<void> _loadPyqBank() async {
    final list = await PyqExamService.instance.getPyqBank(widget.book);
    if (mounted) {
      setState(() {
        _savedPyqs = list;
        _isLoadingBank = false;
      });
    }
  }

  // --- TAB 1 ACTIONS ---

  void _openScoreHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PyqScoreHistoryScreen(book: widget.book),
      ),
    );
  }

  void _openExamSetup() {
    if (_savedPyqs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No questions in PYQ Bank yet! Extract and save questions first.')),
      );
      return;
    }

    final maxScoreCtrl = TextEditingController(text: '50');
    final selectedModuleIds = <String>{
      for (final m in widget.book.modules) m.id,
    };

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) {
          return AlertDialog(
            backgroundColor: context.colors.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                const Icon(LucideIcons.playCircle, color: AppTheme.duoGreen, size: 24),
                const SizedBox(width: 8),
                Text(
                  'PYQ Exam Practice Setup',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Max Exam Score Limit:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: maxScoreCtrl,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: context.colors.textPrimary, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'e.g. 50',
                      filled: true,
                      fillColor: context.colors.surfaceAlt,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select Target Modules:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...widget.book.modules.map((m) {
                    final isChecked = selectedModuleIds.contains(m.id);
                    return CheckboxListTile(
                      dense: true,
                      activeColor: AppTheme.duoGreen,
                      title: Text(
                        m.title,
                        style: TextStyle(fontSize: 13, color: context.colors.textPrimary),
                      ),
                      value: isChecked,
                      onChanged: (val) {
                        setDialogState(() {
                          if (val == true) {
                            selectedModuleIds.add(m.id);
                          } else {
                            selectedModuleIds.remove(m.id);
                          }
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Cancel', style: TextStyle(color: context.colors.textFaint)),
              ),
              DuoButton(
                text: 'START EXAM',
                color: AppTheme.duoGreen,
                shadowColor: AppTheme.duoGreenDark,
                onPressed: () {
                  final maxScore = double.tryParse(maxScoreCtrl.text.trim()) ?? 50.0;
                  if (selectedModuleIds.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select at least one module.')),
                    );
                    return;
                  }
                  Navigator.of(ctx).pop();
                  _startExam(maxScore, selectedModuleIds.toList());
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _startExam(double maxScore, List<String> moduleIds) {
    // Filter saved PYQs by module and accumulate up to maxScore
    final available = _savedPyqs.where((q) {
      if (q.moduleId == null || q.moduleId!.isEmpty) return true;
      return moduleIds.contains(q.moduleId);
    }).toList();

    // Group by mark section
    final Map<int, List<PyqItem>> markGroups = {};
    for (final q in available) {
      markGroups.putIfAbsent(q.marks, () => []).add(q);
    }

    final examQuestions = <PyqItem>[];
    double accumulated = 0;

    final markKeys = markGroups.keys.toList()..sort();
    for (final marks in markKeys) {
      for (final q in markGroups[marks]!) {
        if (accumulated + q.marks <= maxScore) {
          examQuestions.add(q);
          accumulated += q.marks;
        }
      }
    }

    if (examQuestions.isEmpty && available.isNotEmpty) {
      examQuestions.add(available.first);
    }

    if (examQuestions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No questions found matching selected modules.')),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PyqExamScreen(
          book: widget.book,
          questions: examQuestions,
          selectedModuleIds: moduleIds,
          maxExamScore: maxScore,
        ),
      ),
    );
  }

  // --- TAB 2 ACTIONS ---

  Future<void> _pickLocalFiles() async {
    try {
      final res = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
        allowMultiple: true,
      );
      if (res != null && mounted) {
        setState(() {
          _selectedFiles.addAll(res.files);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick files: $e')),
      );
    }
  }

  Future<void> _pickFromDocumentStore() async {
    final configured = await B2Service.instance.isConfigured();
    if (!configured) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: context.colors.surface,
          title: Text('Cloud Storage Required', style: TextStyle(color: context.colors.textPrimary)),
          content: const Text('Backblaze B2 is not configured. Please setup cloud storage in the Document Store tab first.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK', style: TextStyle(color: AppTheme.duoGreen)),
            ),
          ],
        ),
      );
      return;
    }

    final B2Object? selected = await showDialog<B2Object>(
      context: context,
      builder: (ctx) => DocumentStorePickerDialog(forPyq: true),
    );

    if (selected != null && mounted) {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${appDir.path}/b2_cache');
      final file = File('${cacheDir.path}/${selected.key}');

      if (file.existsSync()) {
        final bytes = file.readAsBytesSync();
        final name = file.path.split('/').last.split('\\').last;
        setState(() {
          _selectedFiles.add(PlatformFile(path: file.path, name: name, size: bytes.length, bytes: bytes));
        });
        return;
      }

      final File? downloadedFile = await showDialog<File>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => DownloadProgressDialog(b2Obj: selected),
      );

      if (downloadedFile != null && downloadedFile.existsSync() && mounted) {
        final bytes = downloadedFile.readAsBytesSync();
        final name = downloadedFile.path.split('/').last.split('\\').last;
        setState(() {
          _selectedFiles.add(PlatformFile(path: downloadedFile.path, name: name, size: bytes.length, bytes: bytes));
        });
      }
    }
  }

  Future<void> _startAnalysis() async {
    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one paper file or document.')),
      );
      return;
    }

    final maxQ = int.tryParse(_maxQuestionsCtrl.text.trim()) ?? 10;
    final filesToAnalyze = _selectedFiles
        .where((pf) => pf.path != null)
        .map((pf) => File(pf.path!))
        .toList();

    _activeJob?.removeListener(_onJobUpdated);

    PyqExamService.instance.startBackgroundAnalysis(
      book: widget.book,
      files: filesToAnalyze,
      maxQuestions: maxQ,
    );

    _attachBackgroundJobListener();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('⚡ QP Analysis started in background! You can navigate away anytime.'),
        backgroundColor: AppTheme.duoBlue,
      ),
    );
  }

  Future<void> _saveAnalyzedQuestions() async {
    final allToSave = [..._extractedResults, ..._generatedResults];
    if (allToSave.isEmpty) return;

    await PyqExamService.instance.addPyqItems(widget.book.id, widget.book, allToSave);
    await _loadPyqBank();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved ${allToSave.length} questions to PYQ Bank!'),
          backgroundColor: AppTheme.duoGreen,
        ),
      );
      _tabController.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: Text(
          '${widget.book.title} - PYQ Panel',
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.duoBlue,
          labelColor: AppTheme.duoBlue,
          unselectedLabelColor: context.colors.textFaint,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          tabs: const [
            Tab(text: 'Extracted Questions'),
            Tab(text: 'Extract Questions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExtractedQuestionsTab(),
          _buildExtractQuestionsTab(),
        ],
      ),
    );
  }

  // --- TAB 1 UI ---

  Widget _buildExtractedQuestionsTab() {
    if (_isLoadingBank) {
      return const Center(child: CircularProgressIndicator(color: AppTheme.duoBlue));
    }

    // Group saved questions by unique marks
    final Map<int, List<PyqItem>> markGroups = {};
    for (final item in _savedPyqs) {
      markGroups.putIfAbsent(item.marks, () => []).add(item);
    }
    final sortedMarkKeys = markGroups.keys.toList()..sort();

    return Column(
      children: [
        // Top Action Bar with Play & Score History buttons
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border(bottom: BorderSide(color: context.colors.outline)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${_savedPyqs.length} Total Saved Questions',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textSecondary,
                  ),
                ),
              ),
              IconButton(
                onPressed: _openScoreHistory,
                icon: const Icon(LucideIcons.history, color: AppTheme.duoViolet),
                tooltip: 'Score History',
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: _openExamSetup,
                icon: const Icon(LucideIcons.playCircle, color: AppTheme.duoGreen, size: 28),
                tooltip: 'Start PYQ Exam Practice',
              ),
            ],
          ),
        ),
        Expanded(
          child: _savedPyqs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.fileQuestion, size: 48, color: context.colors.textFaint),
                      const SizedBox(height: 12),
                      Text(
                        'No questions in PYQ Bank',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Switch to the "Extract Questions" tab to add exam papers!',
                        style: TextStyle(fontSize: 12, color: context.colors.textFaint),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sortedMarkKeys.length,
                  itemBuilder: (ctx, i) {
                    final marks = sortedMarkKeys[i];
                    final questions = markGroups[marks]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.duoBlue.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.duoBlue.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            '$marks MARKS QUESTIONS (${questions.length})',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.duoBlue,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        ...questions.map((q) => _buildSavedQuestionTile(q)),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSavedQuestionTile(PyqItem q) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: q.isGenerated
                      ? AppTheme.duoOrange.withValues(alpha: 0.15)
                      : AppTheme.duoGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  q.isGenerated ? 'Synthetic PYQ' : 'Extracted Question',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: q.isGenerated ? AppTheme.duoOrange : AppTheme.duoGreen,
                  ),
                ),
              ),
              if (q.moduleTitle != null && q.moduleTitle!.isNotEmpty) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    q.moduleTitle!,
                    style: TextStyle(fontSize: 11, color: context.colors.textFaint),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          MathMarkdown(
            data: q.content.isNotEmpty ? q.content : q.title,
            textStyle: TextStyle(
              fontSize: 14,
              color: context.colors.textPrimary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 2 UI ---

  Widget _buildExtractQuestionsTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Select Sources Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colors.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Question Paper Sources',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Upload PDF/Images or select from Document Store:',
                  style: TextStyle(fontSize: 12, color: context.colors.textFaint),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickLocalFiles,
                        icon: const Icon(LucideIcons.upload, size: 16),
                        label: const Text('Pick PDF/Image'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.duoBlue,
                          side: BorderSide(color: AppTheme.duoBlue.withValues(alpha: 0.5)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickFromDocumentStore,
                        icon: const Icon(LucideIcons.folder, size: 16),
                        label: const Text('Document Store'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.duoViolet,
                          side: BorderSide(color: AppTheme.duoViolet.withValues(alpha: 0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_selectedFiles.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  ..._selectedFiles.asMap().entries.map((e) {
                    final idx = e.key;
                    final f = e.value;
                    return ListTile(
                      dense: true,
                      leading: const Icon(LucideIcons.fileText, size: 18),
                      title: Text(f.name, style: const TextStyle(fontSize: 13)),
                      trailing: IconButton(
                        icon: const Icon(LucideIcons.x, size: 16),
                        onPressed: () {
                          setState(() {
                            _selectedFiles.removeAt(idx);
                          });
                        },
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Settings & Max Questions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colors.outline),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Target Max Questions',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      Text(
                        'Synthetic questions are generated if paper has fewer.',
                        style: TextStyle(fontSize: 11, color: context.colors.textFaint),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _maxQuestionsCtrl,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: context.colors.textPrimary, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: context.colors.surfaceAlt,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Start Analysis Button
          DuoButton(
            text: _isAnalyzing ? 'ANALYZING PAPER...' : 'START ANALYSIS',
            color: AppTheme.duoBlue,
            shadowColor: AppTheme.duoBlueDark,
            onPressed: _isAnalyzing ? () {} : _startAnalysis,
          ),
          if (_isAnalyzing) ...[
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: _analysisProgress,
              color: AppTheme.duoBlue,
              backgroundColor: context.colors.surfaceAlt,
            ),
            const SizedBox(height: 6),
            Text(
              _analysisStatus,
              style: TextStyle(fontSize: 12, color: context.colors.textFaint),
              textAlign: TextAlign.center,
            ),
          ],
          // Results Sections (Extracted Questions List & Generated Questions List)
          if (_extractedResults.isNotEmpty || _generatedResults.isNotEmpty) ...[
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Analysis Results',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: context.colors.textPrimary,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _saveAnalyzedQuestions,
                  icon: const Icon(LucideIcons.save, size: 16),
                  label: const Text('Save to PYQ Bank'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.duoGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_extractedResults.isNotEmpty) ...[
              Text(
                'Extracted Questions (${_extractedResults.length})',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.duoGreen,
                ),
              ),
              const SizedBox(height: 6),
              ..._extractedResults.map((q) => _buildSavedQuestionTile(q)),
            ],
            if (_generatedResults.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Generated Questions (${_generatedResults.length})',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.duoOrange,
                ),
              ),
              const SizedBox(height: 6),
              ..._generatedResults.map((q) => _buildSavedQuestionTile(q)),
            ],
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
