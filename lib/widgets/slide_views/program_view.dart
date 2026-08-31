import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../services/python_runner_service.dart';
import '../../theme/app_theme.dart';
import '../code_highlighter.dart';
import '../math_markdown.dart';

/// Program Construction & Logic Builder View matching docs/new-theme/slide-p/build_program.html
class ProgramView extends StatefulWidget {
  final Slide slide;
  final String value;
  final bool isAnswered;
  final bool isCorrect;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSubmit;
  final Widget? bottomBar;

  const ProgramView({
    super.key,
    required this.slide,
    required this.value,
    required this.isAnswered,
    required this.isCorrect,
    required this.onChanged,
    this.onSubmit,
    this.bottomBar,
  });

  @override
  State<ProgramView> createState() => _ProgramViewState();
}

class _ProgramViewState extends State<ProgramView> {
  late final TextEditingController _controller;
  List<String> _suggestions = [];

  String get _code => (widget.slide.code?.trim().isNotEmpty ?? false)
      ? widget.slide.code!
      : widget.slide.content;

  String get _language => widget.slide.language ?? 'python';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _buildSuggestions();
  }

  void _buildSuggestions() {
    final set = <String>[];
    for (final a in (widget.slide.blankAnswer ?? '').split(',')) {
      final t = a.trim();
      if (t.isNotEmpty && !set.contains(t)) set.add(t);
    }
    for (final d in widget.slide.blankDistractors ?? const <String>[]) {
      final t = d.trim();
      if (t.isNotEmpty && !set.contains(t)) set.add(t);
    }
    set.shuffle();
    _suggestions = set;
  }

  @override
  void didUpdateWidget(ProgramView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.id != widget.slide.id) {
      _controller.text = widget.value;
      _buildSuggestions();
    } else if (_controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// The code with `___` replaced by the current answer (or a visible placeholder).
  String get _filledCode {
    final answer = widget.value.trim();
    return _code.replaceAll(
      RegExp(r'_{3,}'),
      answer.isEmpty ? '/* [ ? ] */' : answer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasBlank = RegExp(r'_{3,}').hasMatch(_code);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Header Problem Card
                Container(
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: colors.isDark ? 0.35 : 0.04,
                        ),
                        blurRadius: 18,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF8B5CF6).withValues(alpha: 0.12),
                          border: Border.all(
                            color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            LucideIcons.code,
                            size: 16,
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'PROGRAM CONSTRUCTION',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF8B5CF6),
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.badgeBg,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    _language.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w800,
                                      color: colors.textSubtle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            MathMarkdown(
                              data: widget.slide.content.trim().isNotEmpty &&
                                      widget.slide.content != _code
                                  ? widget.slide.content
                                  : 'Complete the logic block to make the program execute correctly.',
                              textStyle: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: colors.textMain,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 2. MacOS-Style Code Panel
                _CodePanel(
                  code: _filledCode,
                  language: _language,
                  answered: widget.isAnswered,
                  correct: widget.isCorrect,
                ),

                if (hasBlank && !widget.isAnswered) ...[
                  const SizedBox(height: 14),

                  // 3. Draggable / Selectable Code Block Chips
                  if (_suggestions.isNotEmpty) ...[
                    Text(
                      'AVAILABLE CODE BLOCKS:',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: colors.textSubtle,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _suggestions.map((snippet) {
                        final isSelected = widget.value.trim() == snippet;
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            _controller.text = snippet;
                            widget.onChanged(snippet);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 160),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF8B5CF6).withValues(alpha: 0.16)
                                  : colors.cardBg,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF8B5CF6)
                                    : colors.cardBorder,
                                width: isSelected ? 1.8 : 1.0,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF8B5CF6)
                                            .withValues(alpha: 0.25),
                                        blurRadius: 10,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Text(
                              snippet,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? const Color(0xFF8B5CF6)
                                    : colors.textMain,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Manual Text Input fallback
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colors.cardBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: colors.cardBorder),
                    ),
                    child: TextField(
                      controller: _controller,
                      enabled: !widget.isAnswered,
                      onChanged: widget.onChanged,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => widget.onSubmit?.call(),
                      autocorrect: false,
                      enableSuggestions: false,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: colors.textMain,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Or type syntax here...',
                        hintStyle: TextStyle(
                          color: colors.textSubtle,
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ],

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
}

/// MacOS-styled Code Panel with syntax highlighting and Python sandbox runner
class _CodePanel extends StatefulWidget {
  final String code;
  final String language;
  final bool answered;
  final bool correct;

  const _CodePanel({
    required this.code,
    required this.language,
    required this.answered,
    required this.correct,
  });

  @override
  State<_CodePanel> createState() => _CodePanelState();
}

class _CodePanelState extends State<_CodePanel> {
  bool _isRunning = false;
  PythonExecutionResult? _result;

  bool get _isPython => widget.language.toLowerCase() == 'python';

  Future<void> _runCode() async {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
      _result = null;
    });

    final res = await PythonRunnerService.instance.runCode(widget.code);

    if (mounted) {
      setState(() {
        _isRunning = false;
        _result = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const theme = CodeTheme.dark;
    final colors = context.colors;
    final borderColor = widget.answered
        ? (widget.correct ? colors.accentGreen : AppTheme.duoRed)
        : colors.cardBorder;

    final lines = widget.code.split('\n');

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // MacOS Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF0E172A),
              border: Border(
                bottom: BorderSide(color: Color(0xFF1E293B)),
              ),
            ),
            child: Row(
              children: [
                _dot(const Color(0xFFFF5F56)),
                _dot(const Color(0xFFFFBD2E)),
                _dot(const Color(0xFF27C93F)),
                const SizedBox(width: 8),
                Text(
                  'main.${widget.language == "python" ? "py" : widget.language}',
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (_isPython)
                  GestureDetector(
                    onTap: _isRunning ? null : _runCode,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colors.accentGreenLight,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: colors.accentGreen.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isRunning)
                            SizedBox(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.8,
                                color: colors.accentGreen,
                              ),
                            )
                          else
                            Icon(
                              LucideIcons.play,
                              color: colors.accentGreen,
                              size: 11,
                            ),
                          const SizedBox(width: 4),
                          Text(
                            'RUN',
                            style: TextStyle(
                              color: colors.accentGreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Code Lines with Line Numbers
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(lines.length, (idx) {
                  final line = lines[idx];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          child: Text(
                            '${idx + 1}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF475569),
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SelectableText.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12.5,
                              height: 1.4,
                            ),
                            children: CodeHighlighter.spans(
                              line,
                              widget.language,
                              theme,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),

          if (_result != null) _buildResultPane(context, _result!),
        ],
      ),
    );
  }

  Widget _buildResultPane(BuildContext context, PythonExecutionResult res) {
    final colors = context.colors;
    final hasStdout = res.stdout.trim().isNotEmpty;
    final hasStderr = res.stderr.trim().isNotEmpty;
    final hasGraphics = res.graphicsBase64.isNotEmpty;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF090D16),
        border: Border(top: BorderSide(color: Color(0xFF1E293B))),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                res.exitCode == 0
                    ? LucideIcons.checkCircle
                    : LucideIcons.alertTriangle,
                size: 13,
                color: res.exitCode == 0 ? colors.accentGreen : AppTheme.duoRed,
              ),
              const SizedBox(width: 6),
              Text(
                'Terminal Output (${res.duration.inMilliseconds}ms)',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: res.exitCode == 0
                      ? colors.accentGreen
                      : AppTheme.duoRed,
                ),
              ),
            ],
          ),
          if (hasStdout) ...[
            const SizedBox(height: 4),
            SelectableText(
              res.stdout,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Color(0xFFF8FAFC),
              ),
            ),
          ],
          if (hasStderr) ...[
            const SizedBox(height: 4),
            SelectableText(
              res.stderr,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Color(0xFFF87171),
              ),
            ),
          ],
          if (hasGraphics) ...[
            const SizedBox(height: 8),
            for (final base64Img in res.graphicsBase64)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    base64Decode(base64Img),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
        width: 9,
        height: 9,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );
}