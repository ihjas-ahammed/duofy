import '../platform/io_shim.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';

class FileSelectionList extends StatelessWidget {
  final List<dynamic> files;
  final VoidCallback onAddMore;
  final VoidCallback? onSelectFromStore;
  final Function(int) onRemove;

  const FileSelectionList({
    super.key,
    required this.files,
    required this.onAddMore,
    this.onSelectFromStore,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: context.colors.outline)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${files.length} File(s) Selected',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: context.colors.textPrimary,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onSelectFromStore != null) ...[
                      GestureDetector(
                        onTap: onSelectFromStore,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.duoViolet.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                LucideIcons.cloud,
                                size: 14,
                                color: AppTheme.duoViolet,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Store',
                                style: TextStyle(
                                  color: AppTheme.duoViolet,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    GestureDetector(
                      onTap: onAddMore,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.duoBlue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              LucideIcons.plus,
                              size: 14,
                              color: AppTheme.duoBlue,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Add',
                              style: TextStyle(
                                color: AppTheme.duoBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (files.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'No files added yet.',
                textAlign: TextAlign.center,
                style: TextStyle(color: context.colors.textFaint, fontSize: 13),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: files.length,
              separatorBuilder: (_, _) =>
                  Divider(height: 1, color: context.colors.outline),
              itemBuilder: (context, index) {
                final file = files[index];
                String name = '';
                bool isPdf = false;
                if (file is File) {
                  name = file.path.split('/').last.split('\\').last;
                  isPdf = file.path.toLowerCase().endsWith('.pdf');
                } else if (file is PlatformFile) {
                  name = file.name;
                  isPdf = file.name.toLowerCase().endsWith('.pdf');
                }

                return Material(
                  color: Colors.transparent,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: Icon(
                      isPdf ? LucideIcons.fileText : LucideIcons.image,
                      color: isPdf ? AppTheme.duoViolet : AppTheme.duoOrange,
                    ),
                    title: Text(
                      name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        LucideIcons.trash2,
                        size: 18,
                        color: AppTheme.duoRed,
                      ),
                      onPressed: () => onRemove(index),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
