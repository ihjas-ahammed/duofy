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
import 'package:path_provider/path_provider.dart';
import '../services/b2_service.dart';
import 'document_store_screen.dart';

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
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _customPromptController.dispose();
    _titleController.dispose();
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

  Future<void> _selectFromStore(bool forSyllabus) async {
    final configured = await B2Service.instance.isConfigured();
    if (!configured) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppTheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Cloud Storage Required',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Backblaze B2 is not configured. Please setup cloud storage in the Document Store tab first.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK', style: TextStyle(color: AppTheme.duoGreen, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
      return;
    }

    if (!mounted) return;
    final B2Object? selected = await showDialog<B2Object>(
      context: context,
      builder: (ctx) => _DocumentStorePickerDialog(forSyllabus: forSyllabus),
    );

    if (selected != null && mounted) {
      await _handleFileSelection(selected, forSyllabus);
    }
  }

  Future<void> _handleFileSelection(B2Object obj, bool forSyllabus) async {
    final appDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory('${appDir.path}/b2_cache');
    final file = File('${cacheDir.path}/${obj.key}');

    if (file.existsSync()) {
      setState(() {
        if (forSyllabus) {
          _syllabusFiles.add(file);
        } else {
          _selectedFiles.add(file);
        }
      });
      return;
    }

    if (!mounted) return;
    final File? downloadedFile = await showDialog<File>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _DownloadProgressDialog(b2Obj: obj),
    );

    if (downloadedFile != null && downloadedFile.existsSync() && mounted) {
      setState(() {
        if (forSyllabus) {
          _syllabusFiles.add(downloadedFile);
        } else {
          _selectedFiles.add(downloadedFile);
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
        final List<File> finalSyllabusFiles = _syllabusFiles;

        if (!mounted) return;
        Navigator.of(context).pop(); // dismiss loading dialog

        final firstPdf = _selectedFiles.first;
        final filename = firstPdf.path.split(RegExp(r'[\\/]')).last;

        final customPrompt = _customPromptController.text.trim();
        final presetTitle = _titleController.text.trim().isEmpty ? null : _titleController.text.trim();
        if (_mode == GenerationMode.handout) {
          _showHandoutPrompt(_selectedFiles, presetTitle ?? filename);
        } else if (_indexMode == IndexMode.manual || _indexMode == IndexMode.chapters) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => IndexPickerScreen(
              sourcePdf: firstPdf,
              filename: presetTitle ?? filename,
              syllabusFiles: finalSyllabusFiles,
              isCourse: _mode == GenerationMode.course,
              allSourcePdfs: _selectedFiles,
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
              filename: presetTitle ?? filename,
              syllabusFiles: finalSyllabusFiles,
              isCourse: _mode == GenerationMode.course,
              allSourcePdfs: _selectedFiles,
              currentPdfIndex: 0,
              collectedIndexPages: const [],
              collectedChapter1StartPages: const [],
              isAutoMode: true,
              isHandout: _mode == GenerationMode.handout,
              customIndexingPrompt: customPrompt.isNotEmpty ? customPrompt : null,
            ),
          ));
        }
      } catch (e) {
        if (mounted) {
          Navigator.of(context).pop(); // dismiss loading dialog
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error preparing files: $e')));
        }
      }
    });
  }

  void _showHandoutPrompt(List<File> selectedFiles, String filename) {
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
                selectedFiles,
                filename,
                indexFiles: selectedFiles,
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
                    const Text('COURSE TITLE (OPTIONAL)', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'e.g. Organic Chemistry, Linear Algebra...',
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
                    const SizedBox(height: 24),
                    
                    if (_mode == GenerationMode.course) ...[
                      const Text('SYLLABUS (PDF)', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                      const SizedBox(height: 12),
                      FileSelectionList(
                        files: _syllabusFiles,
                        onAddMore: () => _pickFiles(true),
                        onSelectFromStore: () => _selectFromStore(true),
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
                      onSelectFromStore: () => _selectFromStore(false),
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

class _DocumentStorePickerDialog extends StatefulWidget {
  final bool forSyllabus;

  const _DocumentStorePickerDialog({
    required this.forSyllabus,
  });

  @override
  State<_DocumentStorePickerDialog> createState() => _DocumentStorePickerDialogState();
}

class _DocumentStorePickerDialogState extends State<_DocumentStorePickerDialog> {
  bool _isLoading = true;
  String? _errorMessage;
  List<B2Object> _files = [];
  late DocCategory _selectedCategory;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  String? _cacheDirPath;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.forSyllabus ? DocCategory.syllabus : DocCategory.reference;
    _initCacheDir();
    _loadFiles();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _initCacheDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    if (mounted) {
      setState(() {
        _cacheDirPath = '${appDir.path}/b2_cache';
      });
    }
  }

  Future<void> _loadFiles() async {
    try {
      final files = await B2Service.instance.listObjects();
      // Sort newest first
      files.sort((a, b) {
        final aDate = a.lastModifiedDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.lastModifiedDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bDate.compareTo(aDate);
      });
      if (mounted) {
        setState(() {
          _files = files;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load files: $e';
          _isLoading = false;
        });
      }
    }
  }

  bool _isPdfCached(String key) {
    if (_cacheDirPath == null) return false;
    return File('$_cacheDirPath/$key').existsSync();
  }

  List<B2Object> _getFilteredFiles() {
    return _files.where((file) {
      if (file.key.endsWith('.thumb.jpg')) return false;

      final category = getDocCategory(file);
      if (category != _selectedCategory) return false;

      if (_searchQuery.isNotEmpty) {
        final displayName = file.key.split('/').last.toLowerCase();
        if (!displayName.contains(_searchQuery.toLowerCase())) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _getFilteredFiles();

    return AlertDialog(
      backgroundColor: AppTheme.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      actionsPadding: const EdgeInsets.all(16),
      title: const Row(
        children: [
          Icon(LucideIcons.cloud, color: AppTheme.duoViolet),
          SizedBox(width: 8),
          Text(
            'Document Store',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.search, color: Colors.white30, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: 'Search documents...',
                        hintStyle: TextStyle(color: Colors.white30, fontSize: 13),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = '';
                        });
                      },
                      child: const Icon(LucideIcons.x, color: Colors.white60, size: 14),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Category Selector Tabs
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.02),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTab(DocCategory.reference, 'Reference', LucideIcons.bookOpen),
                  ),
                  Expanded(
                    child: _buildTab(DocCategory.syllabus, 'Syllabus', LucideIcons.fileSpreadsheet),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Files List
            Expanded(
              child: _buildListContent(filtered),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
        ),
      ],
    );
  }

  Widget _buildTab(DocCategory category, String label, IconData icon) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.duoViolet : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: isSelected ? Colors.white : Colors.white60),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white60,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListContent(List<B2Object> filtered) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppTheme.duoViolet));
    }
    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!, style: const TextStyle(color: AppTheme.duoRed, fontSize: 12)));
    }
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.folderClosed, size: 32, color: Colors.white24),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty ? 'No search results' : 'No documents',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: filtered.length,
      separatorBuilder: (_, _) => const Divider(height: 1, color: Colors.white12),
      itemBuilder: (context, index) {
        final file = filtered[index];
        final name = file.key.split('/').last;
        final isCached = _isPdfCached(file.key);

        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            name,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            file.sizeFormatted,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          trailing: Icon(
            isCached ? LucideIcons.smartphone : LucideIcons.download,
            color: isCached ? AppTheme.duoBlue : AppTheme.duoGreen,
            size: 16,
          ),
          onTap: () => Navigator.of(context).pop(file),
        );
      },
    );
  }
}

