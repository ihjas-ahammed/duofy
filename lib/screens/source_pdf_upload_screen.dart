import '../platform/io_shim.dart';
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
import 'document_store_screen.dart';

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
        if ((section.bookIndex ?? 0) > maxBookIdx) {
          maxBookIdx = section.bookIndex!;
        }
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
    final taskIndex = GenerationManager.instance.activeTasks.indexWhere(
      (t) => t.id == taskId,
    );
    final hasActiveRunningTask =
        taskIndex != -1 &&
        GenerationManager.instance.activeTasks[taskIndex].state !=
            BookGenState.error;

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
        // Knowledge-only sections were never mapped to a source PDF, so they
        // can't be "missing" one.
        if (section.hasSourceMapping && (section.bookIndex ?? 0) == bookIdx) {
          foundAny = true;
          if (section.pdfPath == null || !File(section.pdfPath!).existsSync()) {
            return false;
          }
        }
        for (final unit in section.units) {
          final unitMapped = unit.pdfPath != null || unit.startPage != null;
          if (unitMapped && (unit.bookIndex ?? 0) == bookIdx) {
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
      bool anyMapped = false;
      for (final module in widget.book.modules) {
        for (final section in module.sections) {
          if (section.hasSourceMapping) {
            anyMapped = true;
            if (section.pdfPath == null ||
                !File(section.pdfPath!).existsSync()) {
              return false;
            }
          }
          for (final unit in section.units) {
            if (unit.pdfPath != null || unit.startPage != null) {
              anyMapped = true;
              if (unit.pdfPath == null || !File(unit.pdfPath!).existsSync()) {
                return false;
              }
            }
          }
        }
      }
      return anyMapped;
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
        _successMessage =
            null; // Clear success banner if they start editing again
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
      final picked = result.paths
          .where((p) => p != null)
          .map((p) => File(p!))
          .toList();
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
          color: context.colors.surface.withValues(alpha: 0.95),
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
                        color: context.colors.textFaint,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Select PDF Source',
                    style: TextStyle(
                      color: context.colors.textPrimary,
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
                        color: AppTheme.duoBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        LucideIcons.folderOpen,
                        color: AppTheme.duoBlue,
                      ),
                    ),
                    title: Text(
                      'Browse Device Files',
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Select a local PDF file from your device',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 12,
                      ),
                    ),
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
                        color: AppTheme.duoGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        LucideIcons.database,
                        color: AppTheme.duoGreen,
                      ),
                    ),
                    title: Text(
                      'Choose from Document Store',
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Select from files uploaded to your cloud storage',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 12,
                      ),
                    ),
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

  Future<void> _showDocumentStorePicker(int index) async {
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
      builder: (ctx) => const DocumentStorePickerDialog(forSyllabus: false),
    );

    if (selected != null && mounted) {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${appDir.path}/b2_cache');
      final file = File('${cacheDir.path}/${selected.key}');

      if (file.existsSync()) {
        setState(() {
          _selectedFiles[index] = file;
          _successMessage = null;
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
        setState(() {
          _selectedFiles[index] = downloadedFile;
          _successMessage = null;
        });
      }
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
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: Text(
          'Source PDFs',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        actions: [
          if (!_isRestoring && expectedFileCount > 1)
            IconButton(
              icon: const Icon(LucideIcons.filePlus, color: AppTheme.duoBlue),
              tooltip: 'Select All Files',
              onPressed: _pickAllFiles,
            ),
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
                      decoration: AppTheme.glassOf(context),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.duoBlue.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              LucideIcons.bookOpen,
                              color: AppTheme.duoBlue,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.book.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    color: context.colors.textPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  widget.book.description,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: context.colors.textSecondary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    if (_successMessage != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.duoGreen.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.duoGreen.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              LucideIcons.checkCircle2,
                              color: AppTheme.duoGreen,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _successMessage!,
                                style: TextStyle(
                                  color: context.colors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
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
                            color: AppTheme.duoRed.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTheme.duoRed.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    LucideIcons.alertTriangle,
                                    color: AppTheme.duoRed,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Restore Failed',
                                      style: TextStyle(
                                        color: context.colors.textPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      LucideIcons.x,
                                      color: context.colors.textFaint,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      GenerationManager.instance.dismissTask(
                                        taskId,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              SelectableText(
                                task.errorMessage ?? task.statusMessage,
                                style: TextStyle(
                                  color: context.colors.textSecondary,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          context.colors.surfaceAlt,
                                      foregroundColor:
                                          context.colors.textPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                    ),
                                    icon: const Icon(
                                      LucideIcons.copy,
                                      size: 14,
                                    ),
                                    label: const Text(
                                      'Copy Error',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      final errText =
                                          task.errorMessage ??
                                          task.statusMessage;
                                      Clipboard.setData(
                                        ClipboardData(text: errText),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Error copied to clipboard',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  TextButton(
                                    child: const Text(
                                      'Dismiss',
                                      style: TextStyle(
                                        color: AppTheme.duoRed,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    onPressed: () {
                                      GenerationManager.instance.dismissTask(
                                        taskId,
                                      );
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
                            color: AppTheme.duoBlue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTheme.duoBlue.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppTheme.duoBlue,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      task.statusMessage.isNotEmpty
                                          ? task.statusMessage
                                          : 'Restoring course files...',
                                      style: TextStyle(
                                        color: context.colors.textPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: (task.progress ?? 0) > 0
                                      ? task.progress
                                      : null,
                                  backgroundColor: context.colors.outline,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        AppTheme.duoBlue,
                                      ),
                                  minHeight: 8,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please keep the app open. We are splitting the files into optimized PDF reference chunks for each topic.',
                                style: TextStyle(
                                  color: context.colors.textFaint,
                                  fontSize: 11,
                                ),
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
                        style: TextStyle(
                          color: context.colors.textSecondary,
                          fontSize: 13,
                          height: 1.4,
                        ),
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
                        decoration: AppTheme.glassOf(context).copyWith(
                          border: Border.all(
                            color: file != null
                                ? AppTheme.duoBlue.withValues(alpha: 0.4)
                                : (isRestored
                                      ? AppTheme.duoGreen.withValues(alpha: 0.3)
                                      : AppTheme.duoOrange.withValues(alpha: 0.3)),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: _isRestoring
                                ? null
                                : () => _showSourcePicker(index),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  // Leading status indicator
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: file != null
                                          ? AppTheme.duoBlue.withValues(alpha: 0.2)
                                          : (isRestored
                                                ? AppTheme.duoGreen.withValues(
                                                    alpha: 0.15,
                                                  )
                                                : AppTheme.duoOrange
                                                      .withValues(alpha: 0.15)),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      LucideIcons.fileText,
                                      color: file != null
                                          ? AppTheme.duoBlue
                                          : (isRestored
                                                ? AppTheme.duoGreen
                                                : AppTheme.duoOrange),
                                      size: 22,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  // Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          expectedFileCount > 1
                                              ? 'Part ${index + 1}'
                                              : 'Source PDF Document',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                            color: context.colors.textPrimary,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          'Covers: $topics',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: context.colors.textFaint,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 6),
                                        if (file != null)
                                          Text(
                                            'Selected: ${file.path.split(RegExp(r"[/\\]")).last}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.duoBlue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        else if (isRestored)
                                          const Row(
                                            children: [
                                              Icon(
                                                LucideIcons.check,
                                                color: AppTheme.duoGreen,
                                                size: 14,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                'Ready on device',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppTheme.duoGreen,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        else
                                          const Row(
                                            children: [
                                              Icon(
                                                LucideIcons.alertCircle,
                                                color: AppTheme.duoOrange,
                                                size: 14,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                'Missing reference file',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppTheme.duoOrange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  // Clear / pick action
                                  if (file != null && !_isRestoring)
                                    IconButton(
                                      icon: const Icon(
                                        LucideIcons.x,
                                        color: AppTheme.duoRed,
                                        size: 20,
                                      ),
                                      onPressed: () => _clearSlot(index),
                                    )
                                  else if (!_isRestoring)
                                    Icon(
                                      LucideIcons.chevronRight,
                                      color: context.colors.textFaint,
                                    ),
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
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: context.colors.outline),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DuoButton(
                      text: _isRestoring ? 'Restoring...' : 'Restore Files',
                      color: _canRestore
                          ? AppTheme.duoGreen
                          : Color(0xFF334155),
                      shadowColor: _canRestore
                          ? AppTheme.duoGreenDark
                          : const Color(0xFF1E293B),
                      onPressed: _canRestore ? _startRestore : () {},
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _isRestoring
                          ? null
                          : () => Navigator.pop(context),
                      child: Text(
                        _successMessage != null ? 'CLOSE' : 'CANCEL',
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontWeight: FontWeight.bold,
                        ),
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
  }
}

class DocumentStorePickerDialog extends StatefulWidget {
  final bool forSyllabus;
  final bool forPyq;

  const DocumentStorePickerDialog({
    super.key,
    this.forSyllabus = false,
    this.forPyq = false,
  });

  @override
  State<DocumentStorePickerDialog> createState() =>
      DocumentStorePickerDialogState();
}

class DocumentStorePickerDialogState
    extends State<DocumentStorePickerDialog> {
  bool _isLoading = true;
  String? _errorMessage;
  List<B2Object> _files = [];
  late DocCategory _selectedCategory;
  String? _selectedCourseFilter;
  String? _selectedSemesterFilter;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  String? _cacheDirPath;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.forPyq
        ? DocCategory.pyq
        : (widget.forSyllabus ? DocCategory.syllabus : DocCategory.reference);
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
        final aDate =
            a.lastModifiedDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate =
            b.lastModifiedDate ?? DateTime.fromMillisecondsSinceEpoch(0);
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

      if (_selectedCategory == DocCategory.syllabus) {
        if (_selectedCourseFilter != null && file.course != _selectedCourseFilter) {
          return false;
        }
        if (_selectedSemesterFilter != null && file.semester != _selectedSemesterFilter) {
          return false;
        }
      }

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
      backgroundColor: context.colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      actionsPadding: const EdgeInsets.all(16),
      title: Row(
        children: [
          Icon(LucideIcons.cloud, color: AppTheme.duoViolet),
          const SizedBox(width: 8),
          Text(
            'Document Store',
            style: TextStyle(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
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
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: context.colors.surfaceAlt,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colors.outline),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.search,
                    color: context.colors.textFaint,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search documents...',
                        hintStyle: TextStyle(
                          color: context.colors.textFaint,
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                      child: Icon(
                        LucideIcons.x,
                        color: context.colors.textFaint,
                        size: 14,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Category Selector Tabs
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: context.colors.surfaceAlt,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.colors.outline),
              ),
              child: Row(
                children: [
                  if (!widget.forPyq) ...[
                    Expanded(
                      child: _buildTab(
                        DocCategory.reference,
                        'Reference',
                        LucideIcons.bookOpen,
                      ),
                    ),
                    Expanded(
                      child: _buildTab(
                        DocCategory.syllabus,
                        'Syllabus',
                        LucideIcons.fileSpreadsheet,
                      ),
                    ),
                  ],
                  Expanded(
                    child: _buildTab(
                      DocCategory.pyq,
                      'PYQs',
                      LucideIcons.fileQuestion,
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedCategory == DocCategory.syllabus) ...[
              const SizedBox(height: 12),
              Builder(
                builder: (context) {
                  final syllabusFiles = _files.where((f) => getDocCategory(f) == DocCategory.syllabus).toList();
                  final courses = syllabusFiles.map((f) => f.course).whereType<String>().toSet().toList()..sort();
                  final semesters = syllabusFiles.map((f) => f.semester).whereType<String>().toSet().toList()
                    ..sort((a, b) {
                      final aNum = int.tryParse(a.replaceAll(RegExp(r'\D'), '')) ?? 0;
                      final bNum = int.tryParse(b.replaceAll(RegExp(r'\D'), '')) ?? 0;
                      return aNum.compareTo(bNum);
                    });

                  return Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String?>(
                          initialValue: _selectedCourseFilter,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: 'Course',
                            labelStyle: TextStyle(color: context.colors.textFaint, fontSize: 11),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          dropdownColor: context.colors.surface,
                          items: [
                            DropdownMenuItem<String?>(
                              value: null,
                              child: Text('All Courses', style: TextStyle(color: context.colors.textPrimary, fontSize: 12)),
                            ),
                            ...courses.map((c) => DropdownMenuItem<String?>(
                              value: c,
                              child: Text(c, style: TextStyle(color: context.colors.textPrimary, fontSize: 12)),
                            )),
                          ],
                          onChanged: (val) {
                            setState(() {
                              _selectedCourseFilter = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField<String?>(
                          initialValue: _selectedSemesterFilter,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: 'Semester',
                            labelStyle: TextStyle(color: context.colors.textFaint, fontSize: 11),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          dropdownColor: context.colors.surface,
                          items: [
                            DropdownMenuItem<String?>(
                              value: null,
                              child: Text('All Semesters', style: TextStyle(color: context.colors.textPrimary, fontSize: 12)),
                            ),
                            ...semesters.map((s) => DropdownMenuItem<String?>(
                              value: s,
                              child: Text(s, style: TextStyle(color: context.colors.textPrimary, fontSize: 12)),
                            )),
                          ],
                          onChanged: (val) {
                            setState(() {
                              _selectedSemesterFilter = val;
                            });
                          },
                        ),
                      ),
                    ],
                  );
                }
              ),
            ],
            SizedBox(height: 12),
            // Files List
            Expanded(child: _buildListContent(filtered)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: context.colors.textFaint),
          ),
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
          _selectedCourseFilter = null;
          _selectedSemesterFilter = null;
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
            Icon(
              icon,
              size: 14,
              color: isSelected
                  ? context.colors.textPrimary
                  : context.colors.textFaint,
            ),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? context.colors.textPrimary
                    : context.colors.textFaint,
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
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.duoViolet),
      );
    }
    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: const TextStyle(color: AppTheme.duoRed, fontSize: 12),
        ),
      );
    }
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.folderClosed,
              size: 32,
              color: context.colors.textFaint,
            ),
            SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty ? 'No search results' : 'No documents',
              style: TextStyle(color: context.colors.textFaint, fontSize: 12),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: filtered.length,
      separatorBuilder: (_, _) =>
          Divider(height: 1, color: context.colors.outline),
      itemBuilder: (context, index) {
        final file = filtered[index];
        final name = file.key.split('/').last;
        final isCached = _isPdfCached(file.key);

        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            name,
            style: TextStyle(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            file.sizeFormatted,
            style: TextStyle(color: context.colors.textFaint, fontSize: 11),
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

class DownloadProgressDialog extends StatefulWidget {
  final B2Object b2Obj;

  const DownloadProgressDialog({super.key, required this.b2Obj});

  @override
  State<DownloadProgressDialog> createState() =>
      DownloadProgressDialogState();
}

class DownloadProgressDialogState extends State<DownloadProgressDialog> {
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
    final filename = widget.b2Obj.key.split('/').last;

    return AlertDialog(
      backgroundColor: context.colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        _errorMessage.isNotEmpty ? 'Download Failed' : 'Downloading File',
        style: TextStyle(
          color: context.colors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            filename,
            style: TextStyle(
              color: context.colors.textSecondary,
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16),
          if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: const TextStyle(color: AppTheme.duoRed, fontSize: 12),
            )
          else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: _progress > 0 ? _progress : null,
                backgroundColor: context.colors.outline,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppTheme.duoBlue,
                ),
                minHeight: 8,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${(_progress * 100).toStringAsFixed(0)}% downloaded',
              style: TextStyle(
                color: context.colors.textFaint,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
      actions: [
        if (_errorMessage.isNotEmpty)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: TextStyle(color: context.colors.textFaint),
            ),
          )
        else
          TextButton(
            onPressed: () {
              _cancelled = true;
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
      ],
    );
  }
}