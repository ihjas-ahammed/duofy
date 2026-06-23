import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/app_theme.dart';
import '../services/b2_service.dart';
import '../widgets/responsive_center.dart';
import '../widgets/safe_pdf_viewer.dart';
import '../widgets/duo_button.dart';
import '../services/pdf_service.dart';
import '../services/ai_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

enum DocCategory { reference, syllabus }

DocCategory getDocCategory(B2Object obj) {
  if (obj.key.startsWith('syllabus/')) {
    return DocCategory.syllabus;
  }
  if (obj.key.startsWith('reference/')) {
    return DocCategory.reference;
  }
  // Fallback for legacy files
  final lowerKey = obj.key.toLowerCase();
  if (lowerKey.contains('syllabus')) {
    return DocCategory.syllabus;
  }
  return DocCategory.reference;
}

class DocumentStoreScreen extends StatefulWidget {
  const DocumentStoreScreen({super.key});

  @override
  State<DocumentStoreScreen> createState() => _DocumentStoreScreenState();
}

class _DocumentStoreScreenState extends State<DocumentStoreScreen> {
  bool _isConfigured = false;
  bool _isLoading = true;
  bool _isActionLoading = false;
  String _actionLoadingText = '';
  List<B2Object> _files = [];
  String? _errorMessage;

  DocCategory _selectedCategory = DocCategory.reference;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  String? _cacheDirPath;
  double _actionProgress = 0.0;
  bool _actionCancelled = false;

  @override
  void initState() {
    super.initState();
    _initCacheDir();
    _checkConfigAndLoad();
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

  Future<void> _checkConfigAndLoad() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final configured = await B2Service.instance.isConfigured();
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
          _files = files;
          _isLoading = false;
          _errorMessage = null;
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

  Future<DocCategory?> _showCategorySelectionDialog() async {
    return showDialog<DocCategory>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Select Category',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose where to organize this PDF document:',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.duoBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(LucideIcons.bookOpen, color: AppTheme.duoBlue),
              ),
              title: const Text('Reference Book', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('Textbooks, guides, and reference material', style: TextStyle(color: Colors.white54, fontSize: 12)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onTap: () => Navigator.pop(ctx, DocCategory.reference),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.duoOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(LucideIcons.fileSpreadsheet, color: AppTheme.duoOrange),
              ),
              title: const Text('Syllabus', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('Course outlines and syllabus documents', style: TextStyle(color: Colors.white54, fontSize: 12)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onTap: () => Navigator.pop(ctx, DocCategory.syllabus),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, null),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
    );
  }

  Future<void> _pickAndUpload() async {
    if (_isActionLoading) return;

    final category = await _showCategorySelectionDialog();
    if (category == null) return;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result == null || result.files.single.path == null) return;

      final path = result.files.single.path!;
      final file = File(path);
      final filename = result.files.single.name;

      // Show the ConfirmNameDialog to confirm/customize the filename
      final confirmedName = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => ConfirmNameDialog(
          pdfFile: file,
          originalName: filename,
        ),
      );

      if (confirmedName == null || confirmedName.isEmpty) return;

      final bytes = await file.readAsBytes();
      final folder = category == DocCategory.syllabus ? 'syllabus' : 'reference';
      final objectKey = '$folder/$confirmedName';

      setState(() {
        _isActionLoading = true;
        _actionProgress = 0.0;
        _actionLoadingText = 'Uploading $confirmedName...';
        _actionCancelled = false;
      });

      // 1. Upload the main PDF file with progress
      await B2Service.instance.uploadObject(
        objectKey,
        bytes,
        onProgress: (p) {
          if (_actionCancelled) {
            throw Exception('Cancelled');
          }
          if (mounted) {
            setState(() {
              _actionProgress = p;
            });
          }
        },
      );