class _DownloadProgressDialog extends StatefulWidget {
  final B2Object b2Obj;

  const _DownloadProgressDialog({
    required this.b2Obj,
  });

  @override
  State<_DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<_DownloadProgressDialog> {
  double _progress = 0.0;
  bool _cancelled = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _startDownload();
  }

  Future<void> _startDownload() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${appDir.path}/b2_cache');
      final localFile = File('${cacheDir.path}/${widget.b2Obj.key}');

      final bytes = await B2Service.instance.downloadObject(
        widget.b2Obj.key,
        onProgress: (p) {
          if (_cancelled) {
            throw Exception('Cancelled');
          }
          if (mounted) {
            setState(() {
              _progress = p;
            });
          }
        },
      );

      if (_cancelled) return;

      if (!await localFile.parent.exists()) {
        await localFile.parent.create(recursive: true);
      }
      await localFile.writeAsBytes(bytes);

      if (mounted) {
        Navigator.of(context).pop(localFile);
      }
    } catch (e) {
      if (_cancelled) {
        // Clean up partial file if exists
        try {
          final appDir = await getApplicationDocumentsDirectory();
          final localFile = File('${appDir.path}/b2_cache/${widget.b2Obj.key}');
          if (await localFile.exists()) {
            await localFile.delete();
          }
        } catch (_) {}
        return;
      }
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        _errorMessage.isNotEmpty ? 'Download Failed' : 'Downloading File',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_errorMessage.isNotEmpty) ...[
            Text(_errorMessage, style: const TextStyle(color: AppTheme.duoRed, fontSize: 13)),
            const SizedBox(height: 16),
          ] else ...[
            Text(
              widget.b2Obj.key.split('/').last,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(color: AppTheme.duoViolet),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.duoViolet),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(_progress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
      actions: [
        if (_errorMessage.isNotEmpty) ...[
          TextButton(
            onPressed: () {
              setState(() {
                _errorMessage = '';
                _progress = 0.0;
              });
              _startDownload();
            },
            child: const Text('Retry', style: TextStyle(color: AppTheme.duoGreen, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Close', style: TextStyle(color: Colors.white70)),
          ),
        ] else
          TextButton(
            onPressed: () {
              setState(() {
                _cancelled = true;
              });
              Navigator.of(context).pop(null);
            },
            child: const Text('Cancel', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }
}