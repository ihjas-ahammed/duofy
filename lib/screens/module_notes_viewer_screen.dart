import 'dart:convert';
import '../platform/io_shim.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/platform_webview.dart';
import '../services/module_notes_service.dart';

class ModuleNotesViewerScreen extends StatefulWidget {
  final Book book;
  final Module module;
  final int moduleIndex;
  final String? pdfPath;
  final VoidCallback? onRegenerateRequested;

  const ModuleNotesViewerScreen({
    super.key,
    required this.book,
    required this.module,
    required this.moduleIndex,
    this.pdfPath,
    this.onRegenerateRequested,
  });

  @override
  State<ModuleNotesViewerScreen> createState() => _ModuleNotesViewerScreenState();
}

class _ModuleNotesViewerScreenState extends State<ModuleNotesViewerScreen> {
  String? _htmlContent;
  bool _isLoadingHtml = true;
  bool _isGeneratingPdf = false;

  @override
  void initState() {
    super.initState();
    _loadHtmlNotes();
  }

  Future<void> _loadHtmlNotes() async {
    final htmlPath = await ModuleNotesService.instance.getNotesHtmlPath(widget.book.id, widget.module.id);
    if (htmlPath != null && File(htmlPath).existsSync()) {
      try {
        final content = await File(htmlPath).readAsString();
        if (mounted) {
          setState(() {
            _htmlContent = content;
            _isLoadingHtml = false;
          });
        }
        return;
      } catch (e) {
        print('[ModuleNotesViewerScreen] Error loading HTML note: $e');
      }
    }
    
    if (mounted) {
      setState(() {
        _isLoadingHtml = false;
      });
    }
  }

  void _onJsMessage(String message) async {
    try {
      final data = jsonDecode(message);
      if (data is Map && data['type'] == 'mathjax_ready' && data['html'] != null) {
        final renderedHtml = data['html'].toString();
        print('[ModuleNotesViewerScreen] MathJax typesetting complete! Saving rendered SVG HTML...');
        await ModuleNotesService.instance.saveRenderedHtml(widget.book.id, widget.module.id, renderedHtml);
      }
    } catch (_) {}
  }

  /// Opens the HTML study note directly in Chrome or the default external web browser.
  Future<void> _openInExternalBrowser() async {
    final htmlPath = await ModuleNotesService.instance.getNotesHtmlPath(widget.book.id, widget.module.id);
    if (htmlPath != null && File(htmlPath).existsSync()) {
      try {
        final uri = Uri.file(htmlPath);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          return;
        }
      } catch (e) {
        print('[ModuleNotesViewerScreen] url_launcher failed, falling back to OpenFilex: $e');
      }
      OpenFilex.open(htmlPath);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('HTML notes file not found.')),
      );
    }
  }

  /// Print Web View to A4 PDF (using Chrome on Desktop or Native A4 PDF builder on Android/Mobile) and share via system share sheet.
  Future<void> _printAndSharePdf() async {
    if (_isGeneratingPdf) return;
    setState(() => _isGeneratingPdf = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preparing A4 PDF document...'),
        duration: Duration(seconds: 2),
      ),
    );

    try {
      final pdfPath = await ModuleNotesService.instance.getNotesPdfPath(widget.book.id, widget.module.id);
      if (pdfPath != null && File(pdfPath).existsSync()) {
        await Share.shareXFiles(
          [XFile(pdfPath)],
          text: '${widget.book.title} - Module ${widget.moduleIndex + 1} Notes',
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notes PDF not found. Tap Regenerate to build.')),
        );
      }
    } catch (e) {
      print('[ModuleNotesViewerScreen] Error printing/sharing PDF: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing PDF: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGeneratingPdf = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.surface,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Module ${widget.moduleIndex + 1} Notes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            Text(
              widget.module.title,
              style: TextStyle(
                fontSize: 12,
                color: context.colors.textFaint,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.compass),
            tooltip: 'Open in External Browser (Chrome)',
            onPressed: _openInExternalBrowser,
          ),
          if (_isGeneratingPdf)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.duoBlue),
              ),
            )
          else
            IconButton(
              icon: const Icon(LucideIcons.share2),
              tooltip: 'Print to A4 PDF & Share',
              onPressed: _printAndSharePdf,
            ),
          if (widget.onRegenerateRequested != null)
            IconButton(
              icon: const Icon(LucideIcons.refreshCw),
              tooltip: 'Regenerate Notes',
              onPressed: widget.onRegenerateRequested,
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoadingHtml
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.duoBlue),
            )
          : (_htmlContent != null && _htmlContent!.isNotEmpty
              ? PlatformWebView(
                  html: _htmlContent!,
                  onMessage: _onJsMessage,
                )
              : _buildNoContentFallback()),
    );
  }

  Widget _buildNoContentFallback() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.fileX, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Notes document not found.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap below to quick generate book-like study notes for ${widget.module.title}.',
              textAlign: TextAlign.center,
              style: TextStyle(color: context.colors.textFaint),
            ),
            const SizedBox(height: 20),
            if (widget.onRegenerateRequested != null)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.duoBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(LucideIcons.sparkles, size: 18, color: Colors.white),
                label: const Text(
                  'Quick Generate Notes Now',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: widget.onRegenerateRequested,
              ),
          ],
        ),
      ),
    );
  }
}
