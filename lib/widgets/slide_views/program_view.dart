import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/app_models.dart';
import '../../services/python_runner_service.dart';
import '../../theme/app_theme.dart';
import '../code_highlighter.dart';
import '../math_markdown.dart';

/// A `program` slide: fill-in-the-blank over a syntax-highlighted code block.
/// Behaves like the fill-in-blank slide (same value/onChanged/check contract)
/// but the prompt is real code and the blank sits inside it, highlighted.
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

  String get _code =>
      (widget.slide.code?.trim().isNotEmpty ?? false)
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

  /// The code with `___` replaced by the current answer (or a visible marker).
  String get _filledCode {
    final answer = widget.value.trim();
    return _code.replaceAll(
      RegExp(r'_{3,}'),
      answer.isEmpty ? '▢▢▢' : answer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasBlank = RegExp(r'_{3,}').hasMatch(_code);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.slide.content.trim().isNotEmpty &&
                    widget.slide.content != _code) ...[
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: AppTheme.glassOf(context),
                    child: MathMarkdown(data: widget.slide.content),
                  ),
                  const SizedBox(height: 20),
                ],
                _CodePanel(
                  code: _filledCode,
                  language: _language,
                  answered: widget.isAnswered,
                  correct: widget.isCorrect,
                ),
                if (hasBlank && !widget.isAnswered) ...[
                  const SizedBox(height: 24),
                  _buildAnswerField(context),
                  if (_suggestions.isNotEmpty) _buildSuggestionBank(context),
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

  Widget _buildAnswerField(BuildContext context) {
    return TextField(
      controller: _controller,
      enabled: !widget.isAnswered,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => widget.onSubmit?.call(),
      autocorrect: false,
      enableSuggestions: false,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.amber,
      ),
      decoration: InputDecoration(
        labelText: 'Fill the blank',
        hintText: 'type the missing code',
        hintStyle: TextStyle(color: context.colors.textFaint),
        filled: true,
        fillColor: context.colors.surfaceAlt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.amber, width: 2),
        ),
      ),
    );
  }

  Widget _buildSuggestionBank(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: _suggestions.map((word) {
          final selected = widget.value.trim() == word;
          return GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              _controller.text = word;
              widget.onChanged(word);
            },
            child: Container(
              constraints: const BoxConstraints(minHeight: 44),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: selected
                    ? AppTheme.duoBlue.withValues(alpha: 0.2)
                    : context.colors.surfaceAlt,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected ? AppTheme.duoBlue : context.colors.textFaint,
                  width: 2,
                ),
              ),
              child: Text(
                word,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: selected ? AppTheme.duoBlue : context.colors.textPrimary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// A dark, scrollable, syntax-highlighted code panel with live Python execution capability.
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
    final borderColor = widget.answered
        ? (widget.correct ? AppTheme.duoGreen : AppTheme.duoRed)
        : Colors.white.withValues(alpha: 0.08);

    return Container(
      decoration: BoxDecoration(
        color: theme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
              ),
            ),
            child: Row(
              children: [
                _dot(const Color(0xFFFF5F56)),
                _dot(const Color(0xFFFFBD2E)),
                _dot(const Color(0xFF27C93F)),
                const Spacer(),
                if (_isPython)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: _isRunning ? null : _runCode,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppTheme.duoGreen.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppTheme.duoGreen.withValues(alpha: 0.5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isRunning)
                              const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.duoGreen),
                              )
                            else
                              const Icon(LucideIcons.play, color: AppTheme.duoGreen, size: 12),
                            const SizedBox(width: 4),
                            const Text(
                              'RUN CODE',
                              style: TextStyle(
                                color: AppTheme.duoGreen,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Text(
                  widget.language.toUpperCase(),
                  style: TextStyle(
                    color: theme.comment,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText.rich(
                TextSpan(
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.5,
                    height: 1.55,
                  ),
                  children: CodeHighlighter.spans(widget.code, widget.language, theme),
                ),
              ),
            ),
          ),
          if (_result != null) _buildResultPane(context, _result!),
        ],
      ),
    );
  }

  Widget _buildResultPane(BuildContext context, PythonExecutionResult res) {
    final hasStdout = res.stdout.trim().isNotEmpty;
    final hasStderr = res.stderr.trim().isNotEmpty;
    final hasGraphics = res.graphicsBase64.isNotEmpty;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF020617),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                res.exitCode == 0 ? LucideIcons.checkCircle : LucideIcons.alertTriangle,
                size: 14,
                color: res.exitCode == 0 ? AppTheme.duoGreen : AppTheme.duoRed,
              ),
              const SizedBox(width: 6),
              Text(
                'Output (${res.duration.inMilliseconds}ms)',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: res.exitCode == 0 ? AppTheme.duoGreen : AppTheme.duoRed,
                ),
              ),
            ],
          ),
          if (hasStdout) ...[
            const SizedBox(height: 6),
            SelectableText(
              res.stdout,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFE2E8F0),
              ),
            ),
          ],
          if (hasStderr) ...[
            const SizedBox(height: 6),
            SelectableText(
              res.stderr,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFF87171),
              ),
            ),
          ],
          if (hasGraphics) ...[
            const SizedBox(height: 8),
            for (final base64Img in res.graphicsBase64)
              Padding(
                padding: const EdgeInsets.only(top: 8),
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
        width: 10,
        height: 10,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );
}
