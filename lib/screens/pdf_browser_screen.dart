import '../platform/io_shim.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/database_service.dart';
import '../widgets/responsive_center.dart';
import 'pdf_folder_screen.dart';

class PdfFolderMeta {
  final Directory dir;
  final String folderId;
  final Book? linkedBook;
  final int fileCount;
  final double sizeMb;

  PdfFolderMeta({
    required this.dir,
    required this.folderId,
    this.linkedBook,
    required this.fileCount,
    required this.sizeMb,
  });
}

class PdfBrowserScreen extends StatefulWidget {
  const PdfBrowserScreen({super.key});

  @override
  State<PdfBrowserScreen> createState() => _PdfBrowserScreenState();
}

class _PdfBrowserScreenState extends State<PdfBrowserScreen> {
  List<PdfFolderMeta> _folders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFolders();
  }

  Future<void> _loadFolders() async {
    try {
      // Pull dynamic namespace-aware books directly from the DatabaseService
      final List<Book> books = await DatabaseService().fetchBooks(
        forceRefresh: false,
      );

      final appDir = await getApplicationDocumentsDirectory();
      final booksDir = Directory('${appDir.path}/books');

      List<PdfFolderMeta> loadedList = [];

      if (await booksDir.exists()) {
        final List<FileSystemEntity> entities = await booksDir.list().toList();
        final directories = entities.whereType<Directory>().toList();

        for (var dir in directories) {
          final folderId = dir.path.split('/').last;

          Book? linkedBook;
          try {
            linkedBook = books.firstWhere((b) => b.id == folderId);
          } catch (_) {
            linkedBook = null;
          }

          final files = await dir
              .list(recursive: true)
              .where((f) => f is File && f.path.endsWith('.pdf'))
              .toList();
          final int count = files.length;

          double totalSize = 0;
          for (var f in files) {
            totalSize += (f as File).lengthSync();
          }
          final sizeMb = totalSize / (1024 * 1024);

          // Auto-cleanup completely empty orphan folders
          if (count == 0 && linkedBook == null) {
            await dir.delete(recursive: true);
            continue;
          }

          loadedList.add(
            PdfFolderMeta(
              dir: dir,
              folderId: folderId,
              linkedBook: linkedBook,
              fileCount: count,
              sizeMb: sizeMb,
            ),
          );
        }
      }

      if (mounted) {
        setState(() {
          _folders = loadedList;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _deleteFolder(PdfFolderMeta meta) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Delete Folder?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.colors.textPrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to delete ${meta.linkedBook?.title ?? 'this orphan folder'} and all its downloaded PDFs?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              setState(() => _isLoading = true);
              await meta.dir.delete(recursive: true);
              _loadFolders();
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: AppTheme.duoRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openFolder(PdfFolderMeta meta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PdfFolderScreen(
          directory: meta.dir,
          linkedBook: meta.linkedBook,
          folderId: meta.folderId,
        ),
      ),
    ).then(
      (_) => _loadFolders(),
    ); // Refresh on return in case files were deleted
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'File Manager',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ResponsiveCenter(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.duoBlue),
              )
            : _folders.isEmpty
            ? Center(
                child: Text(
                  'No downloaded course folders found.',
                  style: TextStyle(color: context.colors.textFaint),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _folders.length,
                itemBuilder: (context, index) {
                  final meta = _folders[index];
                  final isOrphan = meta.linkedBook == null;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: AppTheme.glassOf(context).copyWith(
                      border: Border.all(
                        color: isOrphan
                            ? AppTheme.duoOrange.withValues(alpha: 0.4)
                            : context.colors.outline,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        onTap: () => _openFolder(meta),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isOrphan
                                ? AppTheme.duoOrange.withValues(alpha: 0.2)
                                : AppTheme.duoBlue.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isOrphan
                                ? LucideIcons.folderClosed
                                : LucideIcons.folder,
                            color: isOrphan
                                ? AppTheme.duoOrange
                                : AppTheme.duoBlue,
                            size: 24,
                          ),
                        ),
                        title: Text(
                          meta.linkedBook?.title ?? 'Unlinked Course',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: isOrphan
                                ? AppTheme.duoOrange
                                : context.colors.textPrimary,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meta.folderId,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: context.colors.textFaint,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '${meta.fileCount} items',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.colors.textSecondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    '${meta.sizeMb.toStringAsFixed(2)} MB',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.colors.textFaint,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            LucideIcons.trash2,
                            color: AppTheme.duoRed,
                            size: 20,
                          ),
                          onPressed: () => _deleteFolder(meta),
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