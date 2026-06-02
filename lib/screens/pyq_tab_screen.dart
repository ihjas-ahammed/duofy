import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../services/generation_manager.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/file_selection_list.dart';
import '../widgets/responsive_center.dart';
import '../widgets/math_markdown.dart';

class PyqTabScreen extends StatefulWidget {
  final Book book;
  final VoidCallback onBookUpdated;

  const PyqTabScreen({
    super.key,
    required this.book,
    required this.onBookUpdated,
  });

  @override
  State<PyqTabScreen> createState() => _PyqTabScreenState();
}

class _PyqTabScreenState extends State<PyqTabScreen> {
  final List<PlatformFile> _selectedFiles = [];
  String? _selectedSectionId;
  final TextEditingController _customPromptCtrl = TextEditingController();

  @override
  void dispose() {
    _customPromptCtrl.dispose();
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
    final pyqTask = GenerationManager.instance.activePyqTasks[widget.book.id];
    if (pyqTask != null) return;

    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one exam paper PDF/Image.'))
      );
      return;
    }

    // Check if any sections have lessons generated
    final hasLessons = widget.book.modules
        .expand((m) => m.sections)
        .any((s) => s.units.any((u) => u.isGenerated && u.lessons.isNotEmpty));

    if (!hasLessons) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppTheme.surface,
          title: const Text('No Lessons Generated', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: const Text(
            'We can only extract questions for sections that have generated lessons. '
            'Please generate lessons for at least one section first.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK', style: TextStyle(color: AppTheme.duoBlue)),
            )
          ],
        ),
      );
      return;
    }

    final customInstructions = _customPromptCtrl.text.trim();

    GenerationManager.instance.startPyqAnalysis(
      widget.book.id, 
      _selectedFiles, 
      widget.book,
      customInstructions: customInstructions.isNotEmpty ? customInstructions : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Exam in Background! You can continue browsing.'))
    );

    setState(() {
      _selectedFiles.clear();
      _customPromptCtrl.clear();
    });
  }

  void _editQuestion(Section section, int slideIndex, Slide slide) async {
    final titleCtrl = TextEditingController(text: slide.title);
    final contentCtrl = TextEditingController(text: slide.content);
    final answerCtrl = TextEditingController(text: slide.blankAnswer ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Verify & Edit Question', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Question Title', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextField(
                controller: titleCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Question Content', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextField(
                controller: contentCtrl,
                maxLines: null,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              if (slide.type == 'one_word') ...[
                const Text('Correct Answer', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                TextField(
                  controller: answerCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Save', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
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
        backgroundColor: AppTheme.surface,
        title: const Text('Delete Question?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('This will permanently delete this question from this section.', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final updatedQuestions = List<Slide>.from(section.pyqQuestions)..removeAt(slideIndex);
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: GenerationManager.instance,
      builder: (context, _) {
        final pyqTask = GenerationManager.instance.activePyqTasks[widget.book.id];
        
        final List<Section> sectionsWithPyqs = [];
        for (final m in widget.book.modules) {
          for (final s in m.sections) {
            if (s.pyqQuestions.isNotEmpty) {
              sectionsWithPyqs.add(s);
            }
          }
        }

        return Scaffold(
          body: ResponsiveCenter(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                if (pyqTask != null)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: AppTheme.glassDecoration.copyWith(
                        border: Border.all(color: pyqTask.isError ? AppTheme.duoRed : AppTheme.duoBlue, width: 2)
                      ),
                      child: Row(
                        children: [
                          if (pyqTask.isError)
                            const Icon(LucideIcons.alertTriangle, color: AppTheme.duoRed, size: 24)
                          else
                            const SizedBox(
                              width: 24, height: 24, 
                              child: CircularProgressIndicator(color: AppTheme.duoBlue, strokeWidth: 3)
                            ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              pyqTask.status, 
                              style: TextStyle(fontWeight: FontWeight.bold, color: pyqTask.isError ? AppTheme.duoRed : Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ),
                          if (pyqTask.isError)
                            IconButton(
                              icon: const Icon(LucideIcons.x, color: Colors.white54),
                              onPressed: () => GenerationManager.instance.clearPyqError(widget.book.id),
                            )
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
                        const Text(
                          'Upload Previous Year Question Papers',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Select PDF papers or image snapshots. The AI will extract the questions, split them across sections with generated lessons, and solve them interactively. Questions can then be solved in the Practice Arena.',
                          style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        FileSelectionList(
                          files: _selectedFiles,
                          onAddMore: _pickFiles,
                          onRemove: (idx) => setState(() => _selectedFiles.removeAt(idx)),
                        ),
                        const SizedBox(height: 24),
                        const Text('Custom Prompt / Generation Instructions', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 14)),
                        const SizedBox(height: 8),
                        Container(
                          decoration: AppTheme.glassDecoration,
                          child: TextField(
                            controller: _customPromptCtrl,
                            maxLines: 4,
                            minLines: 2,
                            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "e.g. Focus on multiple choice questions, explain formula derivations.",
                              hintStyle: const TextStyle(color: Colors.white38, fontSize: 13, fontWeight: FontWeight.normal),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        DuoButton(
                          text: 'Analyze & Split Questions',
                          color: _selectedFiles.isNotEmpty && pyqTask == null ? AppTheme.duoBlue : Colors.grey.shade700,
                          shadowColor: _selectedFiles.isNotEmpty && pyqTask == null ? AppTheme.duoBlueDark : Colors.grey.shade800,
                          onPressed: _startAnalysis,
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  sliver: SliverToBoxAdapter(
                    child: Divider(color: Colors.white12, thickness: 1),
                  ),
                ),

                const SliverPadding(
                  padding: EdgeInsets.only(left: 24, top: 16, bottom: 8),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'VERIFY EXTRACTED QUESTIONS',
                      style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                    ),
                  ),
                ),

                if (sectionsWithPyqs.isEmpty)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(24),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.02),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Column(
                        children: [
                          Icon(LucideIcons.fileSearch, size: 40, color: Colors.white24),
                          const SizedBox(height: 12),
                          const Text(
                            'No extracted questions yet',
                            style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Upload a PDF or image paper above to get started.',
                            style: TextStyle(color: Colors.white38, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final section = sectionsWithPyqs[index];
                          final isExpanded = _selectedSectionId == section.id;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: AppTheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white.withOpacity(0.08)),
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
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                    subtitle: Text(
                                      '${section.pyqQuestions.length} questions extracted',
                                      style: const TextStyle(color: Colors.white38, fontSize: 12),
                                    ),
                                    trailing: Icon(
                                      isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                                      color: Colors.white54,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selectedSectionId = isExpanded ? null : section.id;
                                      });
                                    },
                                  ),
                                ),
                                if (isExpanded) ...[
                                  const Divider(color: Colors.white10, height: 1),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: section.pyqQuestions.length,
                                    itemBuilder: (context, qIdx) {
                                      final slide = section.pyqQuestions[qIdx];
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: slide.type == 'one_word' ? AppTheme.duoBlue.withOpacity(0.2) : AppTheme.duoViolet.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    slide.type == 'one_word' ? 'ONE WORD' : 'PROOF/BIG Q',
                                                    style: TextStyle(
                                                      color: slide.type == 'one_word' ? AppTheme.duoBlue : AppTheme.duoViolet,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  icon: const Icon(LucideIcons.edit3, size: 16, color: Colors.white60),
                                                  onPressed: () => _editQuestion(section, qIdx, slide),
                                                ),
                                                IconButton(
                                                  icon: const Icon(LucideIcons.trash2, size: 16, color: AppTheme.duoRed),
                                                  onPressed: () => _deleteQuestion(section, qIdx),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              slide.title,
                                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                            ),
                                            const SizedBox(height: 4),
                                            MathMarkdown(
                                              data: slide.content,
                                              textStyle: const TextStyle(color: Colors.white70, fontSize: 13),
                                            ),
                                            if (slide.type == 'one_word' && slide.blankAnswer != null) ...[
                                              const SizedBox(height: 8),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(text: 'Reference Answer: ', style: TextStyle(color: Colors.white38, fontSize: 12)),
                                                    TextSpan(
                                                      text: slide.blankAnswer,
                                                      style: const TextStyle(color: AppTheme.duoGreen, fontWeight: FontWeight.bold, fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ]
                              ],
                            ),
                          );
                        },
                        childCount: sectionsWithPyqs.length,
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),
          ),
        );
      }
    );
  }
}
