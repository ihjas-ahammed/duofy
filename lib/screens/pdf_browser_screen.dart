import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

class _PdfMeta {
  final File file;
  final String bookName;
  final String unitName;
  final String sizeKb;

  _PdfMeta(this.file, this.bookName, this.unitName, this.sizeKb);
}

class PdfBrowserScreen extends StatefulWidget {
  const PdfBrowserScreen({super.key});

  @override
  State<PdfBrowserScreen> createState() => _PdfBrowserScreenState();
}

class _PdfBrowserScreenState extends State<PdfBrowserScreen> {
  List<_PdfMeta> _pdfs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdfs();
  }

  Future<void> _loadPdfs() async {
    try {
      // 1. Load Local Cache mappings
      final prefs = await SharedPreferences.getInstance();
      final cachedStr = prefs.getString('cached_books');
      List<Book> books = [];
      if (cachedStr != null) {
        final List decoded = jsonDecode(cachedStr);
        books = decoded.map((e) => Book.fromJson(Map<String, dynamic>.from(e))).toList();
      }

      // 2. Scan physical directory
      final dir = await getApplicationDocumentsDirectory();
      final booksDir = Directory('${dir.path}/books');
      
      List<_PdfMeta> loadedList = [];

      if (await booksDir.exists()) {
        final List<FileSystemEntity> entities = await booksDir.list(recursive: true).toList();
        final files = entities.whereType<File>().where((f) => f.path.endsWith('.pdf')).toList();

        for (var file in files) {
          final parentDirId = file.parent.path.split('/').last;
          final unitIdRaw = file.path.split('/').last.replaceAll('.pdf', '');
          
          String mappedBookName = "Unknown Course ($parentDirId)";
          String mappedUnitName = unitIdRaw;

          // Attempt match
          for (var b in books) {
            if (b.id == parentDirId) {
              mappedBookName = b.title;
              for (var m in b.modules) {
                for (var s in m.sections) {
                  for (var u in s.units) {
                    if (u.id == unitIdRaw) {
                      mappedUnitName = u.title;
                    }
                  }
                }
              }
              break;
            }
          }

          final sizeKb = (file.lengthSync() / 1024).toStringAsFixed(1);
          loadedList.add(_PdfMeta(file, mappedBookName, mappedUnitName, sizeKb));
        }
      }
      
      if (mounted) {
        setState(() {
          _pdfs = loadedList;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading PDFs: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _openPdf(_PdfMeta meta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(meta.unitName, style: const TextStyle(fontSize: 14))),
          body: SfPdfViewer.file(meta.file),
        )
      )
    );
  }

  Future<void> _sharePdf(_PdfMeta meta) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final safeName = "${meta.bookName} - ${meta.unitName}".replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
      final tempFile = File('${tempDir.path}/$safeName.pdf');
      
      await meta.file.copy(tempFile.path);
      await Share.shareXFiles([XFile(tempFile.path)], text: 'Check out this course unit: ${meta.unitName}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error sharing: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Downloaded Units', style: TextStyle(fontWeight: FontWeight.w900))),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.duoBlue))
          : _pdfs.isEmpty
              ? const Center(child: Text('No PDFs found.', style: TextStyle(color: Colors.white54)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _pdfs.length,
                  itemBuilder: (context, index) {
                    final meta = _pdfs[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: AppTheme.glassDecoration,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: AppTheme.duoRed.withOpacity(0.2), shape: BoxShape.circle),
                          child: const Icon(LucideIcons.fileText, color: AppTheme.duoRed, size: 20),
                        ),
                        title: Text(meta.unitName, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.white)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(meta.bookName, style: const TextStyle(fontSize: 11, color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 2),
                              Text('${meta.sizeKb} KB', style: const TextStyle(fontSize: 10, color: Colors.white54)),
                            ],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(LucideIcons.share, color: Colors.white70, size: 20),
                              onPressed: () => _sharePdf(meta),
                            ),
                            IconButton(
                              icon: const Icon(LucideIcons.externalLink, color: AppTheme.duoGreen, size: 20),
                              onPressed: () => _openPdf(meta),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}