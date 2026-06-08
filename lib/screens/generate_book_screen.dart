import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/file_selection_list.dart';
import '../widgets/responsive_center.dart';
import 'index_picker_screen.dart';
import 'auto_index_screen.dart';
import 'pdf_split_preview_screen.dart';
import '../services/generation_manager.dart';
import '../services/pdf_service.dart';

enum GenerationMode { book, handout, course }
enum IndexMode { auto, manual, chapters }

class GenerateBookScreen extends StatefulWidget {
  const GenerateBookScreen({super.key});

  @override
  State<GenerateBookScreen> createState() => _GenerateBookScreenState();
}

class _GenerateBookScreenState extends State<GenerateBookScreen> {
  GenerationMode _mode = GenerationMode.book;
  IndexMode _indexMode = IndexMode.auto;
  final List<File> _selectedFiles = [];
  final List<File> _syllabusFiles = [];
  final TextEditingController _customPromptController = TextEditingController();

  @override
  void dispose() {
    _customPromptController.dispose();
    super.dispose();
  }

  Future<void> _pickFiles(bool forSyllabus) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        final newFiles = result.paths.where((p) => p != null).map((p) => File(p!)).toList();
        if (forSyllabus) {
          _syllabusFiles.addAll(newFiles);
        } else {
          _selectedFiles.addAll(newFiles);
        }
      });
    }
  }

  void _generate() {
    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select the required file(s).')));
      return;
    }
    if (_mode == GenerationMode.course && _syllabusFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a syllabus file for the course.')));
      return;
    }

    // Show loading spinner
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          color: AppTheme.surface,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppTheme.duoGreen),
                SizedBox(height: 16),
                Text('Preparing Files...', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );

    Future.microtask(() async {
      try {
        final pdfService = PdfService();
        File? finalSourcePdf;
        if (_mode == GenerationMode.handout) {
          if (_selectedFiles.length == 1 && _selectedFiles.first.path.toLowerCase().endsWith('.pdf')) {
            finalSourcePdf = _selectedFiles.first;
          } else {
            finalSourcePdf = await pdfService.mergeFiles(_selectedFiles);
          }
        }

        List<File> finalSyllabusFiles = [];
        if (_mode == GenerationMode.course && _syllabusFiles.isNotEmpty) {
          if (_syllabusFiles.length == 1 && _syllabusFiles.first.path.toLowerCase().endsWith('.pdf')) {
            finalSyllabusFiles = [_syllabusFiles.first];
          } else {
            finalSyllabusFiles = [await pdfService.mergeFiles(_syllabusFiles)];
          }
        }

        if (!mounted) return;
        Navigator.of(context).pop(); // dismiss loading dialog

        final firstPdf = _mode == GenerationMode.handout ? finalSourcePdf! : _selectedFiles.first;
        final filename = firstPdf.path.split(RegExp(r'[\\/]')).last;

        final hasBookmarks = await pdfService.hasBookmarks(firstPdf);
        bool useBookmarks = false;
        if (hasBookmarks && mounted) {
          useBookmarks = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              backgroundColor: AppTheme.surface,
              title: const Text('PDF Bookmarks Detected', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              content: const Text(
                'This PDF contains table-of-contents bookmarks. Would you like to use them for indexing/structure instead of scanning via AI?',
                style: TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('No, scan via AI', style: TextStyle(color: Colors.white54)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: const Text('Yes, use bookmarks', style: TextStyle(color: AppTheme.duoGreen)),
                ),
              ],
            ),
          ) ?? false;
        }

        if (useBookmarks && mounted) {
          final bookmarks = await pdfService.extractBookmarks(firstPdf);
          final mappedBook = pdfService.mapBookmarksToBook(bookmarks, filename, firstPdf);
          final sourceList = _mode == GenerationMode.handout ? [finalSourcePdf!] : _selectedFiles;
          
          await GenerationManager.instance.startBookGenerationFromBookmarks(sourceList, filename, mappedBook);
          
          final task = GenerationManager.instance.activeTasks.last;
          if (mounted) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => PdfSplitPreviewScreen(
                taskId: task.id,
                originalPdf: sourceList,
                skeletonBook: mappedBook,
              ),
            ));
          }
        } else {
          final customPrompt = _customPromptController.text.trim();
          if (_indexMode == IndexMode.manual || _indexMode == IndexMode.chapters) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => IndexPickerScreen(
                sourcePdf: firstPdf,
                filename: filename,
                syllabusFiles: finalSyllabusFiles,
                isCourse: _mode == GenerationMode.course,
                allSourcePdfs: _mode == GenerationMode.handout ? [finalSourcePdf!] : _selectedFiles,
                currentPdfIndex: 0,
                collectedIndexPages: const [],
                collectedChapter1StartPages: const [],
                isAutoMode: false,
                isHandout: _mode == GenerationMode.handout,
                indexMode: _indexMode,
                customIndexingPrompt: customPrompt.isNotEmpty ? customPrompt : null,
              ),
            ));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AutoIndexScreen(
                sourcePdf: firstPdf,
                filename: filename,
                syllabusFiles: finalSyllabusFiles,
                isCourse: _mode == GenerationMode.course,
                allSourcePdfs: _mode == GenerationMode.handout ? [finalSourcePdf!] : _selectedFiles,
                currentPdfIndex: 0,
                collectedIndexPages: const [],
                collectedChapter1StartPages: const [],
                isAutoMode: true,
                isHandout: _mode == GenerationMode.handout,
                customIndexingPrompt: customPrompt.isNotEmpty ? customPrompt : null,
              ),
            ));
          }
        }
      } catch (e) {
        if (mounted) {
          Navigator.of(context).pop(); // dismiss loading dialog
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error preparing files: $e')));
        }
      }
    });
  }

  void _showHandoutPrompt(File finalSourcePdf, String filename) {
    final TextEditingController instructionsCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Handout Info', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: instructionsCtrl,
          maxLines: 3,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Enter any instructions or context for this handout...',
            hintStyle: TextStyle(color: Colors.white54),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.duoGreen),
            onPressed: () {
              Navigator.of(ctx).pop();
              GenerationManager.instance.startBookGeneration(
                [finalSourcePdf],
                filename,
                indexFiles: [finalSourcePdf],
                chapter1AbsolutePages: const [1],
                customInstructions: instructionsCtrl.text.trim().isEmpty ? null : instructionsCtrl.text.trim(),
                isHandout: true,
              );
              Navigator.of(context).pop();
            },
            child: const Text('Generate', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildModeSelector() {
    return Row(
      children: [
        _buildModeTab(GenerationMode.book, 'Book', LucideIcons.book),
        const SizedBox(width: 8),
        _buildModeTab(GenerationMode.handout, 'Handout', LucideIcons.file),
        const SizedBox(width: 8),
        _buildModeTab(GenerationMode.course, 'Course', LucideIcons.graduationCap),
      ],
    );
  }

  Widget _buildModeTab(GenerationMode mode, String label, IconData icon) {
    final isSelected = _mode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _mode = mode;
            _selectedFiles.clear();
            _syllabusFiles.clear();
            if (mode == GenerationMode.handout) {
              _indexMode = IndexMode.chapters;
            } else {
              _indexMode = IndexMode.auto;
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.duoBlue : AppTheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? AppTheme.duoBlueDark : Colors.white12),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.white54, size: 24),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white54, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndexModeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        const Text('INDEXING METHOD', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: RadioListTile<IndexMode>(
                value: IndexMode.auto,
                groupValue: _indexMode,
                onChanged: (v) => setState(() => _indexMode = v!),
                title: const Text('Auto-Detect', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: const Text('AI finds TOC', style: TextStyle(fontSize: 11, color: Colors.white54)),
                activeColor: AppTheme.duoGreen,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: RadioListTile<IndexMode>(
                value: IndexMode.manual,
                groupValue: _indexMode,
                onChanged: (v) => setState(() => _indexMode = v!),
                title: const Text('Manual', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: const Text('You pick TOC', style: TextStyle(fontSize: 11, color: Colors.white54)),
                activeColor: AppTheme.duoGreen,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: RadioListTile<IndexMode>(
                value: IndexMode.chapters,
                groupValue: _indexMode,
                onChanged: (v) => setState(() => _indexMode = v!),
                title: const Text('Chapters', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: const Text('You pick starts', style: TextStyle(fontSize: 11, color: Colors.white54)),
                activeColor: AppTheme.duoGreen,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Material', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.form,
        child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildModeSelector(),
                    const SizedBox(height: 24),
                    
                    if (_mode == GenerationMode.course) ...[
                      const Text('SYLLABUS (PDF)', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                      const SizedBox(height: 12),
                      FileSelectionList(
                        files: _syllabusFiles,
                        onAddMore: () => _pickFiles(true),
                        onRemove: (idx) => setState(() => _syllabusFiles.removeAt(idx)),
                      ),
                      const SizedBox(height: 24),
                      const Text('REFERENCE BOOKS (PDF)', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                    ] else if (_mode == GenerationMode.book) ...[
                      const Text('TEXTBOOK (PDF)', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                    ] else ...[
                      const Text('DOCUMENT (PDF / Images)', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                    ],
                    
                    const SizedBox(height: 12),
                    FileSelectionList(
                      files: _selectedFiles,
                      onAddMore: () => _pickFiles(false),
                      onRemove: (idx) => setState(() => _selectedFiles.removeAt(idx)),
                    ),

                    _buildIndexModeSelector(),
                    const SizedBox(height: 24),
                    const Text('CUSTOM INDEXING INSTRUCTIONS (OPTIONAL)', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _customPromptController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'e.g. Ignore appendix chapters, focus on primary chapters, or translate topic names...',
                        hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
                        filled: true,
                        fillColor: AppTheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.duoGreen),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: DuoButton(
                text: 'Continue',
                onPressed: _generate,
                color: _selectedFiles.isNotEmpty && (_mode != GenerationMode.course || _syllabusFiles.isNotEmpty) ? AppTheme.duoGreen : Colors.grey.shade700,
                shadowColor: _selectedFiles.isNotEmpty && (_mode != GenerationMode.course || _syllabusFiles.isNotEmpty) ? AppTheme.duoGreenDark : Colors.grey.shade800,
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}