      // 2. Generate and upload thumbnail (page 1)
      try {
        setState(() {
          _actionProgress = 0.0;
          _actionLoadingText = 'Generating thumbnail...';
        });
        final thumbBytes = await PdfService().renderPageToImage(file, 1);
        if (thumbBytes != null) {
          setState(() {
            _actionLoadingText = 'Uploading thumbnail...';
          });
          final thumbKey = '$objectKey.thumb.jpg';
          await B2Service.instance.uploadObject(thumbKey, thumbBytes);

          // Save thumbnail to local cache
          if (_cacheDirPath != null) {
            final localThumbFile = File('$_cacheDirPath/$thumbKey');
            if (!await localThumbFile.parent.exists()) {
              await localThumbFile.parent.create(recursive: true);
            }
            await localThumbFile.writeAsBytes(thumbBytes);
          }
        }
      } catch (thumbErr) {
        debugPrint('Failed to generate/upload thumbnail: $thumbErr');
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully uploaded $confirmedName')),
        );
      }

      setState(() {
        _selectedCategory = category;
      });

      await _loadFiles();
    } catch (e) {
      if (_actionCancelled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Upload cancelled.')),
          );
        }
        return;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e'), backgroundColor: AppTheme.duoRed),
        );
      }
    } finally {
      setState(() {
        _isActionLoading = false;
      });
    }
  }

  Future<void> _downloadAndView(B2Object b2Obj, {bool forceRedownload = false}) async {
    if (_isActionLoading) return;

    try {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${appDir.path}/b2_cache');
      final localFile = File('${cacheDir.path}/${b2Obj.key}');

      // If already cached locally, open directly
      if (!forceRedownload && await localFile.exists()) {
        // Just in case, check if thumbnail exists locally, if not generate it
        final thumbFile = File('${cacheDir.path}/${b2Obj.key}.thumb.jpg');
        if (!await thumbFile.exists()) {
          try {
            final thumbBytes = await PdfService().renderPageToImage(localFile, 1);
            if (thumbBytes != null) {
              if (!await thumbFile.parent.exists()) {
                await thumbFile.parent.create(recursive: true);
              }
              await thumbFile.writeAsBytes(thumbBytes);
            }
          } catch (e) {
            debugPrint('Failed to generate local thumbnail on cached view: $e');
          }
        }

        _openPdfViewer(localFile, b2Obj.key.split('/').last);
        return;
      }

      // Download from B2
      setState(() {
        _isActionLoading = true;
        _actionProgress = 0.0;
        _actionLoadingText = 'Downloading ${b2Obj.key.split('/').last}...';
        _actionCancelled = false;
      });

      final bytes = await B2Service.instance.downloadObject(
        b2Obj.key,
        onProgress: (p) {
          if (_actionCancelled) {
            throw Exception('Cancelled');
          }
          if (mounted) {
            setState(() {
              _actionProgress = p;
            });
          }
        },
      );

      // Ensure parent directory for local cached file exists
      if (!await localFile.parent.exists()) {
        await localFile.parent.create(recursive: true);
      }
      await localFile.writeAsBytes(bytes);

      // Render thumbnail if not already present
      final thumbFile = File('${cacheDir.path}/${b2Obj.key}.thumb.jpg');
      if (!await thumbFile.exists()) {
        try {
          final thumbBytes = await PdfService().renderPageToImage(localFile, 1);
          if (thumbBytes != null) {
            if (!await thumbFile.parent.exists()) {
              await thumbFile.parent.create(recursive: true);
            }
            await thumbFile.writeAsBytes(thumbBytes);
          }
        } catch (e) {
          debugPrint('Failed to generate local thumbnail after download: $e');
        }
      }

      if (mounted) {
        setState(() {}); // Rebuild so that cached status is updated
        _openPdfViewer(localFile, b2Obj.key.split('/').last);
      }
    } catch (e) {
      if (_actionCancelled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Download cancelled.')),
          );
        }
        return;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e'), backgroundColor: AppTheme.duoRed),
        );
      }
    } finally {
      setState(() {
        _isActionLoading = false;
      });
    }
  }

  void _showContextMenu(B2Object file) {
    final category = getDocCategory(file);
    final displayName = file.key.split('/').last;

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
                  Text(
                    displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category == DocCategory.reference
                        ? 'Current Category: Reference Book'
                        : 'Current Category: Syllabus',
                    style: TextStyle(
                      color: category == DocCategory.reference
                          ? AppTheme.duoBlue
                          : AppTheme.duoOrange,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  if (category == DocCategory.reference)
                    _buildContextActionItem(
                      icon: LucideIcons.fileSpreadsheet,
                      label: 'Change Type to Syllabus',
                      color: AppTheme.duoOrange,
                      onTap: () {
                        Navigator.pop(context);
                        _changeDocumentCategory(file, DocCategory.syllabus);
                      },
                    )
                  else
                    _buildContextActionItem(
                      icon: LucideIcons.bookOpen,
                      label: 'Change Type to Reference Book',
                      color: AppTheme.duoBlue,
                      onTap: () {
                        Navigator.pop(context);
                        _changeDocumentCategory(file, DocCategory.reference);
                      },
                    ),
                  const SizedBox(height: 8),
                  _buildContextActionItem(
                    icon: LucideIcons.x,
                    label: 'Cancel',
                    color: Colors.white60,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContextActionItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: ListTile(
        leading: Icon(icon, color: color, size: 20),
        title: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap,
      ),
    );
  }

  Future<void> _changeDocumentCategory(B2Object file, DocCategory targetCategory) async {
    setState(() {
      _isActionLoading = true;
      _actionLoadingText = 'Changing document type...';
      _actionProgress = 0.0;
    });

    final oldKey = file.key;
    final filenameOnly = oldKey.split('/').last;
    final newKey = targetCategory == DocCategory.syllabus
        ? 'syllabus/$filenameOnly'
        : 'reference/$filenameOnly';

    try {
      await B2Service.instance.moveObject(oldKey, newKey);

      // Rename local cache files
      if (_cacheDirPath != null) {
        try {
          final oldLocalFile = File('$_cacheDirPath/$oldKey');
          final newLocalFile = File('$_cacheDirPath/$newKey');
          if (oldLocalFile.existsSync()) {
            newLocalFile.parent.createSync(recursive: true);
            oldLocalFile.renameSync(newLocalFile.path);
          }

          final oldLocalThumb = File('$_cacheDirPath/$oldKey.thumb.jpg');
          final newLocalThumb = File('$_cacheDirPath/$newKey.thumb.jpg');
          if (oldLocalThumb.existsSync()) {
            newLocalThumb.parent.createSync(recursive: true);
            oldLocalThumb.renameSync(newLocalThumb.path);
          }
        } catch (e) {
          print('[DocumentStoreScreen] Error moving local cache files: $e');
        }
      }

      await _loadFiles();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully changed document type to ${targetCategory == DocCategory.syllabus ? "Syllabus" : "Reference Book"}.'),
            backgroundColor: AppTheme.duoGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to change document type: $e'),
            backgroundColor: AppTheme.duoRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isActionLoading = false;
        });
      }
    }
  }

  void _openPdfViewer(File file, String filename) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => B2PdfViewerScreen(file: file, filename: filename),
      ),
    );
  }

  Future<void> _deleteFile(B2Object b2Obj) async {
    final displayName = b2Obj.key.split('/').last;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Delete Document?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to permanently delete "$displayName" from cloud store?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() {
      _isActionLoading = true;
      _actionLoadingText = 'Deleting $displayName...';
    });

    try {
      // 1. Delete main PDF
      await B2Service.instance.deleteObject(b2Obj.key);

      // 2. Delete cloud thumbnail if it exists
      final thumbKey = '${b2Obj.key}.thumb.jpg';
      final hasCloudThumb = _files.any((f) => f.key == thumbKey);
      if (hasCloudThumb) {
        try {
          await B2Service.instance.deleteObject(thumbKey);
        } catch (thumbErr) {
          debugPrint('Failed to delete cloud thumbnail: $thumbErr');
        }
      }

      // 3. Clean local cache PDF if exists
      final appDir = await getApplicationDocumentsDirectory();
      final localFile = File('${appDir.path}/b2_cache/${b2Obj.key}');
      if (await localFile.exists()) {
        await localFile.delete();
      }

      // 4. Clean local cache thumbnail if exists
      final localThumb = File('${appDir.path}/b2_cache/$thumbKey');
      if (await localThumb.exists()) {
        await localThumb.delete();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully deleted $displayName')),
        );
      }

      await _loadFiles();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Delete failed: $e'), backgroundColor: AppTheme.duoRed),
        );
      }
    } finally {
      setState(() {
        _isActionLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppTheme.background,
      floatingActionButton: _isConfigured && !_isLoading && _errorMessage == null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: FloatingActionButton(
                heroTag: 'doc_store_fab',
                onPressed: _pickAndUpload,
                backgroundColor: AppTheme.duoGreen,
                foregroundColor: Colors.white,
                elevation: 4,
                child: const Icon(LucideIcons.upload, size: 22),
              ),
            )
          : null,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: ResponsiveCenter(
              maxWidth: ResponsiveMaxWidth.content,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Area
                    _buildHeader(),
                    const SizedBox(height: 20),

                    // Search & Categories (only show when configured and loaded successfully)
                    if (_isConfigured && !_isLoading && _errorMessage == null) ...[
                      _buildSearchBar(),
                      const SizedBox(height: 16),
                      CategoryTabs(
                        selectedCategory: _selectedCategory,
                        onCategoryChanged: (category) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Main Content
                    Expanded(
                      child: _buildMainContent(screenWidth),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Loading Overlay
          if (_isActionLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(color: AppTheme.duoViolet),
                      const SizedBox(height: 16),
                      Text(
                        _actionLoadingText,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      if (_actionProgress > 0.0) ...[
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: SizedBox(
                            width: 200,
                            height: 8,
                            child: LinearProgressIndicator(
                              value: _actionProgress,
                              backgroundColor: Colors.white12,
                              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.duoViolet),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(_actionProgress * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _actionCancelled = true;
                            _isActionLoading = false;
                          });
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppTheme.duoRed,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Document Store',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  letterSpacing: -0.5,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _isConfigured
                    ? 'Upload and download PDF references from cloud store'
                    : '10 GB free cloud storage setup',
                style: const TextStyle(color: Colors.white54, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        if (_isConfigured && !_isLoading && _errorMessage == null)
          IconButton(
            icon: const Icon(LucideIcons.refreshCw, color: Colors.white70),
            tooltip: 'Refresh List',
            onPressed: _loadFiles,
          ),
      ],
    );
  }

  Widget _buildMainContent(double screenWidth) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.duoViolet),
      );
    }

    if (!_isConfigured) {
      return _buildSetupInstructions();
    }

    if (_errorMessage != null) {
      return Center(
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
            DuoButton(
              text: 'Retry',
              onPressed: _loadFiles,
              color: AppTheme.duoViolet,
              shadowColor: AppTheme.duoVioletDark,
            ),
          ],
        ),
      );
    }

    final filtered = _getFilteredFiles();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.02),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _searchQuery.isNotEmpty ? LucideIcons.search : LucideIcons.folderClosed,
                size: 64,
                color: Colors.white24,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _searchQuery.isNotEmpty ? 'No Search Results' : 'No Documents',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No documents in this category match "$_searchQuery".'
                  : 'Organize your references here by uploading a PDF document.',
              style: const TextStyle(color: Colors.white54, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            
          ],
        ),
      );
    }

    int crossAxisCount = screenWidth > 900 ? 5 : (screenWidth > 600 ? 3 : 2);

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemCount: filtered.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final file = filtered[index];
        return GestureDetector(
          onLongPress: () => _showContextMenu(file),
          child: _buildGridFileItem(file),
        );
      },
    );
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

  bool _isPdfCached(String key) {
    if (_cacheDirPath == null) return false;
    return File('$_cacheDirPath/$key').existsSync();
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.search, color: Colors.white30, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Search documents...',
                hintStyle: TextStyle(color: Colors.white30, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
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
              child: const Icon(LucideIcons.x, color: Colors.white60, size: 16),
            ),
        ],
      ),
    );
  }

  Widget _buildGridFileItem(B2Object file) {
    final isCached = _isPdfCached(file.key);
    final displayName = file.key.split('/').last;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // 1. Thumbnail Hero
            Positioned.fill(
              child: PdfThumbnailWidget(
                pdfObj: file,
                cloudFiles: _files,
              ),
            ),

            // 2. Subtle Cloud status indicator
            if (!isCached)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Icon(
                    LucideIcons.cloud,
                    color: Colors.white60,
                    size: 10,
                  ),
                ),
              ),

            // 3. Bottom Gradient & Actions
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 6,
                  bottom: 8,
                  top: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          file.sizeFormatted,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // View/Download
                            IconButton(
                              icon: Icon(
                                isCached ? LucideIcons.eye : LucideIcons.download,
                                color: isCached ? AppTheme.duoBlue : AppTheme.duoGreen,
                                size: 16,
                              ),
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(6),
                              tooltip: isCached ? 'Open & View' : 'Download',
                              onPressed: () => _downloadAndView(file),
                            ),
                            // Redownload / Retry
                            if (isCached)
                              IconButton(
                                icon: const Icon(
                                  LucideIcons.refreshCw,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                constraints: const BoxConstraints(),
                                padding: const EdgeInsets.all(6),
                                tooltip: 'Redownload (Force Fetch)',
                                onPressed: () => _downloadAndView(file, forceRedownload: true),
                              ),
                            // Delete
                            IconButton(
                              icon: const Icon(
                                LucideIcons.trash2,
                                color: AppTheme.duoRed,
                                size: 16,
                              ),
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(6),
                              tooltip: 'Delete',
                              onPressed: () => _deleteFile(file),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetupInstructions() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: const Column(
              children: [
                Icon(LucideIcons.hardDrive, size: 48, color: AppTheme.duoViolet),
                SizedBox(height: 16),
                Text(
                  'Backblaze B2 Setup Required',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Backblaze B2 is not configured. Please configure your keyId, applicationKey, bucketName, and region constants in lib/services/b2_service.dart.',
                  style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          const Text(
            'Step-by-step Setup Guide',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(height: 16),

          _buildStepItem('1', 'Sign Up for Backblaze B2', 'Go to backblaze.com/cloud-storage and create a free B2 Cloud Storage account.'),
          _buildStepItem('2', 'Create a Bucket', 'In B2 console -> Buckets, click "Create a Bucket". Choose a unique name and set it to Private (we support secure signed access!).'),
          _buildStepItem('3', 'Note Endpoint & Region', 'Once created, copy the bucket S3 endpoint (e.g. s3.us-west-004.backblazeb2.com). The region is the part after "s3." (e.g. us-west-004).'),
          _buildStepItem('4', 'Create Application Key', 'In App Keys left sidebar, click "Add a New Application Key". Select your bucket, set permission to Read & Write, and click Create Key.'),
          _buildStepItem('5', 'Paste Credentials', 'Copy the resulting keyID and applicationKey. Open lib/services/b2_service.dart and enter them in the default constants.'),
        ],
      ),
    );
  }

  Widget _buildStepItem(String num, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: AppTheme.duoViolet.withOpacity(0.2),
            child: Text(
              num,
              style: const TextStyle(color: AppTheme.duoViolet, fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white54, fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class B2PdfViewerScreen extends StatelessWidget {
  final File file;
  final String filename;

  const B2PdfViewerScreen({
    super.key,
    required this.file,
    required this.filename,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: Text(
          filename,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.share2),
            tooltip: Platform.isLinux ? 'Save Document As' : 'Share Document',
            onPressed: () async {
              if (Platform.isLinux) {
                final savePath = await FilePicker.platform.saveFile(
                  dialogTitle: 'Save PDF Document',
                  fileName: filename,
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );
                if (savePath != null) {
                  try {
                    await file.copy(savePath);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Saved successfully to $savePath')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error saving file: $e'), backgroundColor: AppTheme.duoRed),
                      );
                    }
                  }
                }
              } else {
                Share.shareXFiles([XFile(file.path)], text: filename);
              }
            },
          ),
        ],
      ),
      body: SafePdfViewer(file: file),
    );
  }
}

