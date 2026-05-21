import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import 'duo_button.dart';
import 'psychological_progress_bar.dart';

/// Inline unit header used by LessonPath.
/// Mirrors the React glass-panel: black/60 rounded-3xl centered.
class UnitHeader extends StatelessWidget {
  final Unit unit;
  final bool isGenerated;
  final UnitGenTask? generationTask;
  final VoidCallback onGenerate;
  final VoidCallback onClear;

  const UnitHeader({
    super.key,
    required this.unit,
    required this.isGenerated,
    required this.generationTask,
    required this.onGenerate,
    required this.onClear,
  });

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
                          : PsychologicalProgressBar(
                              estimatedDuration: generationTask!.estimatedDuration,
                              startTime: generationTask!.startTime,
                              isCircular: true,
                              label: status ?? 'Loading...',
                            ))
                      : SizedBox(
                          width: double.infinity,
                          child: DuoButton(
                            text: 'Generate Unit',
                            color: AppTheme.duoViolet,
                            shadowColor: AppTheme.duoVioletDark,
                            onPressed: onGenerate,
                          ),
                        ),
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
