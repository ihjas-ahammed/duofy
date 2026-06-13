import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../canvas_art_view.dart';
import '../math_markdown.dart';
import '../duo_button.dart';

class InteractiveProofView extends StatefulWidget {
  final Slide slide;
  final VoidCallback onComplete;
  /// Triggered when the user taps the regenerate button on the slide\'s
  /// canvas. Null disables the regenerate affordance — used when the
  /// caller doesn\'t know the slide\'s position in the book.
  final void Function(String? errorContext)? onRegenerateCanvas;
  /// Set true while a regenerate call for this slide is in flight so the
  /// canvas swaps to its spinner state.
  final bool canvasIsLoading;
  /// Optional lesson-level canvas widget to stack above the content.
  final Widget? lessonCanvas;
  /// Fires when the user double-taps a step or option to edit its text.
  /// The view passes back the new [Slide] (with the relevant interactive
  /// step or option text replaced) and the lesson screen handles state +
  /// persistence. Null disables the affordance.
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
    final currentStep = _steps[_currentStepIndex];
    if (currentStep.stepText != null && currentStep.stepText!.isNotEmpty) {
      setState(() {
        _revealedSteps.add(currentStep.stepText!);
        _currentStepIndex++;
      });
    } else {
      // Failsafe if stepText is empty
      setState(() {
        _currentStepIndex++;
      });
    }
  }

  void _checkAnswer() {
    if (_selectedOptionId == null) return;

    final currentStep = _steps[_currentStepIndex];
    final correctOpt = currentStep.options?.cast<QuizOption?>().firstWhere((o) => o!.isCorrect, orElse: () => null);
    final correct = correctOpt?.id == _selectedOptionId;

    setState(() {
      _isSubmitted = true;
      _isCorrect = correct;
    });
  }

  void _handleNextInteractive() {
    final currentStep = _steps[_currentStepIndex];
    final correctOpt = currentStep.options?.cast<QuizOption?>().firstWhere((o) => o!.isCorrect, orElse: () => null);
    
    // Sometimes the AI puts the question in stepText. If it did, don't reveal the question as the "learned fact".
    // Rely on the correct option text instead.
    String textToReveal = '';
    if (currentStep.stepText != null && currentStep.stepText!.isNotEmpty && currentStep.prompt != null) {
      textToReveal = currentStep.stepText!;
    } else {
      textToReveal = correctOpt?.text ?? '';
    }
    
    setState(() {
      if (textToReveal.isNotEmpty) _revealedSteps.add(textToReveal);
      _currentStepIndex++;
      _isSubmitted = false;
      _isCorrect = false;
      _selectedOptionId = null;
    });
  }

  void _resetInteraction() {
    setState(() {
      _isSubmitted = false;
      _isCorrect = false;
      _selectedOptionId = null;
    });
  }

  Future<void> _editText({
    required String label,
    required String initial,
    required void Function(String) onSave,
  }) async {
    if (widget.onUpdateSlide == null) return;
    final ctrl = TextEditingController(text: initial);
    final newText = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: ctrl,
          maxLines: null,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black26,
            hintText: 'Markdown / LaTeX supported',
            hintStyle: const TextStyle(color: Colors.white38),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: const Text('Save', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    ctrl.dispose();
    if (newText == null || newText.isEmpty || newText == initial) return;
    onSave(newText);
  }

  void _saveStepText(int stepIdx, String newText) {
    final steps = List<InteractiveStep>.from(_steps);
    steps[stepIdx] = steps[stepIdx].copyWith(stepText: newText);
    setState(() => _steps = steps);
    widget.onUpdateSlide?.call(widget.slide.copyWith(interactiveSteps: steps));
  }

  void _saveStepPrompt(int stepIdx, String newText) {
    final steps = List<InteractiveStep>.from(_steps);
    steps[stepIdx] = steps[stepIdx].copyWith(prompt: newText);
    setState(() => _steps = steps);
    widget.onUpdateSlide?.call(widget.slide.copyWith(interactiveSteps: steps));
  }

  void _saveStepOption(int stepIdx, QuizOption opt, String newText) {
    final steps = List<InteractiveStep>.from(_steps);
    final newOpts = steps[stepIdx]
        .options!
        .map((o) => o.id == opt.id ? o.copyWith(text: newText) : o)
        .toList();
    steps[stepIdx] = steps[stepIdx].copyWith(options: newOpts);
    setState(() => _steps = steps);
    widget.onUpdateSlide?.call(widget.slide.copyWith(interactiveSteps: steps));
  }

  void _saveRevealedStep(int revealedIdx, String newText) {
    final revised = List<String>.from(_revealedSteps);
    revised[revealedIdx] = newText;
    setState(() {
      _revealedSteps
        ..clear()
        ..addAll(revised);
    });
    // Best-effort persistence: rewrite the matching interactive step. The
    // revealed list mirrors stepText for static steps and the correct option
    // text for interactive ones, so finding the source is straightforward.
    final steps = List<InteractiveStep>.from(_steps);
    int seen = 0;
    for (int i = 0; i < steps.length; i++) {
      final s = steps[i];
      final hasReveal = (s.stepText != null && s.stepText!.isNotEmpty) ||
          (s.options?.any((o) => o.isCorrect) ?? false);
      if (!hasReveal) continue;
      if (seen == revealedIdx) {
        if (s.stepText != null && s.stepText!.isNotEmpty && s.prompt == null) {
          steps[i] = s.copyWith(stepText: newText);
        } else if (s.options != null) {
          final newOpts = s.options!.map((o) {
            return o.isCorrect ? o.copyWith(text: newText) : o;
          }).toList();
          steps[i] = s.copyWith(options: newOpts);
        }
        widget.onUpdateSlide?.call(widget.slide.copyWith(interactiveSteps: steps));
        return;
      }
      seen++;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFinished = _currentStepIndex >= _steps.length;
    InteractiveStep? currentStep = isFinished ? null : _steps[_currentStepIndex];
    bool hasOptions = currentStep?.options != null && currentStep!.options!.isNotEmpty;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Lesson-level canvas stacked above proof content
                if (widget.lessonCanvas != null) widget.lessonCanvas!,

                if (widget.slide.title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      widget.slide.title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Per-proof canvas art — scrolls with the rest of the content.
                CanvasArtView(
                  svg: widget.slide.canvasSvg,
                  hasPrompt: (widget.slide.canvasPrompt?.trim().isNotEmpty ?? false),
                  prompt: widget.slide.canvasPrompt,
                  isLoading: widget.canvasIsLoading,
                  onRegenerate: widget.onRegenerateCanvas,
                  targetId: widget.slide.id,
                ),

                if (widget.slide.content.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: AppTheme.glassDecoration,
                    child: MathMarkdown(data: widget.slide.content, textStyle: const TextStyle(fontSize: 16, color: Colors.white)),
                  ),

                ..._revealedSteps.asMap().entries.map((entry) {
                  final revealedIdx = entry.key;
                  final stepText = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onDoubleTap: widget.onUpdateSlide == null
                          ? null
                          : () => _editText(
                                label: 'Edit step',
                                initial: stepText,
                                onSave: (v) => _saveRevealedStep(revealedIdx, v),
                              ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.duoGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppTheme.duoGreen.withOpacity(0.3)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2, right: 12),
                              child: Icon(LucideIcons.checkCircle2, color: AppTheme.duoGreen, size: 20),
                            ),
                            Expanded(child: MathMarkdown(data: stepText, textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                if (!isFinished && currentStep != null)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.duoBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.duoBlue.withOpacity(0.3), width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            const Icon(LucideIcons.brainCircuit, color: AppTheme.duoBlue, size: 24),
                            const SizedBox(width: 8),
                            Text('NEXT STEP', style: TextStyle(color: AppTheme.duoBlue.withOpacity(0.8), fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.2)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Robust step rendering to handle AI placement mistakes
                        if (currentStep.prompt != null && currentStep.prompt!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                              onDoubleTap: widget.onUpdateSlide == null
                                  ? null
                                  : () => _editText(
                                        label: 'Edit prompt',
                                        initial: currentStep.prompt!,
                                        onSave: (v) => _saveStepPrompt(_currentStepIndex, v),
                                      ),
                              child: MathMarkdown(data: currentStep.prompt!, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          )
                        else if (hasOptions && currentStep.stepText != null && currentStep.stepText!.isNotEmpty)
                          // Fallback: AI mistakenly put the question inside `stepText` instead of `prompt`
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                              onDoubleTap: widget.onUpdateSlide == null
                                  ? null
                                  : () => _editText(
                                        label: 'Edit step text',
                                        initial: currentStep.stepText!,
                                        onSave: (v) => _saveStepText(_currentStepIndex, v),
                                      ),
                              child: MathMarkdown(data: currentStep.stepText!, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          )
                        else if (!hasOptions && currentStep.stepText != null && currentStep.stepText!.isNotEmpty)
                          GestureDetector(
                            onDoubleTap: widget.onUpdateSlide == null
                                ? null
                                : () => _editText(
                                      label: 'Edit step text',
                                      initial: currentStep.stepText!,
                                      onSave: (v) => _saveStepText(_currentStepIndex, v),
                                    ),
                            child: MathMarkdown(data: currentStep.stepText!, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                          ),

                        if (hasOptions)
                          ...currentStep.options!.map((opt) {
                            final isSelected = _selectedOptionId == opt.id;
                            Color borderColor = Colors.white12;
                            Color bgColor = Colors.white.withOpacity(0.05);

                            if (_isSubmitted) {
                              if (opt.isCorrect) {
                                borderColor = AppTheme.duoGreen;
                                bgColor = AppTheme.duoGreen.withOpacity(0.2);
                              } else if (isSelected && !opt.isCorrect) {
                                borderColor = AppTheme.duoRed;
                                bgColor = AppTheme.duoRed.withOpacity(0.2);
                              } else {
                                bgColor = Colors.transparent;
                              }
                            } else if (isSelected) {
                              borderColor = AppTheme.duoBlue;
                              bgColor = AppTheme.duoBlue.withOpacity(0.2);
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: InkWell(
                                onTap: _isSubmitted ? null : () => setState(() => _selectedOptionId = opt.id),
                                onDoubleTap: widget.onUpdateSlide == null
                                    ? null
                                    : () => _editText(
                                          label: 'Edit option',
                                          initial: opt.text,
                                          onSave: (v) => _saveStepOption(_currentStepIndex, opt, v),
                                        ),
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    border: Border.all(color: borderColor, width: 2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: MathMarkdown(data: opt.text, selectable: false, textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                              ),
                            );
                          }),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),

        // Bottom Action Bar
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color: _isSubmitted 
              ? (_isCorrect ? AppTheme.duoGreen.withOpacity(0.15) : AppTheme.duoRed.withOpacity(0.15))
              : Colors.transparent,
            border: Border(top: BorderSide(
              color: _isSubmitted ? (_isCorrect ? AppTheme.duoGreen : AppTheme.duoRed) : Colors.white10, 
              width: 2)
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_isSubmitted)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed, shape: BoxShape.circle),
                        child: Icon(_isCorrect ? LucideIcons.check : LucideIcons.x, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          _isCorrect ? 'Excellent!' : 'Incorrect.',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed),
                        ),
                      ),
                    ],
                  ),
                ),
                
              if (isFinished)
                 DuoButton(
                    text: 'Complete Sequence',
                    color: AppTheme.duoGreen,
                    shadowColor: AppTheme.duoGreenDark,
                    onPressed: widget.onComplete,
                 )
              else if (hasOptions)
                 !_isSubmitted
                    ? DuoButton(
                        text: 'Check Step',
                        color: _selectedOptionId != null ? AppTheme.duoBlue : Colors.grey.shade700,
                        shadowColor: _selectedOptionId != null ? AppTheme.duoBlueDark : Colors.grey.shade800,
                        onPressed: () {
                          if (_selectedOptionId != null) _checkAnswer();
                        },
                      )
                    : DuoButton(
                        text: _isCorrect ? 'Continue' : 'Try Again',
                        color: _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed,
                        shadowColor: _isCorrect ? AppTheme.duoGreenDark : AppTheme.duoRedDark,
                        onPressed: _isCorrect ? _handleNextInteractive : _resetInteraction,
                      )
              else
                 DuoButton(
                    text: 'Next Step',
                    color: AppTheme.duoBlue,
                    shadowColor: AppTheme.duoBlueDark,
                    onPressed: _handleNextStatic,
                 )
            ],
          ),
        )
      ],
    );
  }
}