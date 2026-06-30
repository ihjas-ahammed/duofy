import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import '../services/ai_service.dart';
import '../services/database_service.dart';
import '../models/app_models.dart';

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
  bool _autoFetchBooks = true;
  bool _isScanningSyllabus = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _autoFetchBooks = prefs.getBool('auto_fetch_books') ?? true;
      });
    }
  }

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
      final newFiles = result.paths.where((p) => p != null).map((p) => File(p!)).toList();
      setState(() {
        if (forSyllabus) {
          _syllabusFiles.addAll(newFiles);
        } else {
          _selectedFiles.addAll(newFiles);
        }
      });
      if (forSyllabus) {
        for (final f in newFiles) {
          _scanSyllabusForBooks(f);
        }
      }
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
      if (forSyllabus) {
        _scanSyllabusForBooks(file);
      }
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
      if (forSyllabus) {
        _scanSyllabusForBooks(downloadedFile);
      }
    }
  }

  Future<void> _scanSyllabusForBooks(File file) async {
    if (!_autoFetchBooks) {
      print('[SyllabusScan] Auto-fetch disabled, skipping scan.');
      return;
    }
    print('[SyllabusScan] Starting syllabus scan for file: ${file.path}');
    setState(() {
      _isScanningSyllabus = true;
    });

    try {
      final text = await PdfService().extractTextFromPdf(file);
      if (text.trim().isEmpty) {
        print('[SyllabusScan] PDF text extraction returned empty text.');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Syllabus PDF has no extractable text. Scanned PDFs are not supported for auto-fetching books.'),
            ),
          );
        }
        return;
      }

      print('[SyllabusScan] Extracted ${text.length} characters of text. Invoking AI extraction...');
      final extractedBooks = await AiService().extractSyllabusBooks(text);
      if (extractedBooks == null) {
        print('[SyllabusScan] AI syllabus book extraction returned null.');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to analyze syllabus textbook mentions using AI.'),
            ),
          );
        }
        return;
      }
      
      if (extractedBooks.isEmpty) {
        print('[SyllabusScan] AI found zero textbook mentions in syllabus.');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Syllabus scanned. AI did not identify any textbook or reference book mentions.'),
            ),
          );
        }
        return;
      }

      print('[SyllabusScan] AI identified ${extractedBooks.length} books: $extractedBooks');
      
      final b2 = B2Service.instance;
      List<B2Object> b2Objects = [];
      try {
        if (await b2.isConfigured()) {
          b2Objects = await b2.listObjects();
        }
      } catch (e) {
        print('[SyllabusScan] Error listing B2 objects: $e');
      }

      final globalBooks = await DatabaseService().fetchGlobalBooks(useCacheOnly: false, forceNetwork: true);
      print('[SyllabusScan] Fetched ${globalBooks.length} global books from marketplace.');
      
      if (mounted) {
        // Resolve matches using two-stage matching in parallel
        final futures = extractedBooks.map((extBook) async {
          final title = extBook['title'] ?? '';
          final authors = extBook['authors'] ?? '';
          if (title.isEmpty) return null;

          print('[SyllabusScan] Resolving AI match for title: "$title"');
          
          // 1. Search in B2 objects first
          B2Object? matchedB2Obj;
          for (final obj in b2Objects) {
            final filename = obj.key.split('/').last;
            if (_isSyllabusBookMatch(title, authors, filename, '')) {
              matchedB2Obj = obj;
              break;
            }
          }
          
          // 2. Search in Marketplace if no direct B2 match
          Book? matchedBook;
          if (matchedB2Obj == null) {
            matchedBook = await _matchBookUsingAi(title, authors, globalBooks);
          }

          return {
            'title': title,
            'authors': authors,
            'matchedBook': matchedBook,
            'matchedB2Object': matchedB2Obj,
          };
        });

        final List<Map<String, dynamic>?> results = await Future.wait(futures);
        final List<Map<String, dynamic>> resolvedItems = results.whereType<Map<String, dynamic>>().toList();

        _showSyllabusBooksDialog(resolvedItems);
      }
    } catch (e) {
      print('[SyllabusScan] Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error scanning syllabus: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isScanningSyllabus = false;
        });
      }
    }
  }

  Future<Book?> _matchBookUsingAi(String qTitle, String qAuthors, List<Book> globalBooks) async {
    // 1. Direct offline match first to save API calls
    for (final gb in globalBooks) {
      if (_isSyllabusBookMatch(qTitle, qAuthors, gb.title, gb.authorName ?? '')) {
        return gb;
      }
    }
    
    // 2. Offline match failed, gather candidates using first word of the query title
    final words = qTitle.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), ' ').split(' ').where((w) => w.trim().length > 3).toList();
    if (words.isEmpty) return null;
    
    final firstKeyword = words.first;
    final List<Book> candidates = [];
    for (final gb in globalBooks) {
      if (gb.title.toLowerCase().contains(firstKeyword)) {
        candidates.add(gb);
      }
    }
    
    if (candidates.isEmpty) return null;
    
    // 3. Match using Lite model
    final matchIndex = await AiService().matchSyllabusBookToMarketplace(
      syllabusBookTitle: qTitle,
      syllabusBookAuthors: qAuthors,
      candidateBooks: candidates.map((c) => {'id': c.id, 'title': c.title, 'author': c.authorName ?? ''}).toList(),
    );
    
    if (matchIndex != null && matchIndex >= 0 && matchIndex < candidates.length) {
      return candidates[matchIndex];
    }
    
    return null;
  }

  void _showSyllabusBooksDialog(List<Map<String, dynamic>> itemsList) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              final currentMatchedCount = itemsList.where((item) => item['matchedBook'] != null || item['matchedB2Object'] != null).length;
              
              return Container(
                constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.bookOpen, color: AppTheme.duoGreen, size: 28),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Syllabus Reference Books',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.x, color: Colors.white54, size: 24),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'AI identified the following reference books from your syllabus. Tap "AI Search" to perform a deep semantic search against the Marketplace or B2 Store.',
                      style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        itemCount: itemsList.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = itemsList[index];
                          final title = item['title'] as String;
                          final authors = item['authors'] as String;
                          final Book? matchedBook = item['matchedBook'] as Book?;
                          final B2Object? matchedB2Object = item['matchedB2Object'] as B2Object?;
                          final isAvailable = matchedBook != null || matchedB2Object != null;
                          final isSearching = item['isSearching'] == true;

                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: Row(
                              children: [
                                const Icon(LucideIcons.book, color: Colors.white38, size: 22),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (authors.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          'By $authors',
                                          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                InkWell(
                                  onTap: (isAvailable || isSearching) ? null : () async {
                                    setDialogState(() {
                                      item['isSearching'] = true;
                                    });
                                    
                                    try {
                                      final globalBooks = await DatabaseService().fetchGlobalBooks(useCacheOnly: false, forceNetwork: true);
                                      final searchResult = await _deepSearchBookUsingAiAndB2(title, authors, globalBooks);
                                      if (searchResult != null) {
                                        setDialogState(() {
                                          item['matchedBook'] = searchResult['matchedBook'];
                                          item['matchedB2Object'] = searchResult['matchedB2Object'];
                                        });
                                      } else {
                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('No semantic matches found in Marketplace or B2 Store.'),
                                            ),
                                          );
                                        }
                                      }
                                    } catch (e) {
                                      print('Deep search error: $e');
                                    } finally {
                                      setDialogState(() {
                                        item['isSearching'] = false;
                                      });
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isAvailable
                                          ? AppTheme.duoGreen.withOpacity(0.1)
                                          : isSearching
                                              ? Colors.white.withOpacity(0.02)
                                              : Colors.white.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isAvailable
                                            ? AppTheme.duoGreen.withOpacity(0.3)
                                            : Colors.white10,
                                      ),
                                    ),
                                    child: isSearching
                                        ? const SizedBox(
                                            width: 14,
                                            height: 14,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.duoBlue),
                                            ),
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                isAvailable ? LucideIcons.checkCircle : LucideIcons.search,
                                                color: isAvailable ? AppTheme.duoGreen : Colors.white54,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                isAvailable ? 'Available' : 'AI Search',
                                                style: TextStyle(
                                                  color: isAvailable ? AppTheme.duoGreen : Colors.white70,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (currentMatchedCount > 0)
                      DuoButton(
                        text: 'Auto-fetch $currentMatchedCount Reference Book(s)',
                        color: AppTheme.duoGreen,
                        shadowColor: AppTheme.duoGreenDark,
                        onPressed: () async {
                          final navigator = Navigator.of(ctx);
                          final scaffoldMessenger = ScaffoldMessenger.of(context);
                          
                          // Pre-show a downloading notification
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text('Downloading and adding selected reference books to selection...'),
                              duration: Duration(seconds: 3),
                            ),
                          );

                          for (final item in itemsList) {
                            final Book? mb = item['matchedBook'] as Book?;
                            final B2Object? b2Obj = item['matchedB2Object'] as B2Object?;
                            
                            if (mb != null) {
                              await DatabaseService().saveGeneratedBook(mb);
                              await _downloadAndSelectBookPdf(mb);
                            } else if (b2Obj != null) {
                              await _downloadAndSelectB2ObjectPdf(b2Obj);
                            }
                          }
                          
                          navigator.pop();
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              backgroundColor: AppTheme.duoGreen,
                              content: const Text(
                                'Successfully resolved and added books to selection.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      )
                    else
                      DuoButton(
                        text: 'Close',
                        color: Colors.white10,
                        shadowColor: Colors.black26,
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>?> _deepSearchBookUsingAiAndB2(String qTitle, String qAuthors, List<Book> globalBooks) async {
    // 1. Search B2 first
    final b2 = B2Service.instance;
    if (await b2.isConfigured()) {
      try {
        final b2Objects = await b2.listObjects();
        for (final obj in b2Objects) {
          final filename = obj.key.split('/').last;
          if (_isSyllabusBookMatch(qTitle, qAuthors, filename, '')) {
            return {'matchedB2Object': obj, 'matchedBook': null};
          }
        }
      } catch (e) {
        print('B2 list error: $e');
      }
    }
    
    // 2. Search Marketplace
    final resolvedBook = await _deepSearchBookUsingAi(qTitle, qAuthors, globalBooks);
    if (resolvedBook != null) {
      return {'matchedBook': resolvedBook, 'matchedB2Object': null};
    }
    
    return null;
  }

  Future<Book?> _deepSearchBookUsingAi(String qTitle, String qAuthors, List<Book> globalBooks) async {
    final words = qTitle.toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), ' ')
        .split(' ')
        .where((w) => w.trim().length > 3)
        .toSet();
        
    if (words.isEmpty) return null;
    
    final List<Book> candidates = [];
    for (final gb in globalBooks) {
      final gbTitleLower = gb.title.toLowerCase();
      bool hasWordOverlap = false;
      for (final w in words) {
        if (gbTitleLower.contains(w)) {
          hasWordOverlap = true;
          break;
        }
      }
      if (hasWordOverlap) {
        candidates.add(gb);
      }
    }
    
    if (candidates.isEmpty) return null;
    
    final limitedCandidates = candidates.take(15).toList();
    
    final matchIndex = await AiService().matchSyllabusBookToMarketplace(
      syllabusBookTitle: qTitle,
      syllabusBookAuthors: qAuthors,
      candidateBooks: limitedCandidates.map((c) => {'id': c.id, 'title': c.title, 'author': c.authorName ?? ''}).toList(),
    );
    
    if (matchIndex != null && matchIndex >= 0 && matchIndex < limitedCandidates.length) {
      return limitedCandidates[matchIndex];
    }
    
    return null;
  }

  Future<void> _downloadAndSelectBookPdf(Book mb) async {
    try {
      final b2 = B2Service.instance;
      if (!await b2.isConfigured()) return;
      
      final objects = await b2.listObjects();
      B2Object? matchedObj;
      for (final obj in objects) {
        final filename = obj.key.split('/').last;
        if (_isSyllabusBookMatch(mb.title, mb.authorName ?? '', filename, '')) {
          matchedObj = obj;
          break;
        }
      }
      
      if (matchedObj != null) {
        await _downloadAndSelectB2ObjectPdf(matchedObj);
      } else {
        print('[SyllabusScan] No matching PDF found in B2 for community book: ${mb.title}');
      }
    } catch (e) {
      print('[SyllabusScan] Error auto-selecting B2 PDF: $e');
    }
  }

  Future<void> _downloadAndSelectB2ObjectPdf(B2Object obj) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${appDir.path}/b2_cache');
      final file = File('${cacheDir.path}/${obj.key}');
      
      if (file.existsSync()) {
        setState(() {
          if (!_selectedFiles.any((f) => f.path == file.path)) {
            _selectedFiles.add(file);
          }
        });
      } else {
        final bytes = await B2Service.instance.downloadObject(obj.key);
        if (bytes != null) {
          if (!await file.parent.exists()) {
            await file.parent.create(recursive: true);
          }
          await file.writeAsBytes(bytes);
          setState(() {
            if (!_selectedFiles.any((f) => f.path == file.path)) {
              _selectedFiles.add(file);
            }
          });
        }
      }
    } catch (e) {
      print('[SyllabusScan] Error downloading B2 object PDF: $e');
    }
  }

  bool _isSyllabusBookMatch(String qTitle, String qAuthors, String tTitle, String tAuthors) {
    final qt = qTitle.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), ' ').trim();
    final tt = tTitle.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), ' ').trim();
    
    if (qt.isEmpty || tt.isEmpty) return false;
    
    // 1. Direct containment check
    if (qt.contains(tt) || tt.contains(qt)) {
      return true;
    }
    
    // 2. Fallback to word-overlap ratio
    final qw = qt.split(' ').where((w) => w.trim().length > 3).toSet();
    final tw = tt.split(' ').where((w) => w.trim().length > 3).toSet();
    
    if (qw.isEmpty || tw.isEmpty) return false;
    
    final intersection = qw.intersection(tw);
    final double matchRatio = intersection.length / qw.length;
    final double targetRatio = intersection.length / tw.length;
    return matchRatio >= 0.5 || targetRatio >= 0.5;
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
                      Row(
                        children: [
                          const Text('SYLLABUS (PDF)', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                          const SizedBox(width: 8),
                          if (_isScanningSyllabus)
                            const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppTheme.duoGreen)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FileSelectionList(
                        files: _syllabusFiles,
                        onAddMore: () => _pickFiles(true),
                        onSelectFromStore: () => _selectFromStore(true),
                        onRemove: (idx) => setState(() => _syllabusFiles.removeAt(idx)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _autoFetchBooks,
                              activeColor: AppTheme.duoGreen,
                              onChanged: (val) async {
                                setState(() {
                                  _autoFetchBooks = val ?? true;
                                });
                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setBool('auto_fetch_books', _autoFetchBooks);
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Auto-fetch mentioned reference books from Marketplace',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ),
                        ],
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