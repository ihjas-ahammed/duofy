import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../models/pyq_models.dart';
import '../services/pyq_exam_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/math_markdown.dart';

class PyqExamScreen extends StatefulWidget {
  final Book book;
  final List<PyqItem> questions;
  final List<String> selectedModuleIds;
  final double maxExamScore;

  const PyqExamScreen({
    super.key,
    required this.book,
    required this.questions,
    required this.selectedModuleIds,
    required this.maxExamScore,
  });

  @override
  State<PyqExamScreen> createState() => _PyqExamScreenState();
}

class _PyqExamScreenState extends State<PyqExamScreen> {
  late final Map<String, TextEditingController> _textControllers;
  late final Map<String, List<File>> _attachedImages;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _textControllers = {
      for (final q in widget.questions) q.id: TextEditingController(),
    };
    _attachedImages = {
      for (final q in widget.questions) q.id: [],
    };
  }

  @override
  void dispose() {
    for (final ctrl in _textControllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImageForQuestion(String questionId) async {
    try {
      final res = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg'],
        allowMultiple: true,
      );
      if (res != null && mounted) {
        setState(() {
          final newFiles = res.paths
              .where((p) => p != null)
              .map((p) => File(p!))
              .toList();
          _attachedImages[questionId]!.addAll(newFiles);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick images: $e')),
      );
    }
  }

  void _removeImage(String questionId, int index) {
    setState(() {
      _attachedImages[questionId]?.removeAt(index);
    });
  }

  Future<void> _submitExam() async {
    setState(() => _isSubmitting = true);

    final List<PyqQuestionAnswer> answers = [];
    for (final q in widget.questions) {
      final text = _textControllers[q.id]?.text.trim() ?? '';
      final imgs = _attachedImages[q.id]?.map((f) => f.path).toList() ?? [];
      answers.add(PyqQuestionAnswer(
        questionId: q.id,
        questionTitle: q.title,
        content: q.content,
        marks: q.marks,
        textAnswer: text,
        imagePaths: imgs,
      ));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('⚡ Paper submitted! AI background grading has started.'),
        backgroundColor: AppTheme.duoBlue,
      ),
    );

    PyqExamService.instance.evaluateExamPaper(
      book: widget.book,
      moduleIds: widget.selectedModuleIds,
      studentAnswers: answers,
    );

    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Group questions by mark sections
    final Map<int, List<PyqItem>> grouped = {};
    for (final q in widget.questions) {
      grouped.putIfAbsent(q.marks, () => []).add(q);
    }
    final sortedMarkKeys = grouped.keys.toList()..sort();

    final totalMarks = widget.questions.fold<int>(0, (sum, q) => sum + q.marks);

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'PYQ Exam Practice',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
            Text(
              '${widget.questions.length} Questions • Total: $totalMarks Marks (Limit: ${widget.maxExamScore.toInt()})',
              style: TextStyle(fontSize: 11, color: context.colors.textFaint),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...sortedMarkKeys.map((marks) {
                final qList = grouped[marks]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.duoBlue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.duoBlue.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        '$marks MARKS QUESTIONS (${qList.length})',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.duoBlue,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    ...qList.map((q) => _buildQuestionCard(q)),
                  ],
                );
              }),
              const SizedBox(height: 24),
              DuoButton(
                text: _isSubmitting ? 'SUBMITTING...' : 'SUBMIT EXAM',
                color: AppTheme.duoGreen,
                shadowColor: AppTheme.duoGreenDark,
                onPressed: _isSubmitting ? () {} : _submitExam,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(PyqItem q) {
    final images = _attachedImages[q.id] ?? [];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.duoViolet.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${q.marks} Marks',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.duoViolet,
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
          const SizedBox(height: 12),
          MathMarkdown(
            data: q.content.isNotEmpty ? q.content : q.title,
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: context.colors.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _textControllers[q.id],
            maxLines: 4,
            style: TextStyle(color: context.colors.textPrimary, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Write your answer here...',
              hintStyle: TextStyle(color: context.colors.textFaint, fontSize: 13),
              filled: true,
              fillColor: context.colors.surfaceAlt,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: context.colors.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.duoBlue),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => _pickImageForQuestion(q.id),
                icon: const Icon(LucideIcons.image, size: 16),
                label: const Text('Add Image / Diagram', style: TextStyle(fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.duoBlue,
                  side: BorderSide(color: AppTheme.duoBlue.withValues(alpha: 0.5)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          if (images.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: images.asMap().entries.map((entry) {
                final idx = entry.key;
                final file = entry.value;
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        file,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: GestureDetector(
                        onTap: () => _removeImage(q.id, idx),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(3),
                          child: const Icon(LucideIcons.x, size: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
