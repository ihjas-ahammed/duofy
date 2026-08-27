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
  final void Function(String level, String? userRegenReason)? onRegenerateWithSettings;
  final VoidCallback? onRegenerateRequested;
  final VoidCallback? onNotesDeleted;

  const ModuleNotesViewerScreen({
    super.key,
    required this.book,
    required this.module,
    required this.moduleIndex,
    this.pdfPath,
    this.onRegenerateWithSettings,
    this.onRegenerateRequested,
    this.onNotesDeleted,
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
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('HTML notes file not found.')),
      );
    }
  }

  /// Print Web View to A4 PDF and share via system share sheet.
  Future<void> _printAndSharePdf() async {
    if (_isGeneratingPdf) return;
    setState(() => _isGeneratingPdf = true);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preparing A4 PDF document...'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    try {
      final pdfPath = await ModuleNotesService.instance.getNotesPdfPath(widget.book.id, widget.module.id);
      if (pdfPath != null && File(pdfPath).existsSync()) {
        await Share.shareXFiles(
          [XFile(pdfPath)],
          text: '${widget.book.title} - Module ${widget.moduleIndex + 1} Notes',
        );
      } else if (mounted) {
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

  /// Shows regeneration dialog to configure note depth (Min to Max) and custom notes focus/changes.
  void _promptRegenerate() {
    double depthSliderValue = 3.0; // Defaults to High
    final reasonCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) {
          final int depthIdx = depthSliderValue.round().clamp(0, ModuleNotesService.availableDepths.length - 1);
          final String selectedDepth = ModuleNotesService.availableDepths[depthIdx];

          return AlertDialog(
            backgroundColor: context.colors.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                const Icon(LucideIcons.refreshCw, color: AppTheme.duoBlue, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Regenerate Module Notes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NOTE DEPTH',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          color: context.colors.textFaint,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.duoBlue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.duoBlue.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          selectedDepth,
                          style: const TextStyle(
                            color: AppTheme.duoBlue,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: AppTheme.duoBlue,
                      thumbColor: AppTheme.duoBlue,
                      inactiveTrackColor: context.colors.outline,
                      overlayColor: AppTheme.duoBlue.withValues(alpha: 0.2),
                    ),
                    child: Slider(
                      value: depthSliderValue,
                      min: 0,
                      max: (ModuleNotesService.availableDepths.length - 1).toDouble(),
                      divisions: ModuleNotesService.availableDepths.length - 1,
                      onChanged: (val) {
                        setDialogState(() {
                          depthSliderValue = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ModuleNotesService.depthShortLabels.map((lbl) {
                        return Text(
                          lbl,
                          style: TextStyle(
                            color: context.colors.textFaint,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Custom improvements or focus (optional):',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: context.colors.textPrimary),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: reasonCtrl,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'e.g. Follow syllabus strictly, emphasize core concepts, add more practical examples/case studies...',
                      hintStyle: TextStyle(fontSize: 12, color: context.colors.textFaint.withValues(alpha: 0.6)),
                      filled: true,
                      fillColor: context.colors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: context.colors.outline),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Cancel', style: TextStyle(color: context.colors.textFaint)),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.duoBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(LucideIcons.sparkles, size: 16, color: Colors.white),
                label: const Text('Regenerate Notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(ctx);
                  final reason = reasonCtrl.text.trim();
                  if (widget.onRegenerateWithSettings != null) {
                    widget.onRegenerateWithSettings!(selectedDepth, reason.isNotEmpty ? reason : null);
                  } else if (widget.onRegenerateRequested != null) {
                    widget.onRegenerateRequested!();
                  } else {
                    ModuleNotesService.instance.startBackgroundNotesGeneration(
                      book: widget.book,
                      module: widget.module,
                      moduleIndex: widget.moduleIndex,
                      depth: selectedDepth,
                      userRegenReason: reason.isNotEmpty ? reason : null,
                    );
                  }
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  /// Shows delete confirmation dialog.
  Future<void> _confirmDeleteNotes() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(LucideIcons.trash2, color: Colors.redAccent, size: 22),
            const SizedBox(width: 8),
            Text(
              'Delete Module Notes?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete the study notes for "${widget.module.title}"? You can regenerate them at any time.',
          style: TextStyle(color: context.colors.textSecondary, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: TextStyle(color: context.colors.textFaint)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ModuleNotesService.instance.deleteNotes(widget.book.id, widget.module.id);
      widget.onNotesDeleted?.call();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Module notes deleted.')),
        );
        Navigator.pop(context, true);
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
          IconButton(
            icon: const Icon(LucideIcons.refreshCw),
            tooltip: 'Regenerate Notes',
            onPressed: _promptRegenerate,
          ),
          IconButton(
            icon: const Icon(LucideIcons.trash2, color: Colors.redAccent),
            tooltip: 'Delete Notes',
            onPressed: _confirmDeleteNotes,
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
              onPressed: _promptRegenerate,
            ),
          ],
        ),
      ),
    );
  }
}
