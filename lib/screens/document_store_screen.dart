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
import 'settings_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _checkConfigAndLoad();
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

  Future<void> _pickAndUpload() async {
    if (_isActionLoading) return;

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
      final bytes = await file.readAsBytes();

      setState(() {
        _isActionLoading = true;
        _actionLoadingText = 'Uploading $filename...';
      });

      await B2Service.instance.uploadObject(filename, bytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully uploaded $filename')),
      );

      await _loadFiles();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e'), backgroundColor: AppTheme.duoRed),
      );
    } finally {
      setState(() {
        _isActionLoading = false;
      });
    }
  }

  Future<void> _downloadAndView(B2Object b2Obj) async {
    if (_isActionLoading) return;

    try {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${appDir.path}/b2_cache');
      if (!await cacheDir.exists()) {
        await cacheDir.create(recursive: true);
      }

      final localFile = File('${cacheDir.path}/${b2Obj.key}');

      // If already cached locally, open directly
      if (await localFile.exists()) {
        _openPdfViewer(localFile, b2Obj.key);
        return;
      }

      // Download from B2
      setState(() {
        _isActionLoading = true;
        _actionLoadingText = 'Downloading ${b2Obj.key}...';
      });

      final bytes = await B2Service.instance.downloadObject(b2Obj.key);
      await localFile.writeAsBytes(bytes);

      if (mounted) {
        _openPdfViewer(localFile, b2Obj.key);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e'), backgroundColor: AppTheme.duoRed),
      );
    } finally {
      setState(() {
        _isActionLoading = false;
      });
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
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Delete Document?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to permanently delete "${b2Obj.key}" from Backblaze B2?', style: const TextStyle(color: Colors.white70)),
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
      _actionLoadingText = 'Deleting ${b2Obj.key}...';
    });

    try {
      await B2Service.instance.deleteObject(b2Obj.key);

      // Clean local cache if exists
      final appDir = await getApplicationDocumentsDirectory();
      final localFile = File('${appDir.path}/b2_cache/${b2Obj.key}');
      if (await localFile.exists()) {
        await localFile.delete();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully deleted ${b2Obj.key}')),
      );

      await _loadFiles();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete failed: $e'), backgroundColor: AppTheme.duoRed),
      );
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
      body: Stack(
        children: [
          SafeArea(
            child: ResponsiveCenter(
              maxWidth: ResponsiveMaxWidth.content,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Area
                    _buildHeader(),
                    const SizedBox(height: 24),

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
                    ? 'Upload and download PDF references from Backblaze B2'
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

    if (_files.isEmpty) {
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
              child: const Icon(LucideIcons.folderClosed, size: 64, color: Colors.white24),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Documents Uploaded',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Upload your first PDF document to the cloud store.',
              style: TextStyle(color: Colors.white54, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            DuoButton(
              text: 'Upload PDF',
              onPressed: _pickAndUpload,
              color: AppTheme.duoGreen,
              shadowColor: AppTheme.duoGreenDark,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Quick Action Upload Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.duoViolet.withOpacity(0.15), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.duoViolet.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              const Icon(LucideIcons.cloudLightning, color: AppTheme.duoViolet, size: 32),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Store PDF Reference Chunks',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Access your uploaded references from any device.',
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: _pickAndUpload,
                icon: const Icon(LucideIcons.upload, size: 16),
                label: const Text('UPLOAD', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.duoGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
              ),
            ],
          ),
        ),

        // File List
        Expanded(
          child: ListView.separated(
            itemCount: _files.length,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final file = _files[index];
              return _buildFileItem(file);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFileItem(B2Object file) {
    final formattedDate = file.lastModifiedDate != null
        ? '${file.lastModifiedDate!.month}/${file.lastModifiedDate!.day}/${file.lastModifiedDate!.year}'
        : 'Unknown';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(LucideIcons.fileText, color: Colors.redAccent, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.key,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      file.sizeFormatted,
                      style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle)),
                    const SizedBox(width: 12),
                    Text(
                      formattedDate,
                      style: const TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(LucideIcons.eye, color: AppTheme.duoBlue, size: 20),
                tooltip: 'Open & View',
                onPressed: () => _downloadAndView(file),
              ),
              IconButton(
                icon: const Icon(LucideIcons.trash2, color: AppTheme.duoRed, size: 20),
                tooltip: 'Delete',
                onPressed: () => _deleteFile(file),
              ),
            ],
          ),
        ],
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
            tooltip: 'Share Document',
            onPressed: () {
              Share.shareXFiles([XFile(file.path)], text: filename);
            },
          ),
        ],
      ),
      body: SafePdfViewer(file: file),
    );
  }
}
