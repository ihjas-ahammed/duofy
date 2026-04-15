import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';

class FileSelectionList extends StatelessWidget {
  final List<File> files;
  final VoidCallback onAddMore;
  final Function(int) onRemove;

  const FileSelectionList({
    super.key,
    required this.files,
    required this.onAddMore,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${files.length} File(s) Selected', 
                  style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white)
                ),
                GestureDetector(
                  onTap: onAddMore,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.duoBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(LucideIcons.plus, size: 14, color: AppTheme.duoBlue),
                        SizedBox(width: 4),
                        Text('Add', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          
          if (files.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'No files added yet.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: files.length,
              separatorBuilder: (_, _) => const Divider(height: 1, color: Colors.white12),
              itemBuilder: (context, index) {
                final file = files[index];
                final isPdf = file.path.toLowerCase().endsWith('.pdf');
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Icon(
                    isPdf ? LucideIcons.fileText : LucideIcons.image,
                    color: isPdf ? AppTheme.duoViolet : AppTheme.duoOrange,
                  ),
                  title: Text(
                    file.path.split('/').last,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(LucideIcons.trash2, size: 18, color: AppTheme.duoRed),
                    onPressed: () => onRemove(index),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}