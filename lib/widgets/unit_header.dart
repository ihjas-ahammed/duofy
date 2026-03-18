import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';
import 'duo_button.dart';
import 'psychological_progress_bar.dart';

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
    bool isError = generationTask?.isError ?? false;
    String? status = generationTask?.status;

    return AppTheme.applyGlassBlur(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            Text(
              unit.title.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.white, letterSpacing: 1.2),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              unit.description,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white54),
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
                          )
                      )
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onClear,
                      child: Row(
                        children: [
                          const Icon(LucideIcons.refreshCcw, size: 12, color: AppTheme.duoOrange),
                          const SizedBox(width: 4),
                          const Text('Delete Unit', style: TextStyle(color: AppTheme.duoOrange, fontSize: 10, fontWeight: FontWeight.bold)),
                        ]
                      )
                    )
                  ]
                )
              )
          ],
        ),
      ),
    );
  }
}