import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/error_capture_service.dart';
import '../theme/app_theme.dart';

class GlobalErrorCaptureLayer extends StatefulWidget {
  final Widget child;

  const GlobalErrorCaptureLayer({
    super.key,
    required this.child,
  });

  @override
  State<GlobalErrorCaptureLayer> createState() => _GlobalErrorCaptureLayerState();
}

class _GlobalErrorCaptureLayerState extends State<GlobalErrorCaptureLayer> {
  final Set<String> _expandedErrorIds = {};

  @override
  Widget build(BuildContext context) {
    // Never show developer error banners/snackbars in release builds
    if (kReleaseMode) {
      return widget.child;
    }

    return ValueListenableBuilder<List<CapturedError>>(
      valueListenable: ErrorCaptureService.instance.errorsNotifier,
      builder: (context, errors, _) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              widget.child,
              if (errors.isNotEmpty)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Material(
                      type: MaterialType.transparency,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: errors.map((err) => _buildErrorBanner(context, err)).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorBanner(BuildContext context, CapturedError error) {
    final isExpanded = _expandedErrorIds.contains(error.id);
    final isGenerationError = error.category.toLowerCase().contains('generation');

    final categoryColor = isGenerationError ? AppTheme.duoOrange : AppTheme.duoRed;

    return Dismissible(
      key: ValueKey(error.id),
      direction: DismissDirection.horizontal,
      onDismissed: (_) {
        ErrorCaptureService.instance.dismissError(error.id);
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: categoryColor.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(LucideIcons.trash2, color: categoryColor, size: 22),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: categoryColor.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(LucideIcons.trash2, color: categoryColor, size: 22),
      ),
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          // Allow swiping up to dismiss
          if (details.primaryVelocity != null && details.primaryVelocity! < -120) {
            ErrorCaptureService.instance.dismissError(error.id);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: categoryColor.withValues(alpha: 0.6), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: categoryColor.withValues(alpha: 0.12),
              child: Row(
                children: [
                  Icon(
                    isGenerationError ? LucideIcons.sparkles : LucideIcons.alertTriangle,
                    color: categoryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: categoryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                error.category.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            if (error.processName != null && error.processName!.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  error.processName!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: context.colors.textPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          error.errorString,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: context.colors.textPrimary,
                          ),
                          maxLines: isExpanded ? 6 : 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                      size: 18,
                      color: context.colors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isExpanded) {
                          _expandedErrorIds.remove(error.id);
                        } else {
                          _expandedErrorIds.add(error.id);
                        }
                      });
                    },
                    tooltip: 'Toggle Details',
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.x, size: 18, color: AppTheme.duoRed),
                    onPressed: () {
                      ErrorCaptureService.instance.dismissError(error.id);
                    },
                    tooltip: 'Dismiss Error',
                  ),
                ],
              ),
            ),
            if (isExpanded)
              Container(
                padding: const EdgeInsets.all(14),
                color: context.colors.surfaceAlt,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (error.stackTrace != null) ...[
                      Text(
                        'STACK TRACE:',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: context.colors.textFaint,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 140),
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SingleChildScrollView(
                          child: SelectableText(
                            error.stackTrace.toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: AppTheme.duoRed,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: '${error.category}: ${error.errorString}\n\n${error.stackTrace}'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error log copied to clipboard!')),
                            );
                          },
                          icon: const Icon(LucideIcons.copy, size: 14),
                          label: const Text('Copy Details', style: TextStyle(fontSize: 12)),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.duoBlue,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            ErrorCaptureService.instance.dismissError(error.id);
                          },
                          icon: const Icon(LucideIcons.check, size: 14, color: Colors.white),
                          label: const Text('Dismiss & Continue', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ),
  ),
);
  }
}
