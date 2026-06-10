import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/safe_pdf_viewer.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_center.dart';

class PdfFileMeta {
  final File file;
  final String unitId;
  final String unitName;
  final String sizeKb;

  PdfFileMeta({
    required this.file, 
    required this.unitId, 
    required this.unitName, 
    required this.sizeKb
  });
}

class PdfFolderScreen extends StatefulWidget {
  final Directory directory;
  final Book? linkedBook;
  final String folderId;

  const PdfFolderScreen({
    super.key, 
    required this.directory, 
    this.linkedBook, 
    required this.folderId
  });

  @override
  State<PdfFolderScreen> createState() => _PdfFolderScreenState();
}

class _PdfFolderScreenState extends State<PdfFolderScreen> {
  List<PdfFileMeta> _files = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    try {
      if (!await widget.directory.exists()) {
        if (mounted) Navigator.pop(context);
        return;
      }

      final List<FileSystemEntity> entities = await widget.directory.list().toList();
      final pdfs = entities.whereType<File>().where((f) => f.path.endsWith('.pdf')).toList();

      List<PdfFileMeta> loaded = [];

      for (var file in pdfs) {
        final unitIdRaw = file.path.split('/').last.replaceAll('.pdf', '');
        String mappedUnitName = "Unknown Unit ($unitIdRaw)";

        if (widget.linkedBook != null) {
          for (var m in widget.linkedBook!.modules) {
            for (var s in m.sections) {
              for (var u in s.units) {
                if (u.id == unitIdRaw) {
                  mappedUnitName = u.title;
                }
              }
            }
          }
        }

        final sizeKb = (file.lengthSync() / 1024).toStringAsFixed(1);
        loaded.add(PdfFileMeta(
          file: file,
          unitId: unitIdRaw,
          unitName: mappedUnitName,
          sizeKb: sizeKb,
        ));
      }

      if (mounted) {
        setState(() {
          _files = loaded;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _openPdf(PdfFileMeta meta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(meta.unitName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          body: SafePdfViewer(file: meta.file),
        )
      )
    );
  }

  Future<void> _sharePdf(PdfFileMeta meta) async {
    try {
      final safeName = "${widget.linkedBook?.title ?? 'Course'} - ${meta.unitName}".replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
      final tempFile = File('${widget.directory.path}/$safeName.pdf');
      
      await meta.file.copy(tempFile.path);
      await Share.shareXFiles([XFile(tempFile.path)], text: 'Check out this course unit: ${meta.unitName}');
      await tempFile.delete(); // cleanup
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error sharing: $e')));
    }
  }

  void _deleteFile(PdfFileMeta meta) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Delete File?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        content: Text('Are you sure you want to delete the PDF for ${meta.unitName}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              setState(() => _isLoading = true);
              await meta.file.delete();
              _loadFiles();
            }, 
            child: const Text('Delete', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold))
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.linkedBook?.title ?? 'Folder Contents', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
      ),
      body: ResponsiveCenter(
        child: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.duoBlue))
          : _files.isEmpty
              ? const Center(child: Text('This folder is empty.', style: TextStyle(color: Colors.white54)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _files.length,
                  itemBuilder: (context, index) {
                    final meta = _files[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: AppTheme.glassDecoration,
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          onTap: () => _openPdf(meta),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: AppTheme.duoViolet.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(LucideIcons.fileText, color: AppTheme.duoViolet, size: 20),
                          ),
                          title: Text(meta.unitName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('${meta.sizeKb} KB', style: const TextStyle(fontSize: 11, color: Colors.white54)),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(LucideIcons.share, color: Colors.white70, size: 20),
                                onPressed: () => _sharePdf(meta),
                              ),
                              IconButton(
                                icon: const Icon(LucideIcons.trash2, color: AppTheme.duoRed, size: 20),
                                onPressed: () => _deleteFile(meta),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}