class PdfThumbnailWidget extends StatefulWidget {
  final B2Object pdfObj;
  final List<B2Object> cloudFiles;

  const PdfThumbnailWidget({
    super.key,
    required this.pdfObj,
    required this.cloudFiles,
  });

  @override
  State<PdfThumbnailWidget> createState() => _PdfThumbnailWidgetState();
}

class _PdfThumbnailWidgetState extends State<PdfThumbnailWidget> {
  Uint8List? _imageBytes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  @override
  void didUpdateWidget(PdfThumbnailWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pdfObj.key != widget.pdfObj.key) {
      _loadThumbnail();
    }
  }

  Future<void> _loadThumbnail() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _imageBytes = null;
    });

    try {
      final appDir = await getApplicationDocumentsDirectory();
      final thumbFile = File('${appDir.path}/b2_cache/${widget.pdfObj.key}.thumb.jpg');

      // 1. Check if local thumbnail cache exists
      if (await thumbFile.exists()) {
        final bytes = await thumbFile.readAsBytes();
        if (mounted) {
          setState(() {
            _imageBytes = bytes;
            _isLoading = false;
          });
        }
        return;
      }

      // 2. Check if cloud has thumbnail
      final thumbKey = '${widget.pdfObj.key}.thumb.jpg';
      final hasCloudThumb = widget.cloudFiles.any((f) => f.key == thumbKey);

      if (hasCloudThumb) {
        final bytes = await B2Service.instance.downloadObject(thumbKey);
        // Save to local cache
        if (!await thumbFile.parent.exists()) {
          await thumbFile.parent.create(recursive: true);
        }
        await thumbFile.writeAsBytes(bytes);
        if (mounted) {
          setState(() {
            _imageBytes = bytes;
            _isLoading = false;
          });
        }
        return;
      }

      // 3. Check if local PDF is already cached
      final pdfFile = File('${appDir.path}/b2_cache/${widget.pdfObj.key}');
      if (await pdfFile.exists()) {
        final bytes = await PdfService().renderPageToImage(pdfFile, 1);
        if (bytes != null) {
          if (!await thumbFile.parent.exists()) {
            await thumbFile.parent.create(recursive: true);
          }
          await thumbFile.writeAsBytes(bytes);
          if (mounted) {
            setState(() {
              _imageBytes = bytes;
              _isLoading = false;
            });
          }
          return;
        }
      }

      // 4. Default: No thumbnail available
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading thumbnail for ${widget.pdfObj.key}: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white.withOpacity(0.02),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppTheme.duoBlue,
            ),
          ),
        ),
      );
    }

    if (_imageBytes != null) {
      return Image.memory(
        _imageBytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    // Gradient background with file icon fallback
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.surface,
            AppTheme.surface.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.duoBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.fileText,
                color: AppTheme.duoBlue,
                size: 32,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'PDF',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTabs extends StatelessWidget {
  final DocCategory selectedCategory;
  final ValueChanged<DocCategory> onCategoryChanged;

  const CategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              context,
              category: DocCategory.reference,
              label: 'Reference Books',
              icon: LucideIcons.bookOpen,
            ),
          ),
          Expanded(
            child: _buildTab(
              context,
              category: DocCategory.syllabus,
              label: 'Syllabus',
              icon: LucideIcons.fileSpreadsheet,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required DocCategory category,
    required String label,
    required IconData icon,
  }) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () => onCategoryChanged(category),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.duoViolet : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.white60,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white60,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmNameDialog extends StatefulWidget {
  final File pdfFile;
  final String originalName;

  const ConfirmNameDialog({
    super.key,
    required this.pdfFile,
    required this.originalName,
  });

  @override
  State<ConfirmNameDialog> createState() => _ConfirmNameDialogState();
}

class _ConfirmNameDialogState extends State<ConfirmNameDialog> {
  late TextEditingController _nameController;
  bool _isSuggesting = false;

  @override
  void initState() {
    super.initState();
    final nameWithoutExt = widget.originalName.endsWith('.pdf')
        ? widget.originalName.substring(0, widget.originalName.length - 4)
        : widget.originalName;
    _nameController = TextEditingController(text: nameWithoutExt);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _getAiSuggestion() async {
    setState(() {
      _isSuggesting = true;
    });

    try {
      // 1. Extract only the first page
      final firstPagePdf = await PdfService().extractPages(widget.pdfFile, [1]);
      // 2. Extract text from the first page
      final text = await PdfService().extractTextFromPdf(firstPagePdf);
      
      // 3. Query Lite AI
      final apiKey = await AiService().getApiKey();
      final modelName = await AiService().getPrimaryTextModelName();
      final model = GenerativeModel(model: modelName, apiKey: apiKey);
      
      final prompt = '''
You are an AI assistant helping to clean up academic/reference PDF filenames.
Analyze the following text from the first page of a PDF document and propose a clean, concise, human-readable title (e.g. "Calculus 101", "Thermodynamics Syllabus", "Linear Algebra").
Do NOT include the file extension. Avoid special characters. Keep it under 50 characters.

Original Filename: ${widget.originalName}

First Page Text Content:
$text

Proposed clean title:
''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      String suggested = response.text?.trim() ?? '';
      
      // Cleanup suggested name
      suggested = suggested.replaceAll('"', '').replaceAll("'", "").trim();
      if (suggested.endsWith('.pdf')) {
        suggested = suggested.substring(0, suggested.length - 4);
      }
      
      if (suggested.isNotEmpty) {
        _nameController.text = suggested;
      }
    } catch (e) {
      debugPrint('AI Suggestion Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('AI Suggestion failed: $e'), backgroundColor: AppTheme.duoRed),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSuggesting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Confirm Document Name',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Confirm or customize the document name before upload:',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _isSuggesting ? null : _getAiSuggestion,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.duoViolet.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.duoViolet.withOpacity(0.3)),
                  ),
                  child: _isSuggesting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppTheme.duoViolet,
                          ),
                        )
                      : const Icon(
                          LucideIcons.sparkles,
                          color: AppTheme.duoViolet,
                          size: 18,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
        ),
        ElevatedButton(
          onPressed: () {
            final name = _nameController.text.trim();
            if (name.isEmpty) return;
            Navigator.pop(context, name.endsWith('.pdf') ? name : '$name.pdf');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.duoGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
