import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/ai_service.dart';
import '../services/database_service.dart';
import '../screens/lesson_screen.dart';
import 'math_markdown.dart';

class QuickReviewSheet extends StatefulWidget {
  final Book book;
  final int modIdx;
  final Module module;
  final Function(Book) onBookUpdated;

  const QuickReviewSheet({
    super.key,
    required this.book,
    required this.modIdx,
    required this.module,
    required this.onBookUpdated,
  });

  @override
  State<QuickReviewSheet> createState() => _QuickReviewSheetState();
}

class _QuickReviewSheetState extends State<QuickReviewSheet> {
  bool _isGenerating = false;
  List<QuickReviewItem>? _reviewItems;

  @override
  void initState() {
    super.initState();
    _reviewItems = widget.module.quickReview;
  }

  Future<void> _generateReview() async {
    setState(() {
      _isGenerating = true;
    });

    try {
      final items = await AiService().generateQuickReviewForModule(
        widget.module,
      );

      if (items.isNotEmpty && mounted) {
        final modules = List<Module>.from(widget.book.modules);
        final updatedModule = widget.module.copyWith(quickReview: items);
        modules[widget.modIdx] = updatedModule;
        final updatedBook = widget.book.copyWith(modules: modules);

        await DatabaseService().saveGeneratedBook(updatedBook);
        widget.onBookUpdated(updatedBook);

        setState(() {
          _reviewItems = items;
        });
      }
    } catch (e) {
      debugPrint('Error generating quick review: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  MatchingLessonResult? _findMatchingLessonResult(String title) {
    if (title.isEmpty) return null;
    final cleanTitle = title.toLowerCase().trim();
    
    // Exact or substring match
    for (int secIdx = 0; secIdx < widget.module.sections.length; secIdx++) {
      final sec = widget.module.sections[secIdx];
      for (int unitIdx = 0; unitIdx < sec.units.length; unitIdx++) {
        final unit = sec.units[unitIdx];
        for (int lessonIdx = 0; lessonIdx < unit.lessons.length; lessonIdx++) {
          final lesson = unit.lessons[lessonIdx];
          final lessonTitle = lesson.title.toLowerCase().trim();
          if (lessonTitle == cleanTitle || 
              lessonTitle.contains(cleanTitle) || 
              cleanTitle.contains(lessonTitle)) {
            return MatchingLessonResult(
              lesson: lesson,
              secIdx: secIdx,
              unitIdx: unitIdx,
              lessonIdx: lessonIdx,
            );
          }
        }
      }
    }

    // Word overlap match
    final titleWords = cleanTitle.split(RegExp(r'\s+')).where((w) => w.length > 3).toSet();
    if (titleWords.isNotEmpty) {
      for (int secIdx = 0; secIdx < widget.module.sections.length; secIdx++) {
        final sec = widget.module.sections[secIdx];
        for (int unitIdx = 0; unitIdx < sec.units.length; unitIdx++) {
          final unit = sec.units[unitIdx];
          for (int lessonIdx = 0; lessonIdx < unit.lessons.length; lessonIdx++) {
            final lesson = unit.lessons[lessonIdx];
            final lessonTitle = lesson.title.toLowerCase().trim();
            final lessonWords = lessonTitle.split(RegExp(r'\s+')).where((w) => w.length > 3).toSet();
            final intersection = titleWords.intersection(lessonWords);
            if (intersection.isNotEmpty) {
              return MatchingLessonResult(
                lesson: lesson,
                secIdx: secIdx,
                unitIdx: unitIdx,
                lessonIdx: lessonIdx,
              );
            }
          }
        }
      }
    }

    return null;
  }

  void _showDetailDialog(QuickReviewItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _StatementDetailSheet(
          item: item,
          moduleTitle: widget.module.title,
          matchingLesson: _findMatchingLessonResult(item.relatedLessonTitle),
          book: widget.book,
          modIdx: widget.modIdx,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withOpacity(0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: Colors.white10),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'MODULE QUICK REVIEW',
                          style: TextStyle(
                            color: AppTheme.duoGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.module.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (_reviewItems != null && _reviewItems!.isNotEmpty && !_isGenerating)
                    IconButton(
                      icon: const Icon(LucideIcons.refreshCw, color: Colors.white70, size: 20),
                      onPressed: _generateReview,
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // Content Area
              Flexible(
                child: _isGenerating
                    ? const _LoadingPanel()
                    : (_reviewItems == null || _reviewItems!.isEmpty)
                        ? _EmptyReviewPanel(onGenerate: _generateReview)
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _reviewItems!.length,
                            padding: const EdgeInsets.only(bottom: 24),
                            itemBuilder: (context, index) {
                              final item = _reviewItems![index];
                              return _ReviewItemCard(
                                item: item,
                                index: index + 1,
                                onTap: () => _showDetailDialog(item),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MatchingLessonResult {
  final Lesson lesson;
  final int secIdx;
  final int unitIdx;
  final int lessonIdx;
  MatchingLessonResult({
    required this.lesson,
    required this.secIdx,
    required this.unitIdx,
    required this.lessonIdx,
  });
}

class _EmptyReviewPanel extends StatelessWidget {
  final VoidCallback onGenerate;
  const _EmptyReviewPanel({required this.onGenerate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.duoBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.sparkles, color: AppTheme.duoBlue, size: 36),
          ),
          const SizedBox(height: 20),
          const Text(
            'No Quick Review Sheet Yet',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Generate a summary of key concepts, equations, and definitions directly from the module\'s textbook sections.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.duoBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: const Icon(LucideIcons.sparkles, size: 18),
              label: const Text('Generate Review Sheet', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: onGenerate,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingPanel extends StatefulWidget {
  const _LoadingPanel();

  @override
  State<_LoadingPanel> createState() => _LoadingPanelState();
}

class _LoadingPanelState extends State<_LoadingPanel> {
  int _statusIdx = 0;
  final List<String> _statuses = [
    'Extracting textbook content...',
    'Analyzing key formulas and laws...',
    'Synthesizing concise review points...',
    'Formatting equations in LaTeX...',
    'Finalizing review sheet...'
  ];

  @override
  void initState() {
    super.initState();
    _changeStatus();
  }

  void _changeStatus() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _statusIdx = (_statusIdx + 1) % _statuses.length;
        });
        _changeStatus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.duoGreen),
              strokeWidth: 4,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _statuses[_statusIdx],
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'This might take up to a minute depending on document size.',
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ReviewItemCard extends StatelessWidget {
  final QuickReviewItem item;
  final int index;
  final VoidCallback onTap;

  const _ReviewItemCard({
    required this.item,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white.withOpacity(0.03),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.white10),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.duoGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$index',
                      style: const TextStyle(
                        color: AppTheme.duoGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MathMarkdown(
                      data: item.statement,
                      textStyle: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                    ),
                  ),
                ],
              ),
              if (item.relatedLessonTitle.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(LucideIcons.bookOpen, color: Colors.white54, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        item.relatedLessonTitle,
                        style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatementDetailSheet extends StatefulWidget {
  final QuickReviewItem item;
  final String moduleTitle;
  final MatchingLessonResult? matchingLesson;
  final Book book;
  final int modIdx;

  const _StatementDetailSheet({
    required this.item,
    required this.moduleTitle,
    this.matchingLesson,
    required this.book,
    required this.modIdx,
  });

  @override
  State<_StatementDetailSheet> createState() => _StatementDetailSheetState();
}

class _StatementDetailSheetState extends State<_StatementDetailSheet> {
  bool _isLoading = true;
  String _explanation = '';

  @override
  void initState() {
    super.initState();
    _loadExplanation();
  }

  Future<void> _loadExplanation() async {
    try {
      final exp = await AiService().explainQuickReviewStatement(
        widget.item.statement,
        'Module: ${widget.moduleTitle} • Topic: ${widget.item.relatedLessonTitle}',
      );
      if (mounted) {
        setState(() {
          _explanation = exp;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _explanation = 'Failed to load explanation.';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _navigateToLesson(BuildContext context) async {
    final result = widget.matchingLesson;
    if (result == null) return;

    // Save history
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_lesson_id_${widget.book.id}', result.lesson.id);
    await prefs.setInt('last_mod_idx_${widget.book.id}', widget.modIdx);
    await prefs.setInt('last_sec_idx_${widget.book.id}', result.secIdx);

    if (context.mounted) {
      // Close detail sheet
      Navigator.pop(context);
      // Close quick review sheet
      Navigator.pop(context);

      // Push lesson screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LessonScreen(
            lesson: result.lesson,
            book: widget.book,
            modIdx: widget.modIdx,
            secIdx: result.secIdx,
            unitIdx: result.unitIdx,
            lessonIdx: result.lessonIdx,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header indicator
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title
              Row(
                children: [
                  const Icon(LucideIcons.sparkles, color: AppTheme.duoGreen, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.item.relatedLessonTitle.isNotEmpty
                          ? widget.item.relatedLessonTitle
                          : 'Concept Explanation',
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Statement box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: MathMarkdown(
                  data: widget.item.statement,
                  textStyle: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                ),
              ),
              const SizedBox(height: 20),

              // Explanation body
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppTheme.duoGreen)),
                            SizedBox(height: 16),
                            Text('AI is writing detailed explanation...', style: TextStyle(color: Colors.white54, fontSize: 13)),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: MathMarkdown(
                          data: _explanation,
                          textStyle: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                        ),
                      ),
              ),
              const SizedBox(height: 16),

              // Actions
              if (widget.matchingLesson != null)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.duoGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: const Icon(LucideIcons.playCircle, size: 18),
                  label: const Text('Study Related Lesson', style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () => _navigateToLesson(context),
                )
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white10,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
