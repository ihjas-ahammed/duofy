import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';
import 'slide_action_button.dart';

/// Diagnostic Feedback Bottom Sheet matching docs/new-theme/slide-p/theory.html
class SlideFeedbackSheet extends StatefulWidget {
  final bool isCorrect;
  final String title;
  final String? explanation;
  final String? misconceptionAnalysis;
  final String continueButtonText;
  final VoidCallback onContinue;
  final VoidCallback? onClose;

  const SlideFeedbackSheet({
    super.key,
    this.isCorrect = true,
    this.title = 'Excellent Deduction!',
    this.explanation,
    this.misconceptionAnalysis,
    this.continueButtonText = 'Continue (Enter ↵)',
    required this.onContinue,
    this.onClose,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    bool isCorrect = true,
    String title = 'Excellent Deduction!',
    String? explanation,
    String? misconceptionAnalysis,
    String continueButtonText = 'Continue (Enter ↵)',
    required VoidCallback onContinue,
    VoidCallback? onClose,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (ctx) => SlideFeedbackSheet(
        isCorrect: isCorrect,
        title: title,
        explanation: explanation,
        misconceptionAnalysis: misconceptionAnalysis,
        continueButtonText: continueButtonText,
        onContinue: () {
          Navigator.of(ctx).pop();
          onContinue();
        },
        onClose: () {
          Navigator.of(ctx).pop();
          onClose?.call();
        },
      ),
    );
  }

  @override
  State<SlideFeedbackSheet> createState() => _SlideFeedbackSheetState();
}

class _SlideFeedbackSheetState extends State<SlideFeedbackSheet> {
  bool _isMisconceptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accentColor = widget.isCorrect ? colors.accentGreen : colors.danger;
    final accentLight = widget.isCorrect
        ? colors.accentGreenLight
        : colors.danger.withValues(alpha: 0.15);
    final accentBorder = widget.isCorrect
        ? colors.accentGreenBorder
        : colors.danger.withValues(alpha: 0.35);
    final sheetBg = widget.isCorrect ? colors.sheetBg : (colors.isDark ? const Color(0xFF1F0F12) : const Color(0xFFFEF2F2));
    final sheetBorder = widget.isCorrect ? colors.sheetBorder : colors.danger;

    return Container(
      decoration: BoxDecoration(
        color: sheetBg,
        border: Border(
          top: BorderSide(
            color: sheetBorder,
            width: 2.5,
          ),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 35,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        18,
        10,
        18,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 38,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: colors.isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),

          // Header: Trophy Badge + Title + Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentLight,
                    ),
                    child: Center(
                      child: Icon(
                        widget.isCorrect
                            ? LucideIcons.trophy
                            : LucideIcons.alertTriangle,
                        color: accentColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: accentColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
              if (widget.onClose != null)
                GestureDetector(
                  onTap: widget.onClose,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentLight,
                    ),
                    child: Center(
                      child: Icon(
                        LucideIcons.x,
                        color: accentColor,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Body Text / Causal Explanation
          if (widget.explanation != null && widget.explanation!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MathMarkdown(
                data: widget.explanation!,
                textStyle: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: colors.textMain,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          // Collapsible Misconception Pill
          if (widget.misconceptionAnalysis != null &&
              widget.misconceptionAnalysis!.trim().isNotEmpty) ...[
            GestureDetector(
              onTap: () {
                setState(() {
                  _isMisconceptionExpanded = !_isMisconceptionExpanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: colors.cardBg,
                  border: Border.all(
                    color: accentBorder,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              LucideIcons.helpCircle,
                              color: accentColor,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Why other options fail (Misconception Analysis)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: accentColor,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          _isMisconceptionExpanded
                              ? LucideIcons.chevronUp
                              : LucideIcons.chevronDown,
                          color: accentColor,
                          size: 16,
                        ),
                      ],
                    ),
                    if (_isMisconceptionExpanded) ...[
                      const SizedBox(height: 10),
                      const Divider(height: 1),
                      const SizedBox(height: 10),
                      MathMarkdown(
                        data: widget.misconceptionAnalysis!,
                        textStyle: TextStyle(
                          fontSize: 12.5,
                          height: 1.45,
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Sheet Primary Action Button
          SlideActionButton(
            text: widget.continueButtonText,
            onPressed: widget.onContinue,
            color: colors.primaryBlue,
            isCenterAligned: true,
            showTrailingChevron: false,
          ),

          // iOS Home Indicator
          Center(
            child: Container(
              width: 130,
              height: 4.5,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: colors.isDark ? Colors.white70 : const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
