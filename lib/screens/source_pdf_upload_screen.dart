import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../widgets/responsive_center.dart';
import '../widgets/duo_button.dart';

class SourcePdfUploadScreen extends StatefulWidget {
  final Book book;

  const SourcePdfUploadScreen({super.key, required this.book});

  @override
  State<SourcePdfUploadScreen> createState() => _SourcePdfUploadScreenState();
}

class _SourcePdfUploadScreenState extends State<SourcePdfUploadScreen> {
  late List<File?> _selectedFiles;
  bool _isRestoring = false;
  String? _successMessage;

  int get expectedFileCount {
    int maxBookIdx = 0;
    bool hasUnitsOrSections = false;
    for (final module in widget.book.modules) {
      for (final section in module.sections) {
        hasUnitsOrSections = true;
        if ((section.bookIndex ?? 0) > maxBookIdx) maxBookIdx = section.bookIndex!;
        for (final unit in section.units) {
          if ((unit.bookIndex ?? 0) > maxBookIdx) maxBookIdx = unit.bookIndex!;
        }
      }
    }
    return hasUnitsOrSections ? (maxBookIdx + 1) : 1;
  }

  @override
  void initState() {
    super.initState();
    _selectedFiles = List.filled(expectedFileCount, null);
    GenerationManager.instance.addListener(_onGenerationManagerChange);
    // Initialize if a task is already running
    _onGenerationManagerChange();
  }

  @override
  void dispose() {
    GenerationManager.instance.removeListener(_onGenerationManagerChange);
    super.dispose();
  }

  void _onGenerationManagerChange() {
    final taskId = "restore_${widget.book.id}";
    final hasActiveTask = GenerationManager.instance.activeTasks.any((t) => t.id == taskId);
    
    if (mounted) {
      setState(() {
        // If it was restoring and now it's not, and the files exist on disk, we succeeded!
        if (_isRestoring && !hasActiveTask) {
          bool allRestored = true;
          for (int i = 0; i < expectedFileCount; i++) {
            if (!_isSlotRestoredOnDisk(i)) {
              allRestored = false;
              break;
            }
          }
          if (allRestored) {
            _successMessage = "All PDF reference chunks successfully restored!";
          }
        }
        _isRestoring = hasActiveTask;
      });
    }
  }

  bool _isSlotRestoredOnDisk(int bookIdx) {
    bool foundAny = false;
    for (final module in widget.book.modules) {
      for (final section in module.sections) {
        if ((section.bookIndex ?? 0) == bookIdx) {
          foundAny = true;
          if (section.pdfPath == null || !File(section.pdfPath!).existsSync()) {
            return false;
          }
        }
        for (final unit in section.units) {
          if ((unit.bookIndex ?? 0) == bookIdx) {
            foundAny = true;
            if (unit.pdfPath == null || !File(unit.pdfPath!).existsSync()) {
              return false;
            }
          }
        }
      }
    }
    // For single-file fallback
    if (!foundAny && bookIdx == 0) {
      for (final module in widget.book.modules) {
        for (final section in module.sections) {
          if (section.pdfPath == null || !File(section.pdfPath!).existsSync()) {
            return false;
          }
          for (final unit in section.units) {
            if (unit.pdfPath == null || !File(unit.pdfPath!).existsSync()) {
              return false;
            }
          }
        }
      }
      return true;
    }
    return foundAny;
  }

  String _getTopicsForBookIdx(int bookIdx) {
    final List<String> topics = [];
    for (final module in widget.book.modules) {
      for (final section in module.sections) {
        if ((section.bookIndex ?? 0) == bookIdx) {
          topics.add(section.title);
        } else {
          for (final unit in section.units) {
            if ((unit.bookIndex ?? 0) == bookIdx) {
              topics.add(unit.title);
            }
          }
        }
      }
    }
    if (topics.isEmpty) {
      return "Course overview & chapters";
    }
    if (topics.length <= 2) {
      return topics.join(', ');
    }
    return "${topics.first} ... ${topics.last}";
  }

