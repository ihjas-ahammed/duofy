import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../../services/math_evaluator_service.dart';
import '../math_markdown.dart';

/// Numerical Calculation & Precision Keypad View matching docs/new-theme/slide-p/numerical.html
class NumericalView extends StatefulWidget {
  final Slide slide;
  final String value;
  final bool isAnswered;
  final bool isCorrect;
  final Function(String) onChanged;
  final Widget? bottomBar;

  const NumericalView({
    super.key,
    required this.slide,
    required this.value,
    required this.isAnswered,
    required this.isCorrect,
    required this.onChanged,
    this.bottomBar,
  });

  @override
  State<NumericalView> createState() => _NumericalViewState();
}

class _NumericalViewState extends State<NumericalView> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _useMathKeypad = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant NumericalView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: widget.value.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _insertText(String insertText) {
    if (widget.isAnswered) return;
    HapticFeedback.selectionClick();
    final text = _controller.text;
    final selection = _controller.selection;

    if (selection.isValid && selection.start >= 0 && selection.end >= selection.start) {
      final newText = text.replaceRange(selection.start, selection.end, insertText);
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start + insertText.length),
      );
    } else {
      final newText = text + insertText;
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    widget.onChanged(_controller.text);
  }

  void _backspace() {
    if (widget.isAnswered) return;
    HapticFeedback.selectionClick();
    final text = _controller.text;
    final selection = _controller.selection;

    if (text.isEmpty) return;

    if (selection.isValid && selection.start >= 0 && selection.end >= selection.start) {
      if (selection.start != selection.end) {
        final newText = text.replaceRange(selection.start, selection.end, '');
        _controller.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: selection.start),
        );
      } else if (selection.start > 0) {
        final newText = text.replaceRange(selection.start - 1, selection.start, '');
        _controller.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: selection.start - 1),
        );
      }
    } else {
      final newText = text.substring(0, text.length - 1);
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    widget.onChanged(_controller.text);
  }

  void _clear() {
    if (widget.isAnswered) return;
    HapticFeedback.selectionClick();
    _controller.clear();
    widget.onChanged('');
  }

  void _toggleSign() {
    if (widget.isAnswered) return;
    HapticFeedback.selectionClick();
    final text = _controller.text.trim();
    if (text.startsWith('-')) {
      _controller.text = text.substring(1);
    } else if (text.isNotEmpty && text != '0') {
      _controller.text = '-$text';
    }
    widget.onChanged(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final displayValue = _controller.text.isNotEmpty ? _controller.text : '0';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Problem Card
                Container(
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: colors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: colors.isDark ? 0.35 : 0.04,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row: Topic Badge & Mode Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors.primaryBlueLight,
                                ),
                                child: Center(
                                  child: Icon(
                                    LucideIcons.binary,
                                    color: colors.primaryBlue,
                                    size: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'NUMERICAL CALCULATION',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w800,
                                      color: colors.primaryBlue,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Text(
                                    'Precision Problem Solving',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: colors.textSubtle,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() => _useMathKeypad = !_useMathKeypad);
                              if (_useMathKeypad) {
                                FocusScope.of(context).unfocus();
                              } else {
                                _focusNode.requestFocus();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: colors.badgeBg,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: colors.cardBorder),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _useMathKeypad
                                        ? LucideIcons.calculator
                                        : LucideIcons.keyboard,
                                    size: 12,
                                    color: colors.textMuted,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _useMathKeypad ? 'KEYPAD' : 'KEYBOARD',
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w800,
                                      color: colors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Problem Statement
                      MathMarkdown(
                        data: widget.slide.content,
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: colors.textMain,
                          height: 1.4,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 2. Active Answer Input Box
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: widget.isAnswered
                          ? (widget.isCorrect
                              ? colors.accentGreen
                              : AppTheme.duoRed)
                          : colors.primaryBlue,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (widget.isAnswered
                                ? (widget.isCorrect
                                    ? colors.accentGreen
                                    : AppTheme.duoRed)
                                : colors.primaryBlue)
                            .withValues(alpha: 0.16),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CALCULATED VALUE',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: colors.primaryBlue,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              displayValue,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: widget.isAnswered
                                    ? (widget.isCorrect
                                        ? colors.accentGreen
                                        : AppTheme.duoRed)
                                    : colors.textMain,
                                height: 1.1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (widget.slide.numericTolerance != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: colors.badgeBg,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: colors.cardBorder),
                          ),
                          child: Text(
                            '±${widget.slide.numericTolerance}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: colors.textMuted,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Real-time evaluation preview
                _buildCalculationPreview(colors),

                const SizedBox(height: 12),

                // 3. Interactive Scientific Keypad (when enabled)
                if (_useMathKeypad && !widget.isAnswered)
                  _buildScientificKeypad(colors),

                const SizedBox(height: 16),
              ],
            ),
          ),
          if (widget.bottomBar != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 16),
                  widget.bottomBar!,
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCalculationPreview(AppColors colors) {
    final rawText = _controller.text.trim();
    if (rawText.isEmpty) return const SizedBox.shrink();

    final formatted = MathEvaluatorService.formatResult(rawText);
    final isExpression = rawText.startsWith('=') ||
        rawText.contains('+') ||
        rawText.contains('-') ||
        rawText.contains('*') ||
        rawText.contains('/') ||
        rawText.contains('^') ||
        rawText.contains('(') ||
        rawText.contains('P') ||
        rawText.contains('C') ||
        rawText.contains('fact');

    if (!isExpression && formatted == rawText) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: formatted != null
            ? colors.primaryBlueLight
            : AppTheme.duoOrange.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: formatted != null
              ? colors.primaryBlue.withValues(alpha: 0.3)
              : AppTheme.duoOrange.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            formatted != null ? LucideIcons.calculator : LucideIcons.helpCircle,
            size: 14,
            color: formatted != null ? colors.primaryBlue : AppTheme.duoOrange,
          ),
          const SizedBox(width: 6),
          Text(
            formatted != null ? '= $formatted' : '= Incomplete expression',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color:
                  formatted != null ? colors.primaryBlue : AppTheme.duoOrange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScientificKeypad(AppColors colors) {
    final functionChips = [
      'sqrt(',
      'sin(',
      'cos(',
      'tan(',
      'log(',
      'ln(',
      'pi',
      'e',
      '^',
      'fact(',
    ];

    final keys = [
      ['7', '8', '9', '⌫'],
      ['4', '5', '6', '÷'],
      ['1', '2', '3', '×'],
      ['0', '.', '±', '−'],
      ['C', '(', ')', '+'],
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        children: [
          // Function chips row
          SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: functionChips.length,
              separatorBuilder: (_, _) => const SizedBox(width: 6),
              itemBuilder: (context, idx) {
                final label = functionChips[idx];
                return GestureDetector(
                  onTap: () => _insertText(label),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primaryBlueLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: colors.primaryBlue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: colors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Keypad Grid
          ...keys.map((row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: row.map((btn) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: _buildKeyBtn(colors, btn),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildKeyBtn(AppColors colors, String btn) {
    Color bg = colors.mathBoxBg;
    Color fg = colors.textMain;
    Color border = colors.cardBorder;

    if (btn == 'C') {
      bg = AppTheme.duoRed.withValues(alpha: 0.12);
      fg = AppTheme.duoRed;
      border = AppTheme.duoRed.withValues(alpha: 0.3);
    } else if (btn == '⌫') {
      bg = AppTheme.duoOrange.withValues(alpha: 0.12);
      fg = AppTheme.duoOrange;
      border = AppTheme.duoOrange.withValues(alpha: 0.3);
    } else if (['+', '−', '×', '÷', '^', '(', ')', '±'].contains(btn)) {
      bg = colors.primaryBlueLight;
      fg = colors.primaryBlue;
      border = colors.primaryBlue.withValues(alpha: 0.25);
    }

    return GestureDetector(
      onTap: () {
        if (btn == 'C') {
          _clear();
        } else if (btn == '⌫') {
          _backspace();
        } else if (btn == '±') {
          _toggleSign();
        } else if (btn == '×') {
          _insertText('*');
        } else if (btn == '÷') {
          _insertText('/');
        } else if (btn == '−') {
          _insertText('-');
        } else {
          _insertText(btn);
        }
      },
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border),
        ),
        child: Center(
          child: btn == '⌫'
              ? Icon(LucideIcons.delete, size: 16, color: fg)
              : Text(
                  btn,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: fg,
                  ),
                ),
        ),
      ),
    );
  }
}