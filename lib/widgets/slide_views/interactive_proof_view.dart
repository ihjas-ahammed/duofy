import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';
import '../duo_button.dart';

class InteractiveProofView extends StatefulWidget {
  final Slide slide;
  final VoidCallback onComplete;

  const InteractiveProofView({
    super.key,
    required this.slide,
    required this.onComplete,
  });

  @override
  State<InteractiveProofView> createState() => _InteractiveProofViewState();
}

class _InteractiveProofViewState extends State<InteractiveProofView> {
  int _currentStepIndex = 0;
  List<String> _revealedSteps = [];
  
  String? _selectedOptionId;
  bool _isSubmitted = false;
  bool _isCorrect = false;

  late List<InteractiveStep> _steps;

  @override
  void initState() {
    super.initState();
    _steps = widget.slide.interactiveSteps ?? [];
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
    final correctOpt = currentStep.options?.firstWhere((o) => o.isCorrect);
    final correct = correctOpt?.id == _selectedOptionId;

    setState(() {
      _isSubmitted = true;
      _isCorrect = correct;
    });
  }

  void _handleNextInteractive() {
    final currentStep = _steps[_currentStepIndex];
    final correctOpt = currentStep.options?.firstWhere((o) => o.isCorrect);
    
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
                if (widget.slide.title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      widget.slide.title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),

                if (widget.slide.content.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: AppTheme.glassDecoration,
                    child: MathMarkdown(data: widget.slide.content, textStyle: const TextStyle(fontSize: 16, color: Colors.white)),
                  ),

                ..._revealedSteps.map((stepText) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
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
                )).toList(),

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
                            child: MathMarkdown(data: currentStep.prompt!, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                          )
                        else if (hasOptions && currentStep.stepText != null && currentStep.stepText!.isNotEmpty)
                          // Fallback: AI mistakenly put the question inside `stepText` instead of `prompt`
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: MathMarkdown(data: currentStep.stepText!, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                          )
                        else if (!hasOptions && currentStep.stepText != null && currentStep.stepText!.isNotEmpty)
                          MathMarkdown(data: currentStep.stepText!, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),

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
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    border: Border.all(color: borderColor, width: 2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: MathMarkdown(data: opt.text, textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                              ),
                            );
                          }).toList(),
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