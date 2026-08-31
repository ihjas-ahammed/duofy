import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../canvas_art_view.dart';
import '../math_markdown.dart';

/// Interactive Proof & Step-by-Step Derivation View matching docs/new-theme/slide-p/proof.html
class InteractiveProofView extends StatefulWidget {
  final Slide slide;
  final VoidCallback onComplete;
  final void Function(String? errorContext)? onRegenerateCanvas;
  final bool canvasIsLoading;
  final Widget? lessonCanvas;
  final void Function(Slide updated)? onUpdateSlide;

  const InteractiveProofView({
    super.key,
    required this.slide,
    required this.onComplete,
    this.onRegenerateCanvas,
    this.canvasIsLoading = false,
    this.lessonCanvas,
    this.onUpdateSlide,
  });

  @override
  State<InteractiveProofView> createState() => _InteractiveProofViewState();
}

class _InteractiveProofViewState extends State<InteractiveProofView> {
  int _currentStepIndex = 0;
  final List<String> _revealedSteps = [];

  String? _selectedOptionId;
  bool _isSubmitted = false;
  bool _isCorrect = false;

  late List<InteractiveStep> _steps;

  @override
  void initState() {
    super.initState();
    _steps = widget.slide.interactiveSteps ?? [];
  }

  @override
  void didUpdateWidget(InteractiveProofView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.id != widget.slide.id) {
      setState(() {
        _currentStepIndex = 0;
        _revealedSteps.clear();
        _selectedOptionId = null;
        _isSubmitted = false;
        _isCorrect = false;
        _steps = widget.slide.interactiveSteps ?? [];
      });
    }
  }

  void _handleNextStatic() {
    if (_currentStepIndex >= _steps.length) return;
    final currentStep = _steps[_currentStepIndex];
    final text = currentStep.stepText?.trim().isNotEmpty == true
        ? currentStep.stepText!
        : (currentStep.prompt ?? '');

    setState(() {
      if (text.isNotEmpty) _revealedSteps.add(text);
      _currentStepIndex++;
    });
    HapticFeedback.lightImpact();
  }

  void _checkAnswer() {
    if (_selectedOptionId == null) return;

    final currentStep = _steps[_currentStepIndex];
    final correctOpt = currentStep.options?.cast<QuizOption?>().firstWhere(
      (o) => o!.isCorrect,
      orElse: () => null,
    );
    final correct = correctOpt?.id == _selectedOptionId;

    setState(() {
      _isSubmitted = true;
      _isCorrect = correct;
    });

    if (correct) {
      HapticFeedback.heavyImpact();
    } else {
      HapticFeedback.mediumImpact();
    }
  }

  void _handleNextInteractive() {
    if (_currentStepIndex >= _steps.length) return;
    final currentStep = _steps[_currentStepIndex];
    final correctOpt = currentStep.options?.cast<QuizOption?>().firstWhere(
      (o) => o!.isCorrect,
      orElse: () => null,
    );

    String textToReveal = '';
    if (currentStep.stepText != null &&
        currentStep.stepText!.isNotEmpty &&
        currentStep.prompt != null) {
      textToReveal = currentStep.stepText!;
    } else {
      textToReveal = correctOpt?.text ?? currentStep.prompt ?? '';
    }

    setState(() {
      if (textToReveal.isNotEmpty) _revealedSteps.add(textToReveal);
      _currentStepIndex++;
      _isSubmitted = false;
      _isCorrect = false;
      _selectedOptionId = null;
    });
    HapticFeedback.lightImpact();
  }

  void _resetInteraction() {
    setState(() {
      _isSubmitted = false;
      _isCorrect = false;
      _selectedOptionId = null;
    });
  }

  void _handlePreviousStep() {
    if (_currentStepIndex > 0) {
      setState(() {
        _currentStepIndex--;
        if (_revealedSteps.isNotEmpty) {
          _revealedSteps.removeLast();
        }
        _isSubmitted = false;
        _isCorrect = false;
        _selectedOptionId = null;
      });
      HapticFeedback.selectionClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isFinished = _currentStepIndex >= _steps.length;
    final currentStep = isFinished ? null : _steps[_currentStepIndex];
    final hasOptions =
        currentStep?.options != null && currentStep!.options!.isNotEmpty;
    final totalSteps = _steps.isNotEmpty ? _steps.length : 1;

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
                      // 1. Header Title Group
                      if (widget.slide.title.trim().isNotEmpty) ...[
                        MathMarkdown(
                          data: widget.slide.title,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: colors.textMain,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Step-by-Step Derivation & Proof',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],

                      // 2. Objective Banner (if content is present)
                      if (widget.slide.content.trim().isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: colors.primaryBlueLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: colors.primaryBlue.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors.primaryBlue,
                                ),
                                child: const Center(
                                  child: Text(
                                    'i',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: MathMarkdown(
                                  data: widget.slide.content,
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: colors.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 12),

                      // Optional Lesson / SVG Canvas
                      if (widget.lessonCanvas != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: widget.lessonCanvas!,
                        ),
                        const SizedBox(height: 12),
                      ],

                      CanvasArtView(
                        svg: widget.slide.canvasSvg,
                        hasPrompt:
                            (widget.slide.canvasPrompt?.trim().isNotEmpty ??
                                false),
                        prompt: widget.slide.canvasPrompt,
                        isLoading: widget.canvasIsLoading,
                        onRegenerate: widget.onRegenerateCanvas,
                        targetId: widget.slide.id,
                      ),

                      // 3. Step Progression Cards
                      ...List.generate(_steps.length, (idx) {
                        final step = _steps[idx];
                        final isCompleted = idx < _currentStepIndex;
                        final isActive = idx == _currentStepIndex;

                        if (isCompleted) {
                          final displayText = idx < _revealedSteps.length
                              ? _revealedSteps[idx]
                              : (step.stepText ?? step.prompt ?? '');

                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: colors.cardBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: colors.cardBorder),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                    alpha: colors.isDark ? 0.25 : 0.03,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: colors.accentGreen,
                                      width: 4,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 22,
                                              height: 22,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colors.accentGreen,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${idx + 1}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Step ${idx + 1}',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800,
                                                color: colors.textMain,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: colors.accentGreenLight,
                                          ),
                                          child: Icon(
                                            LucideIcons.check,
                                            size: 13,
                                            color: colors.accentGreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: MathMarkdown(
                                        data: displayText,
                                        textStyle: TextStyle(
                                          fontSize: 13,
                                          height: 1.45,
                                          color: colors.textMain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        if (isActive) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: colors.cardBg,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: colors.primaryBlue,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colors.primaryBlue.withValues(
                                    alpha: 0.16,
                                  ),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colors.primaryBlue,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${idx + 1}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Active Derivation Step',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: colors.textMain,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (step.prompt?.trim().isNotEmpty == true)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: MathMarkdown(
                                      data: step.prompt!,
                                      textStyle: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        color: colors.textMain,
                                        height: 1.4,
                                      ),
                                    ),
                                  )
                                else if (step.stepText?.trim().isNotEmpty == true)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: MathMarkdown(
                                      data: step.stepText!,
                                      textStyle: TextStyle(
                                        fontSize: 13.5,
                                        color: colors.textMain,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),

                                // If options are present
                                if (hasOptions) ...[
                                  Text(
                                    'SELECT THE JUSTIFYING STATEMENT:',
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w800,
                                      color: colors.textSubtle,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...step.options!.map((opt) {
                                    final isSelected =
                                        _selectedOptionId == opt.id;
                                    Color optBg = colors.cardBg;
                                    Color optBorder = colors.cardBorder;
                                    Color optText = colors.textMain;

                                    if (_isSubmitted) {
                                      if (opt.isCorrect) {
                                        optBg = colors.accentGreenLight;
                                        optBorder = colors.accentGreen;
                                        optText = colors.accentGreen;
                                      } else if (isSelected && !opt.isCorrect) {
                                        optBg = AppTheme.duoRed.withValues(
                                          alpha: 0.12,
                                        );
                                        optBorder = AppTheme.duoRed;
                                        optText = AppTheme.duoRed;
                                      }
                                    } else if (isSelected) {
                                      optBg = colors.primaryBlueLight;
                                      optBorder = colors.primaryBlue;
                                      optText = colors.primaryBlue;
                                    }

                                    return GestureDetector(
                                      onTap: _isSubmitted
                                          ? null
                                          : () {
                                              setState(
                                                () => _selectedOptionId =
                                                    opt.id,
                                              );
                                              HapticFeedback.selectionClick();
                                            },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: optBg,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: optBorder,
                                            width: isSelected ? 1.5 : 1.0,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 18,
                                              height: 18,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: isSelected
                                                      ? colors.primaryBlue
                                                      : colors.cardBorder,
                                                  width: 1.5,
                                                ),
                                                color: isSelected
                                                    ? colors.primaryBlue
                                                    : Colors.transparent,
                                              ),
                                              child: isSelected
                                                  ? const Center(
                                                      child: Icon(
                                                        LucideIcons.check,
                                                        size: 11,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: MathMarkdown(
                                                data: opt.text,
                                                textStyle: TextStyle(
                                                  fontSize: 12.5,
                                                  fontWeight: FontWeight.w600,
                                                  color: optText,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ],
                            ),
                          );
                        }

                        // Locked State
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: colors.badgeBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: colors.cardBorder.withValues(alpha: 0.5),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors.textSubtle.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${idx + 1}',
                                        style: TextStyle(
                                          color: colors.textSubtle,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Step ${idx + 1}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: colors.textSubtle,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                LucideIcons.lock,
                                size: 14,
                                color: colors.textSubtle,
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // 4. Bottom Stepper & Action Controls
        _buildBottomBar(colors, isFinished, hasOptions, totalSteps),
      ],
    );
  }

  Widget _buildBottomBar(
    AppColors colors,
    bool isFinished,
    bool hasOptions,
    int totalSteps,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colors.cardBg,
        border: Border(top: BorderSide(color: colors.cardBorder)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Step Button
          GestureDetector(
            onTap: _currentStepIndex > 0 ? _handlePreviousStep : null,
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: colors.badgeBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.cardBorder),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.chevronLeft,
                    size: 14,
                    color: _currentStepIndex > 0
                        ? colors.textMain
                        : colors.textSubtle,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    'Prev',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _currentStepIndex > 0
                          ? colors.textMain
                          : colors.textSubtle,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stepper Dashes Center
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Step ${(_currentStepIndex + 1).clamp(1, totalSteps)} of $totalSteps',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: colors.textMuted,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(totalSteps, (i) {
                  final isDoneOrCurrent = i <= _currentStepIndex;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 12,
                    height: 3.5,
                    decoration: BoxDecoration(
                      color: isDoneOrCurrent
                          ? colors.primaryBlue
                          : colors.cardBorder,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  );
                }),
              ),
            ],
          ),

          // Next / Check Action Button
          if (isFinished)
            GestureDetector(
              onTap: widget.onComplete,
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: colors.accentGreen,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colors.accentGreen.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Text(
                      'Complete',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      LucideIcons.checkCheck,
                      size: 14,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          else if (hasOptions)
            !_isSubmitted
                ? GestureDetector(
                    onTap: _selectedOptionId != null ? _checkAnswer : null,
                    child: Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: _selectedOptionId != null
                            ? colors.primaryBlue
                            : colors.cardBorder,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Check',
                            style: TextStyle(
                              color: _selectedOptionId != null
                                  ? Colors.white
                                  : colors.textSubtle,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            LucideIcons.arrowRight,
                            size: 14,
                            color: _selectedOptionId != null
                                ? Colors.white
                                : colors.textSubtle,
                          ),
                        ],
                      ),
                    ),
                  )
                : (_isCorrect
                    ? GestureDetector(
                        onTap: _handleNextInteractive,
                        child: Container(
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: colors.accentGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Next Step',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                LucideIcons.chevronRight,
                                size: 14,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          GestureDetector(
                            onTap: _resetInteraction,
                            child: Container(
                              height: 42,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: colors.cardBg,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: colors.primaryBlue),
                              ),
                              child: Center(
                                child: Text(
                                  'Retry',
                                  style: TextStyle(
                                    color: colors.primaryBlue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: _handleNextInteractive,
                            child: Container(
                              height: 42,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.duoOrange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
          else
            GestureDetector(
              onTap: _handleNextStatic,
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: colors.primaryBlue,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primaryBlue.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Text(
                      'Next Step',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      LucideIcons.chevronRight,
                      size: 14,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}