import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import '../screens/source_pdf_upload_screen.dart';
import 'duo_button.dart';
import 'real_progress_bar.dart';

/// Inline unit header used by LessonPath.
/// Mirrors the React glass-panel: black/60 rounded-3xl centered.
class UnitHeader extends StatelessWidget {
  final Unit unit;
  final bool isGenerated;
  final UnitGenTask? generationTask;
  final VoidCallback onGenerate;
  final VoidCallback onClear;
  /// Path on disk to the PDF chunk that backs this unit. In the old flow it
  /// lives on the unit (`unit.pdfPath`); in the new flow the section owns
  /// the chunk for the whole section. The caller picks whichever it has so
  /// the "View reference" affordance always opens the right pages. Null when
  /// the file is missing (e.g. user hasn't restored sources yet).
  final String? referencePdfPath;
  final String? syllabusPdfPath;
  final Book? book;

  const UnitHeader({
    super.key,
    required this.unit,
    required this.isGenerated,
    required this.generationTask,
    required this.onGenerate,
    required this.onClear,
    this.referencePdfPath,
    this.syllabusPdfPath,
    this.book,
  });

  bool get _isReferencePdfMissing {
    if (kIsWeb) return true;
    final p = referencePdfPath;
    if (p == null || p.isEmpty) return true;
    return !File(p).existsSync();
  }

  bool get _canViewSyllabus {
    if (kIsWeb) return false;
    final p = syllabusPdfPath;
    if (p == null || p.isEmpty) return false;
    return File(p).existsSync();
  }

  void _openReference(BuildContext context) {
    if (kIsWeb) return;
    final p = referencePdfPath;
    if (p == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text(unit.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            backgroundColor: const Color(0xFF0B0F19),
          ),
          body: SfPdfViewer.file(File(p)),
        ),
      ),
    );
  }

  void _showMissingPdfDialog(BuildContext context) {
    if (book == null) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Row(
          children: [
            Icon(LucideIcons.fileWarning, color: AppTheme.duoOrange, size: 28),
            SizedBox(width: 12),
            Text(
              'Missing Reference PDF',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: const Text(
          'The source PDF file for this unit is missing on this device. Would you like to select and restore the source PDF(s) to view it?',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SourcePdfUploadScreen(book: book!),
                ),
              );
            },
            child: const Text(
              'Restore PDF(s)',
              style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _openSyllabus(BuildContext context) {
    if (kIsWeb) return;
    final p = syllabusPdfPath;
    if (p == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text('${unit.title} - Syllabus', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          body: SfPdfViewer.file(File(p)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("UNIT TITLE: '${unit.title}', DESC: '${unit.description}', IS_GENERATED: $isGenerated");
    final bool isError = generationTask?.isError ?? false;
    final String? status = generationTask?.status;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, 8)),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  unit.title.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  unit.description.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: Color(0xFF94A3B8),
                    letterSpacing: 1.4,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Dedicated place for PDF / Syllabus buttons since it's the same for all sections/lessons
                if (book != null || _canViewSyllabus) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (book != null)
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (_isReferencePdfMissing) {
                                _showMissingPdfDialog(context);
                              } else {
                                _openReference(context);
                              }
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: (_isReferencePdfMissing ? AppTheme.duoOrange : AppTheme.duoBlue).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: (_isReferencePdfMissing ? AppTheme.duoOrange : AppTheme.duoBlue).withOpacity(0.35)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _isReferencePdfMissing ? LucideIcons.fileWarning : LucideIcons.fileText,
                                    size: 14,
                                    color: _isReferencePdfMissing ? AppTheme.duoOrange : AppTheme.duoBlue,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    _isReferencePdfMissing ? 'MISSING PDF' : 'VIEW REFERENCE PDF',
                                    style: TextStyle(
                                      color: _isReferencePdfMissing ? AppTheme.duoOrange : AppTheme.duoBlue,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (book != null && _canViewSyllabus) const SizedBox(width: 8),
                      if (_canViewSyllabus)
                        Expanded(
                          child: InkWell(
                            onTap: () => _openSyllabus(context),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: AppTheme.duoGreen.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppTheme.duoGreen.withOpacity(0.35)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(LucideIcons.scroll, size: 14, color: AppTheme.duoGreen),
                                  SizedBox(width: 6),
                                  Text(
                                    'VIEW SYLLABUS',
                                    style: TextStyle(
                                      color: AppTheme.duoGreen,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
                
                if (!isGenerated)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: generationTask != null
                        ? (isError
                            ? Column(
                                children: [
                                  Text(
                                    status ?? 'Unknown Error',
                                    style: const TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold, fontSize: 10),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: DuoButton(
                                      text: 'Retry Generation',
                                      color: AppTheme.duoOrange,
                                      shadowColor: AppTheme.duoOrangeDark,
                                      onPressed: () {
                                        GenerationManager.instance.clearUnitError(unit.id);
                                        onGenerate();
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : RealProgressBar(
                                progress: generationTask!.progress,
                                isCircular: false,
                                label: status ?? 'Loading...',
                              ))
                        : (unit.lessons.isNotEmpty
                            // Generation was interrupted (app killed / closed
                            // mid-run): some lessons were saved but the unit was
                            // never marked complete. Offer to pick up where it
                            // left off rather than silently restarting.
                            ? Column(
                                children: [
                                  Text(
                                    'Generation was interrupted — ${unit.lessons.length} lesson${unit.lessons.length == 1 ? '' : 's'} saved.',
                                    style: const TextStyle(color: AppTheme.duoOrange, fontWeight: FontWeight.bold, fontSize: 10),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: DuoButton(
                                      text: 'Resume Generation',
                                      color: AppTheme.duoViolet,
                                      shadowColor: AppTheme.duoVioletDark,
                                      onPressed: onGenerate,
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: DuoButton(
                                  text: 'Generate Unit',
                                  color: AppTheme.duoViolet,
                                  shadowColor: AppTheme.duoVioletDark,
                                  onPressed: onGenerate,
                                ),
                              )),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GestureDetector(
                      onTap: onClear,
                      behavior: HitTestBehavior.opaque,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.refreshCcw, size: 12, color: AppTheme.duoOrange),
                          SizedBox(width: 4),
                          Text(
                            'Delete Unit',
                            style: TextStyle(color: AppTheme.duoOrange, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
