import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:file_picker/file_picker.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/generation_manager.dart';

class MissingFilesBanner extends StatelessWidget {
  final Book book;

  const MissingFilesBanner({super.key, required this.book});

  Future<void> _restoreFiles(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
      allowMultiple: true,
    );

    if (result != null && result.paths.isNotEmpty) {
      final files = result.paths.where((p) => p != null).map((p) => File(p!)).toList();
      GenerationManager.instance.restoreBookFiles(book, files);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restoring files natively in background...'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.duoOrange.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.duoOrange.withOpacity(0.5), width: 2),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.fileWarning, color: AppTheme.duoOrange, size: 28),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Missing Source Files',
                  style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.duoOrange, fontSize: 13),
                ),
                Text(
                  'Upload original files to restore generation capabilities across devices.',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _restoreFiles(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.duoOrange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Restore', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }
}