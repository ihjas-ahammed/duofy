import '../platform/io_shim.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../models/app_models.dart';
import '../services/generation_manager.dart';
import '../services/mapping_verifier.dart';
import '../theme/app_theme.dart';

/// "Repair page alignment" flow: pick the original source PDF(s), run the
/// deterministic [MappingVerifier] over the book's current page ranges, then
/// offer the detected global shift (or a manual one) and re-split in the
/// background, preserving generated lessons.
Future<void> showRepairAlignmentFlow(BuildContext context, Book book) async {
  final messenger = ScaffoldMessenger.of(context);
  if (kIsWeb) {
    messenger.showSnackBar(
      const SnackBar(content: Text('Page repair is not available on web yet.')),
    );
    return;
  }

  final picked = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    allowMultiple: true,
    dialogTitle: 'Select the original source PDF(s) of this course',
  );
  if (picked == null || picked.files.isEmpty) return;
  final files = [
    for (final f in picked.files)
      if (f.path != null) File(f.path!),
  ];
  if (files.isEmpty || !context.mounted) return;

  final status = ValueNotifier<String>('Checking page alignment…');
  MappingReport? report;
  Object? error;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      backgroundColor: context.colors.surface,
      content: Row(
        children: [
          const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: status,
              builder: (_, s, _) => Text(
                s,
                style: TextStyle(
                  color: context.colors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  try {
    report = await GenerationManager.instance.checkPageAlignment(
      book,
      files,
      onStatus: (s) => status.value = s,
    );
  } catch (e) {
    error = e;
  }
  if (!context.mounted) return;
  Navigator.of(context, rootNavigator: true).pop();

  if (error != null || report == null) {
    messenger.showSnackBar(
      SnackBar(content: Text('Alignment check failed: $error')),
    );
    return;
  }
  final r = report;

  String headline;
  IconData icon;
  Color color;
  if (r.pass && r.readable > 0) {
    headline =
        'Pages line up (${r.matched}/${r.readable} sampled sections matched). '
        'You can still apply a manual shift below.';
    icon = LucideIcons.checkCircle2;
    color = AppTheme.duoGreen;
  } else if (r.readable == 0) {
    headline =
        'This PDF has no extractable text (scanned book?), so alignment '
        'cannot be checked automatically. Apply a manual shift if pages are off.';
    icon = LucideIcons.scanLine;
    color = AppTheme.duoBlue;
  } else if (r.suggestedShift != null) {
    final n = r.suggestedShift!;
    headline =
        'Section headings were found ${n.abs()} page${n.abs() == 1 ? '' : 's'} '
        '${n > 0 ? 'after' : 'before'} where they are mapped. '
        'Applying the shift below should fix the whole book.';
    icon = LucideIcons.alertTriangle;
    color = AppTheme.duoOrange;
  } else {
    headline =
        '${r.mismatched} of ${r.readable} sampled sections did not match and '
        'no single shift explains it. Try "Edit Course Structure" to fix ranges '
        'individually.';
    icon = LucideIcons.alertTriangle;
    color = AppTheme.duoRed;
  }

  int delta = r.suggestedShift ?? 0;
  await showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setDialogState) => AlertDialog(
        backgroundColor: context.colors.surface,
        title: Text(
          'Page Alignment',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    headline,
                    style: TextStyle(
                      color: context.colors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    LucideIcons.minusCircle,
                    color: AppTheme.duoRed,
                  ),
                  onPressed: () => setDialogState(() => delta--),
                ),
                Container(
                  width: 84,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceAlt,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${delta > 0 ? '+' : ''}$delta pg',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    LucideIcons.plusCircle,
                    color: AppTheme.duoGreen,
                  ),
                  onPressed: () => setDialogState(() => delta++),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Shifting moves every mapped page range of the book and re-splits the PDFs. Generated lessons are kept.',
              style: TextStyle(color: context.colors.textFaint, fontSize: 11),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Close',
              style: TextStyle(color: context.colors.textFaint),
            ),
          ),
          TextButton(
            onPressed: delta == 0
                ? null
                : () {
                    Navigator.of(ctx).pop();
                    GenerationManager.instance.repairPageAlignment(
                      book,
                      files,
                      delta,
                    );
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Shifting pages by ${delta > 0 ? '+' : ''}$delta and re-splitting in the background…',
                        ),
                      ),
                    );
                  },
            child: Text(
              'Apply Shift & Re-split',
              style: TextStyle(
                color: delta == 0
                    ? context.colors.textFaint
                    : AppTheme.duoGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
