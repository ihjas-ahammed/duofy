import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

class CommunityBookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onGetPressed;

  const CommunityBookCard({
    super.key,
    required this.book,
    required this.onGetPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.duoOrange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(LucideIcons.globe2, color: AppTheme.duoOrange, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'By ${book.authorName ?? 'Community'}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.white54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onGetPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.duoBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text('GET', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.w900)),
            ),
          )
        ],
      ),
    );
  }
}