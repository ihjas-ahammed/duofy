import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../../services/math_evaluator_service.dart';
import '../math_markdown.dart';

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
  bool _useMathKeypad = false;

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
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    String placeholder = '0.0 or =formula';
    if (widget.slide.numericAnswer != null) {
      final str = widget.slide.numericAnswer!.toString();
      final parts = str.split('.');
      if (parts.length < 2) {
        placeholder = '0';
      } else {
        final fraction = parts[1];
        if (fraction == '0') {
          placeholder = '0';
        } else {
          placeholder = '0.${'0' * fraction.length}';
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.isDark
                        ? context.colors.surface
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.duoBlue.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.duoBlue.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 4,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppTheme.duoBlue, AppTheme.duoViolet, AppTheme.duoGreen],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: MathMarkdown(
                          data: widget.slide.content,
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: context.colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colors.isDark
                        ? context.colors.surfaceAlt
                        : AppTheme.duoBlue.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.isAnswered
                          ? (widget.isCorrect ? AppTheme.duoGreen : AppTheme.duoRed)
                          : AppTheme.duoBlue.withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ANSWER',
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontWeight: FontWeight.w900,
                              fontSize: 10,
                              letterSpacing: 1.5,
                            ),
                          ),
                          InkWell(
                            onTap: widget.isAnswered
                                ? null
                                : () {
                                    setState(() {
                                      _useMathKeypad = !_useMathKeypad;
                                      if (_useMathKeypad) {
                                        FocusScope.of(context).unfocus();
                                      } else {
                                        _focusNode.requestFocus();
                                      }
                                    });
                                  },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _useMathKeypad
                                    ? AppTheme.duoBlue.withValues(alpha: 0.2)
                                    : context.colors.surface,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _useMathKeypad
                                      ? AppTheme.duoBlue
                                      : context.colors.outline,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _useMathKeypad
                                        ? LucideIcons.calculator
                                        : LucideIcons.keyboard,
                                    size: 14,
                                    color: _useMathKeypad
                                        ? AppTheme.duoBlue
                                        : context.colors.textSecondary,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    _useMathKeypad ? 'KEYPAD' : 'KEYBOARD',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                      color: _useMathKeypad
                                          ? AppTheme.duoBlue
                                          : context.colors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        enabled: !widget.isAnswered,
                        readOnly: _useMathKeypad,
                        onChanged: widget.onChanged,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        enableSuggestions: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: widget.isAnswered
                              ? (widget.isCorrect
                                  ? AppTheme.duoGreen
                                  : AppTheme.duoRed)
                              : Colors.amber,
                        ),
                        decoration: InputDecoration(
                          hintText: placeholder,
                          hintStyle: TextStyle(color: context.colors.textFaint),
                          filled: true,
                          fillColor: context.colors.surface,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      _buildCalculationPreview(context),
                    ],
                  ),
                ),
                if (_useMathKeypad && !widget.isAnswered) ...[
                  const SizedBox(height: 16),
                  _buildMathKeypad(context),
                ],
              ],
            ),
          ),
          if (widget.bottomBar != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [const SizedBox(height: 24), widget.bottomBar!],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCalculationPreview(BuildContext context) {
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
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: formatted != null
            ? AppTheme.duoBlue.withValues(alpha: 0.12)
            : Colors.amber.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: formatted != null
              ? AppTheme.duoBlue.withValues(alpha: 0.4)
              : Colors.amber.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            formatted != null ? LucideIcons.calculator : LucideIcons.helpCircle,
            size: 16,
            color: formatted != null ? AppTheme.duoBlue : Colors.amber,
          ),
          const SizedBox(width: 8),
          Text(
            formatted != null ? '= $formatted' : '= Incomplete formula',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: formatted != null ? AppTheme.duoBlue : Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMathKeypad(BuildContext context) {
    final formulaChips = [
      'P(',
      'C(',
      'fact(',
      'sqrt(',
      'sin(',
      'cos(',
      'tan(',
      'log(',
      'ln(',
      'pi',
      'e',
      '=',
    ];

    final gridButtons = [
      ['C', '(', ')', '⌫'],
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['0', '.', '^', '+'],
    ];

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Function chips bar
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: formulaChips.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final label = formulaChips[index];
                return InkWell(
                  onTap: () => _insertText(label),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.duoBlue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppTheme.duoBlue.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.duoBlue,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          // Calculator Grid
          Column(
            children: gridButtons.map((row) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: row.map((btn) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _buildKeypadButton(context, btn),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadButton(BuildContext context, String btn) {
    Color bg = context.colors.surface;
    Color fg = context.colors.textPrimary;
    Color border = context.colors.outline;

    if (btn == 'C') {
      bg = AppTheme.duoRed.withValues(alpha: 0.15);
      fg = AppTheme.duoRed;
      border = AppTheme.duoRed.withValues(alpha: 0.4);
    } else if (btn == '⌫') {
      bg = Colors.amber.withValues(alpha: 0.15);
      fg = Colors.amber;
      border = Colors.amber.withValues(alpha: 0.4);
    } else if (['+', '-', '*', '/', '^', '(', ')'].contains(btn)) {
      bg = AppTheme.duoBlue.withValues(alpha: 0.12);
      fg = AppTheme.duoBlue;
      border = AppTheme.duoBlue.withValues(alpha: 0.3);
    }

    String displayLabel = btn;
    if (btn == '*') displayLabel = '×';
    if (btn == '/') displayLabel = '÷';
    if (btn == '-') displayLabel = '−';

    return InkWell(
      onTap: () {
        if (btn == 'C') {
          _clear();
        } else if (btn == '⌫') {
          _backspace();
        } else {
          _insertText(btn);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border),
        ),
        child: Center(
          child: Text(
            displayLabel,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: fg,
            ),
          ),
        ),
      ),
    );
  }
}