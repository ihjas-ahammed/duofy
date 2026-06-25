import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../services/b2_service.dart';
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
  String? _cacheDirPath;

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
    _initCacheDir();
    GenerationManager.instance.addListener(_onGenerationManagerChange);
    // Initialize if a task is already running
    _onGenerationManagerChange();
  }

  Future<void> _initCacheDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    if (mounted) {
      setState(() {
        _cacheDirPath = '${appDir.path}/b2_cache';
      });
    }
  }

  @override
  void dispose() {
    GenerationManager.instance.removeListener(_onGenerationManagerChange);
    super.dispose();
  }

  void _onGenerationManagerChange() {
    final taskId = "restore_${widget.book.id}";
    final taskIndex = GenerationManager.instance.activeTasks.indexWhere((t) => t.id == taskId);
    final hasActiveRunningTask = taskIndex != -1 && GenerationManager.instance.activeTasks[taskIndex].state != BookGenState.error;
    
    if (mounted) {
      setState(() {
        // If it was restoring and now it's not, and the files exist on disk, we succeeded!
        if (_isRestoring && !hasActiveRunningTask) {
          bool allRestored = true;
          for (int i = 0; i < expectedFileCount; i++) {
            if (!_isSlotRestoredOnDisk(i)) {
              allRestored = false;
              break;
            }
          }
          if (allRestored) {
            _successMessage = "All PDF reference chunks successfully restored!";
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) {
                Navigator.of(context).pop();
              }
            });
          }
        }
        _isRestoring = hasActiveRunningTask;
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

  void _showSourcePicker(int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AppTheme.applyGlassBlur(
          borderRadius: 24,
          color: AppTheme.surface.withOpacity(0.95),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Select PDF Source',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _pickFileForSlot(index);
                    },
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.duoBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(LucideIcons.folderOpen, color: AppTheme.duoBlue),
                    ),
                    title: const Text('Browse Device Files', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: const Text('Select a local PDF file from your device', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showDocumentStorePicker(index);
                    },
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.duoGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(LucideIcons.database, color: AppTheme.duoGreen),
                    ),
                    title: const Text('Choose from Document Store', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: const Text('Select from files uploaded to your cloud storage', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDocumentStorePicker(int index) {
    if (_cacheDirPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache directory not initialized yet. Please try again.')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: _DocumentStorePickerDialog(
            cacheDirPath: _cacheDirPath!,
            onFileSelected: (file) {
              setState(() {
                _selectedFiles[index] = file;
                _successMessage = null;
              });
            },
          ),
        );
      },
    );
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

                    // Active restore progress / error state
                    if (task.id.isNotEmpty) ...[
                      if (task.state == BookGenState.error)
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.duoRed.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.duoRed.withOpacity(0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(LucideIcons.alertTriangle, color: AppTheme.duoRed, size: 24),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      'Restore Failed',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(LucideIcons.x, color: Colors.white54, size: 20),
                                    onPressed: () {
                                      GenerationManager.instance.dismissTask(taskId);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SelectableText(
                                task.errorMessage ?? task.statusMessage,
                                style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white.withOpacity(0.08),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                    icon: const Icon(LucideIcons.copy, size: 14),
                                    label: const Text('Copy Error', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      final errText = task.errorMessage ?? task.statusMessage;
                                      Clipboard.setData(ClipboardData(text: errText));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Error copied to clipboard')),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  TextButton(
                                    child: const Text('Dismiss', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold, fontSize: 12)),
                                    onPressed: () {
                                      GenerationManager.instance.dismissTask(taskId);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      else if (_isRestoring)
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
                    ],

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
                            onTap: _isRestoring ? null : () => _showSourcePicker(index),
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

class _DocumentStorePickerDialog extends StatefulWidget {
  final String cacheDirPath;
  final ValueChanged<File> onFileSelected;

  const _DocumentStorePickerDialog({
    required this.cacheDirPath,
    required this.onFileSelected,
  });

  @override
  State<_DocumentStorePickerDialog> createState() => _DocumentStorePickerDialogState();
}

class _DocumentStorePickerDialogState extends State<_DocumentStorePickerDialog> {
  bool _isConfigured = false;
  bool _isLoading = true;
  List<B2Object> _files = [];
  String? _errorMessage;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // For download status
  String? _downloadingKey;
  double _downloadProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _checkConfigAndLoad();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _checkConfigAndLoad() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final configured = await B2Service.instance.isConfigured();
    if (!mounted) return;
    setState(() {
      _isConfigured = configured;
    });

    if (configured) {
      await _loadFiles();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadFiles() async {
    try {
      final files = await B2Service.instance.listObjects();
      // Sort files: newest first
      files.sort((a, b) {
        final aDate = a.lastModifiedDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.lastModifiedDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bDate.compareTo(aDate);
      });
      if (mounted) {
        setState(() {
          _files = files.where((f) => !f.key.endsWith('.thumb.jpg')).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load files: $e';
        });
      }
    }
  }

  List<B2Object> _getFilteredFiles() {
    if (_searchQuery.isEmpty) return _files;
    final query = _searchQuery.toLowerCase();
    return _files.where((f) {
      final name = f.key.split('/').last.toLowerCase();
      return name.contains(query);
    }).toList();
  }

  bool _isPdfCached(String key) {
    return File('${widget.cacheDirPath}/$key').existsSync();
  }

  Future<void> _handleFileSelection(B2Object file) async {
    if (_downloadingKey != null) return; // Busy downloading another file

    final localFile = File('${widget.cacheDirPath}/${file.key}');
    if (localFile.existsSync()) {
      widget.onFileSelected(localFile);
      Navigator.pop(context);
      return;
    }

    // Need to download
    setState(() {
      _downloadingKey = file.key;
      _downloadProgress = 0.0;
    });

    try {
      final bytes = await B2Service.instance.downloadObject(
        file.key,
        onProgress: (p) {
          if (mounted) {
            setState(() {
              _downloadProgress = p;
            });
          }
        },
      );

      // Save locally
      if (!await localFile.parent.exists()) {
        await localFile.parent.create(recursive: true);
      }
      await localFile.writeAsBytes(bytes);

      if (mounted) {
        widget.onFileSelected(localFile);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _downloadingKey = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download failed: $e'),
            backgroundColor: AppTheme.duoRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppTheme.applyGlassBlur(
        borderRadius: 24,
        color: AppTheme.surface.withOpacity(0.95),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top drag indicator / Header
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _downloadingKey != null ? 'Downloading File...' : 'Select Document Store File',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.x, color: Colors.white70),
                      onPressed: _downloadingKey != null ? null : () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white10),

              if (_downloadingKey != null) ...[
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.downloadCloud, size: 48, color: AppTheme.duoBlue),
                          const SizedBox(height: 16),
                          Text(
                            _downloadingKey!.split('/').last,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: _downloadProgress > 0 ? _downloadProgress : null,
                              backgroundColor: Colors.white10,
                              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.duoBlue),
                              minHeight: 8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${(_downloadProgress * 100).toStringAsFixed(0)}% downloaded',
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ] else if (!_isConfigured && !_isLoading) ...[
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.database, size: 48, color: AppTheme.duoOrange),
                          const SizedBox(height: 16),
                          const Text(
                            'Document Store Not Configured',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Cloud storage is not configured. Please setup credentials in the Document Store tab first.',
                            style: TextStyle(color: Colors.white54, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.surface,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Dismiss'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ] else if (_isLoading) ...[
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.duoBlue),
                    ),
                  ),
                ),
              ] else if (_errorMessage != null) ...[
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.alertTriangle, size: 48, color: AppTheme.duoRed),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.surface,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: _checkConfigAndLoad,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ] else ...[
                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search files...',
                        hintStyle: const TextStyle(color: Colors.white30),
                        prefixIcon: const Icon(LucideIcons.search, color: Colors.white30, size: 20),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(LucideIcons.x, color: Colors.white30, size: 20),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                    ),
                  ),
                ),

                // Files list
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final filtered = _getFilteredFiles();
                      if (filtered.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(LucideIcons.folderOpen, size: 48, color: Colors.white24),
                              const SizedBox(height: 12),
                              Text(
                                _searchQuery.isNotEmpty ? 'No files match "$_searchQuery"' : 'No files in Document Store',
                                style: const TextStyle(color: Colors.white38),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: filtered.length,
                        itemBuilder: (context, idx) {
                          final file = filtered[idx];
                          final displayName = file.key.split('/').last;
                          final isCached = _isPdfCached(file.key);
                          final isSyllabus = file.key.startsWith('syllabus/');

                          return ListTile(
                            onTap: () => _handleFileSelection(file),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: (isSyllabus ? AppTheme.duoOrange : AppTheme.duoBlue).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                LucideIcons.fileText,
                                color: isSyllabus ? AppTheme.duoOrange : AppTheme.duoBlue,
                              ),
                            ),
                            title: Text(
                              displayName,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  file.sizeFormatted,
                                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: (isSyllabus ? AppTheme.duoOrange : AppTheme.duoBlue).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    isSyllabus ? 'Syllabus' : 'Reference',
                                    style: TextStyle(
                                      color: isSyllabus ? AppTheme.duoOrange : AppTheme.duoBlue,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              isCached ? LucideIcons.checkCircle2 : LucideIcons.downloadCloud,
                              color: isCached ? AppTheme.duoGreen : Colors.white30,
                              size: 20,
                            ),
                          );
                        },
                      );
                    },
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
