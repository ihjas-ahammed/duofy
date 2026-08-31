import 'dart:async';
import '../../platform/io_shim.dart';
import '../../platform/file_image_shim.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../../services/ai_service.dart';
import '../math_markdown.dart';

/// Descriptive Reading & Deep Synthesis View matching docs/new-theme/slide-p/deep-concept.html
class DescriptiveView extends StatefulWidget {
  final Slide slide;
  final VoidCallback onComplete;
  final Widget? lessonCanvas;

  const DescriptiveView({
    super.key,
    required this.slide,
    required this.onComplete,
    this.lessonCanvas,
  });

  @override
  State<DescriptiveView> createState() => _DescriptiveViewState();
}

class _DescriptiveViewState extends State<DescriptiveView> {
  final TextEditingController _answerController = TextEditingController();
  final List<File> _attachedPhotos = [];
  bool _isChecking = false;
  bool _isSubmitted = false;
  bool _isCorrect = false;
  String _feedback = '';

  // Timer & Bypass properties
  Timer? _timeoutTimer;
  int _secondsRemaining = 30;
  bool _showBypass = false;
  String? _errorMessage;

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    _answerController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _showBypass = false;
    _errorMessage = null;
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _isChecking = false;
          _showBypass = true;
          _errorMessage =
              "AI took too long to respond. You can skip this question to continue.";
          _timeoutTimer?.cancel();
        }
      });
    });
  }

  Future<void> _pickPhotos() async {
    try {
      final pickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg'],
        allowMultiple: true,
      );
      if (pickerResult != null) {
        setState(() {
          final newFiles = pickerResult.paths
              .where((p) => p != null)
              .map((p) => File(p!))
              .toList();
          _attachedPhotos.addAll(newFiles);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to pick photos: $e')));
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _attachedPhotos.removeAt(index);
    });
  }

  Future<void> _checkAnswer() async {
    final text = _answerController.text.trim();
    if (text.isEmpty && _attachedPhotos.isEmpty) return;

    setState(() {
      _isChecking = true;
      _errorMessage = null;
      _showBypass = false;
    });

    _startTimer();

    try {
      final resultFuture = AiService().analyzeDescriptiveAnswer(
        question: widget.slide.content,
        userAnswer: text,
        attachedPhotos: _attachedPhotos,
      );

      final result = await resultFuture;

      _timeoutTimer?.cancel();

      if (!mounted) return;

      setState(() {
        _isChecking = false;
        _isSubmitted = true;
        _isCorrect = result['isCorrect'] ?? false;
        _feedback = result['feedback'] ?? '';
      });
    } catch (e) {
      _timeoutTimer?.cancel();
      if (!mounted) return;

      setState(() {
        _isChecking = false;
        _showBypass = true;
        _errorMessage =
            "AI review failed: $e. You can skip this question to continue.";
      });
    }
  }

  void _retry() {
    setState(() {
      _isSubmitted = false;
      _feedback = '';
      _showBypass = false;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final displayTitle = widget.slide.title.trim().isNotEmpty
        ? widget.slide.title
        : 'Deep Conceptual Synthesis';

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. Meta pill tag
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colors.badgeBg,
                              borderRadius: BorderRadius.circular(9999),
                              border: Border.all(color: colors.cardBorder),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.bookOpen,
                                  size: 13,
                                  color: colors.textMuted,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Deep Synthesis • Written Response',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: colors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // 2. Article Question Card with warm editorial styling
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
                            Text(
                              displayTitle,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: colors.textMain,
                                letterSpacing: -0.3,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (widget.lessonCanvas != null) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: widget.lessonCanvas!,
                              ),
                              const SizedBox(height: 12),
                            ],
                            MathMarkdown(
                              data: widget.slide.content,
                              textStyle: TextStyle(
                                fontSize: 14.5,
                                color: colors.textMain,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // 3. "Stop & Reflect" Socratic Card
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: colors.isDark
                              ? const Color(0x1F2563EB)
                              : const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: colors.primaryBlue.withValues(alpha: 0.3),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.primaryBlue.withValues(alpha: 0.15),
                              ),
                              child: const Center(
                                child: Text('🧠', style: TextStyle(fontSize: 15)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Stop & Reflect',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: colors.primaryBlue,
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    'Synthesize in your own words to solidify schemas in long-term memory.',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: colors.textMuted,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // 4. Text Input Area
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'YOUR WRITTEN RESPONSE',
                            style: TextStyle(
                              color: colors.textSubtle,
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            '${_answerController.text.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length} words',
                            style: TextStyle(
                              color: colors.textMuted,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _answerController,
                        maxLines: 7,
                        minLines: 4,
                        readOnly: _isSubmitted || _isChecking,
                        style: TextStyle(
                          color: (_isSubmitted || _isChecking)
                              ? colors.textMuted
                              : colors.textMain,
                          fontSize: 14.5,
                          height: 1.45,
                        ),
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Type your detailed explanation or derivation here...',
                          hintStyle: TextStyle(
                            color: colors.textSubtle,
                            fontSize: 13.5,
                          ),
                          filled: true,
                          fillColor: colors.mathBoxBg,
                          contentPadding: const EdgeInsets.all(14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: colors.cardBorder),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: colors.cardBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: colors.primaryBlue,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // 5. Photos Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DIAGRAMS / WRITTEN WORK (OPTIONAL)',
                            style: TextStyle(
                              color: colors.textSubtle,
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                              letterSpacing: 1.2,
                            ),
                          ),
                          if (!_isSubmitted && !_isChecking)
                            GestureDetector(
                              onTap: _pickPhotos,
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.camera,
                                    size: 13,
                                    color: colors.primaryBlue,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Attach',
                                    style: TextStyle(
                                      color: colors.primaryBlue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      if (_attachedPhotos.isNotEmpty)
                        SizedBox(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _attachedPhotos.length,
                            itemBuilder: (context, idx) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                      top: 4,
                                      bottom: 4,
                                    ),
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: colors.cardBorder),
                                      image: DecorationImage(
                                        image: fileImageProvider(_attachedPhotos[idx]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (!_isSubmitted && !_isChecking)
                                    Positioned(
                                      right: 4,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () => _removePhoto(idx),
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            color: Colors.black87,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        )
                      else if (!_isSubmitted && !_isChecking)
                        GestureDetector(
                          onTap: _pickPhotos,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: colors.cardBg,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: colors.cardBorder,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.imagePlus,
                                  color: colors.textSubtle,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Attach photo of notebook or sketch',
                                  style: TextStyle(
                                    color: colors.textMuted,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),

                      // Error Message / Timeout Warning
                      if (_errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.duoOrange.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.duoOrange.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                LucideIcons.alertTriangle,
                                color: AppTheme.duoOrange,
                                size: 18,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(
                                    color: colors.textMain,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // AI Feedback Diagnostic Card
                      if (_isSubmitted)
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: _isCorrect
                                ? colors.accentGreenLight
                                : AppTheme.duoRed.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _isCorrect
                                  ? colors.accentGreenBorder
                                  : AppTheme.duoRed.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _isCorrect
                                        ? LucideIcons.checkCircle
                                        : LucideIcons.alertCircle,
                                    color: _isCorrect
                                        ? colors.accentGreen
                                        : AppTheme.duoRed,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _isCorrect
                                        ? 'AI REVIEW: EXCELLENT UNDERSTANDING'
                                        : 'AI REVIEW: REFINEMENT SUGGESTED',
                                    style: TextStyle(
                                      color: _isCorrect
                                          ? colors.accentGreen
                                          : AppTheme.duoRed,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              MathMarkdown(
                                data: _feedback,
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  color: colors.textMain,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildBottomActions(colors),
      ],
    );
  }

  Widget _buildBottomActions(AppColors colors) {
    final canCheck =
        _answerController.text.trim().isNotEmpty || _attachedPhotos.isNotEmpty;

    if (_isChecking) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.cardBg,
          border: Border(top: BorderSide(color: colors.cardBorder)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(colors.primaryBlue),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'AI analyzing response... (${_secondsRemaining}s)',
                style: TextStyle(
                  color: colors.textMuted,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (_showBypass)
              GestureDetector(
                onTap: widget.onComplete,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.duoOrange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'SKIP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    if (_showBypass && !_isSubmitted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: colors.cardBg,
          border: Border(top: BorderSide(color: colors.cardBorder)),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _checkAnswer,
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: colors.primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'TRY AGAIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: widget.onComplete,
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppTheme.duoOrange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (!_isSubmitted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: colors.cardBg,
          border: Border(top: BorderSide(color: colors.cardBorder)),
        ),
        child: GestureDetector(
          onTap: canCheck ? _checkAnswer : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 48,
            decoration: BoxDecoration(
              color: canCheck ? colors.primaryBlue : colors.cardBorder,
              borderRadius: BorderRadius.circular(14),
              boxShadow: canCheck
                  ? [
                      BoxShadow(
                        color: colors.primaryBlue.withValues(alpha: 0.3),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.sparkles,
                        size: 16,
                        color: canCheck ? Colors.white : colors.textSubtle,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Submit for AI Review',
                        style: TextStyle(
                          color: canCheck ? Colors.white : colors.textSubtle,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: Icon(
                    LucideIcons.chevronRight,
                    size: 16,
                    color: canCheck ? Colors.white : colors.textSubtle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Submitted state
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: colors.cardBg,
        border: Border(top: BorderSide(color: colors.cardBorder)),
      ),
      child: _isCorrect
          ? GestureDetector(
              onTap: widget.onComplete,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: colors.accentGreen,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: colors.accentGreen.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(LucideIcons.chevronRight, color: Colors.white, size: 16),
                  ],
                ),
              ),
            )
          : Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _retry,
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: colors.cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors.primaryBlue, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          'Revise Answer',
                          style: TextStyle(
                            color: colors.primaryBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: widget.onComplete,
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: colors.primaryBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}