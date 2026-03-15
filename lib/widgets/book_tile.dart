import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final double progress;
  final VoidCallback onTap;

  const BookTile({
    super.key,
    required this.book,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12, width: 2), 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.duoBlue,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:[
                      BoxShadow(
                        color: AppTheme.duoBlue.withOpacity(0.5),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      )
                    ]
                  ),
                  child: const Icon(LucideIcons.book, size: 28, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white10,
                color: AppTheme.duoGreen,
                borderRadius: BorderRadius.circular(4),
                minHeight: 4,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}