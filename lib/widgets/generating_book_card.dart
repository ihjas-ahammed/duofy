import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/generation_manager.dart';
import '../theme/app_theme.dart';
import 'psychological_progress_bar.dart';

class GeneratingBookCard extends StatelessWidget {
  final GenerationTask task;
  final VoidCallback onTap;

  const GeneratingBookCard({
    super.key, 
    required this.task, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppTheme.duoViolet;
    IconData statusIcon = LucideIcons.loader;
    Color iconColor = AppTheme.duoViolet;
    
    if (task.state == BookGenState.error) {
      borderColor = AppTheme.duoRed;
      iconColor = AppTheme.duoRed;
      statusIcon = LucideIcons.alertTriangle;
    } else if (task.state == BookGenState.review) {
      borderColor = AppTheme.duoOrange;
      iconColor = AppTheme.duoOrange;
      statusIcon = LucideIcons.checkCircle2;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: borderColor.withOpacity(0.15),
                border: Border(right: BorderSide(color: borderColor, width: 2)),
              ),
              child: Center(
                child: task.state == BookGenState.extracting || task.state == BookGenState.chunking || task.state == BookGenState.saving
                  ? PsychologicalProgressBar(
                      estimatedDuration: task.estimatedDuration,
                      startTime: task.startTime,
                      isCircular: true,
                    )
                  : Icon(statusIcon, size: 50, color: iconColor),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white, height: 1.2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      task.statusMessage,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 13, 
                        color: task.state == BookGenState.error ? AppTheme.duoRed : Colors.white70
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (task.state == BookGenState.error && task.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          task.errorMessage!,
                          style: const TextStyle(fontSize: 10, color: Colors.white38),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (task.state == BookGenState.review)
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'TAP TO CONTINUE',
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 10, color: AppTheme.duoOrange, letterSpacing: 1.5),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}