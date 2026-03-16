import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/generation_manager.dart';
import '../theme/app_theme.dart';

class GeneratingBookTile extends StatelessWidget {
  final GenerationTask task;

  const GeneratingBookTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: task.isError ? () => GenerationManager.instance.dismissTask(task.id) : null,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: task.isError ? AppTheme.duoRed : AppTheme.duoViolet, width: 2), 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Expanded(
              child: Center(
                child: task.isError
                  ? const Icon(LucideIcons.alertTriangle, size: 32, color: AppTheme.duoRed)
                  : const SizedBox(
                      width: 28, 
                      height: 28, 
                      child: CircularProgressIndicator(color: AppTheme.duoViolet, strokeWidth: 3)
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                task.title,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                task.isError ? 'Tap to dismiss' : task.statusMessage,
                style: TextStyle(
                  fontSize: 9, 
                  color: task.isError ? AppTheme.duoRed : Colors.white54,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}