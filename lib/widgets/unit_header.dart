import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
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

  const UnitHeader({
    super.key,
    required this.unit,
    required this.isGenerated,
    required this.generationTask,
    required this.onGenerate,
    required this.onClear,
    this.referencePdfPath,
  });

  bool get _canViewReference {
    final p = referencePdfPath;
    if (p == null || p.isEmpty) return false;
    return File(p).existsSync();
  }

  void _openReference(BuildContext context) {
    final p = referencePdfPath;
    if (p == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(unit.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          body: SfPdfViewer.file(File(p)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isError = generationTask?.isError ?? false;
    final String? status = generationTask?.status;

    return ClipRRect(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
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
                  ),
                  if (_canViewReference)
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: InkWell(
                        onTap: () => _openReference(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.duoBlue.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppTheme.duoBlue.withOpacity(0.45)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(LucideIcons.fileText, size: 11, color: AppTheme.duoBlue),
                              SizedBox(width: 4),
                              Text(
                                'PDF',
                                style: TextStyle(color: AppTheme.duoBlue, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
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
                              isCircular: true,
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
    );
  }
}