  Future<void> _pickFileForSlot(int index) async {
    if (_isRestoring) return;
    
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFiles[index] = File(result.files.single.path!);
        _successMessage = null; // Clear success banner if they start editing again
      });
    }
  }

  void _clearSlot(int index) {
    if (_isRestoring) return;
    setState(() {
      _selectedFiles[index] = null;
    });
  }

  Future<void> _pickAllFiles() async {
    if (_isRestoring) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result != null && result.paths.isNotEmpty) {
      final picked = result.paths.where((p) => p != null).map((p) => File(p!)).toList();
      setState(() {
        for (int i = 0; i < expectedFileCount && i < picked.length; i++) {
          _selectedFiles[i] = picked[i];
        }
        _successMessage = null;
      });
    }
  }

  void _startRestore() {
    // Collect selected files, fallback to already restored placeholder files if any (though usually we ask for all)
    final List<File> filesToRestore = [];
    for (int i = 0; i < expectedFileCount; i++) {
      if (_selectedFiles[i] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a PDF file for Part ${i + 1}')),
        );
        return;
      }
      filesToRestore.add(_selectedFiles[i]!);
    }

    setState(() {
      _successMessage = null;
      _isRestoring = true;
    });

    GenerationManager.instance.restoreBookFiles(widget.book, filesToRestore);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Starting restore process...')),
    );
  }

  bool get _canRestore {
    if (_isRestoring) return false;
    for (int i = 0; i < expectedFileCount; i++) {
      if (_selectedFiles[i] == null) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final taskId = "restore_${widget.book.id}";
    final task = GenerationManager.instance.activeTasks.firstWhere(
      (t) => t.id == taskId,
      orElse: () => GenerationTask(
        id: '',
        title: '',
        sourceFiles: [],
        state: BookGenState.chunking,
        statusMessage: '',
        startTime: DateTime.now(),
        estimatedDuration: const Duration(seconds: 15),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        title: const Text('Source PDFs', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        actions: [
          if (!_isRestoring && expectedFileCount > 1)
            IconButton(
              icon: const Icon(LucideIcons.filePlus, color: AppTheme.duoBlue),
              tooltip: 'Select All Files',
              onPressed: _pickAllFiles,
            )
        ],
      ),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.mobile,
        breakpoint: ResponsiveMaxWidth.mobile,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // Course header card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: AppTheme.glassDecoration,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.duoBlue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(LucideIcons.bookOpen, color: AppTheme.duoBlue, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.book.title,
                                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.book.description,
                                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    if (_successMessage != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.duoGreen.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppTheme.duoGreen.withOpacity(0.4)),
                        ),
                        child: Row(
                          children: [
                            const Icon(LucideIcons.checkCircle2, color: AppTheme.duoGreen, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _successMessage!,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Active restore progress
                    if (_isRestoring)
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.duoBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppTheme.duoBlue.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.duoBlue),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    task.statusMessage.isNotEmpty ? task.statusMessage : 'Restoring course files...',
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: (task.progress ?? 0) > 0 ? task.progress : null,
                                backgroundColor: Colors.white10,
                                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.duoBlue),
                                minHeight: 8,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Please keep the app open. We are splitting the files into optimized PDF reference chunks for each topic.',
                              style: TextStyle(color: Colors.white54, fontSize: 11),
                            ),
                          ],
                        ),
                      ),

                    // Instructions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        expectedFileCount > 1
                            ? 'This course was generated from $expectedFileCount source files. Please upload the PDF files in order to restore them:'
                            : 'Upload the original source PDF file to restore the in-lesson reference viewer:',
                        style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Slots list
                    ...List.generate(expectedFileCount, (index) {
                      final file = _selectedFiles[index];
                      final isRestored = _isSlotRestoredOnDisk(index);
                      final topics = _getTopicsForBookIdx(index);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: AppTheme.glassDecoration.copyWith(
                          border: Border.all(
                            color: file != null
                                ? AppTheme.duoBlue.withOpacity(0.4)
                                : (isRestored ? AppTheme.duoGreen.withOpacity(0.3) : AppTheme.duoOrange.withOpacity(0.3)),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: _isRestoring ? null : () => _pickFileForSlot(index),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  // Leading status indicator
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: file != null
                                          ? AppTheme.duoBlue.withOpacity(0.2)
                                          : (isRestored ? AppTheme.duoGreen.withOpacity(0.15) : AppTheme.duoOrange.withOpacity(0.15)),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      LucideIcons.fileText,
                                      color: file != null
                                          ? AppTheme.duoBlue
                                          : (isRestored ? AppTheme.duoGreen : AppTheme.duoOrange),
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          expectedFileCount > 1 ? 'Part ${index + 1}' : 'Source PDF Document',
                                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.white),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Covers: $topics',
                                          style: const TextStyle(fontSize: 11, color: Colors.white54),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        if (file != null)
                                          Text(
                                            'Selected: ${file.path.split(RegExp(r"[/\\]")).last}',
                                            style: const TextStyle(fontSize: 12, color: AppTheme.duoBlue, fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        else if (isRestored)
                                          const Row(
                                            children: [
                                              Icon(LucideIcons.check, color: AppTheme.duoGreen, size: 14),
                                              SizedBox(width: 4),
                                              Text(
                                                'Ready on device',
                                                style: TextStyle(fontSize: 12, color: AppTheme.duoGreen, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        else
                                          const Row(
                                            children: [
                                              Icon(LucideIcons.alertCircle, color: AppTheme.duoOrange, size: 14),
                                              SizedBox(width: 4),
                                              Text(
                                                'Missing reference file',
                                                style: TextStyle(fontSize: 12, color: AppTheme.duoOrange, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  // Clear / pick action
                                  if (file != null && !_isRestoring)
                                    IconButton(
                                      icon: const Icon(LucideIcons.x, color: AppTheme.duoRed, size: 20),
                                      onPressed: () => _clearSlot(index),
                                    )
                                  else if (!_isRestoring)
                                    const Icon(LucideIcons.chevronRight, color: Colors.white24),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Bottom Actions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white10)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DuoButton(
                      text: _isRestoring ? 'Restoring...' : 'Restore Files',
                      color: _canRestore ? AppTheme.duoGreen : const Color(0xFF334155),
                      shadowColor: _canRestore ? AppTheme.duoGreenDark : const Color(0xFF1E293B),
                      onPressed: _canRestore ? _startRestore : () {},
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _isRestoring ? null : () => Navigator.pop(context),
                      child: Text(
                        _successMessage != null ? 'CLOSE' : 'CANCEL',
                        style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
