import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../../services/ai_service.dart';
import '../math_markdown.dart';
import '../duo_button.dart';

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
          _errorMessage = "AI took too long to respond. You can skip this question to continue.";
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick photos: $e')),
      );
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
        _errorMessage = "AI review failed: $e. You can skip this question to continue.";
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
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.lessonCanvas != null) widget.lessonCanvas!,
                      const SizedBox(height: 12),
                      
                      // Question Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: AppTheme.glassDecoration,
                        child: MathMarkdown(
                          data: widget.slide.content,
                          textStyle: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Text Input Area
                      const Text(
                        'YOUR ANSWER',
                        style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _answerController,
                        maxLines: 8,
                        minLines: 4,
                        readOnly: _isSubmitted || _isChecking,
                        style: TextStyle(
                          color: (_isSubmitted || _isChecking) ? Colors.white70 : Colors.white,
                          fontSize: 15,
                        ),
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Type your answer here in paragraphs...',
                          hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
                          filled: true,
                          fillColor: (_isSubmitted || _isChecking) ? Colors.black26 : Colors.black45,
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: AppTheme.duoBlue, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Photos Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'PHOTOS / DIAGRAMS (OPTIONAL)',
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w900,
                              fontSize: 10,
                              letterSpacing: 1.5,
                            ),
                          ),
                          if (!_isSubmitted && !_isChecking)
                            IconButton(
                              onPressed: _pickPhotos,
                              icon: const Icon(LucideIcons.camera, size: 14, color: AppTheme.duoBlue),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_attachedPhotos.isNotEmpty)
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _attachedPhotos.length,
                            itemBuilder: (context, idx) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12, top: 4, bottom: 4),
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.white24),
                                      image: DecorationImage(
                                        image: FileImage(_attachedPhotos[idx]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (!_isSubmitted && !_isChecking)
                                    Positioned(
                                      right: 6,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () => _removePhoto(idx),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.black87,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            size: 14,
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
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.02),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white12),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(LucideIcons.imagePlus, color: Colors.white38, size: 24),
                                SizedBox(height: 4),
                                Text('Upload written work or diagrams', style: TextStyle(color: Colors.white38, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),

                      const SizedBox(height: 20),

                      // Error Message / Bypass Warning
                      if (_errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: AppTheme.duoOrange.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.duoOrange.withOpacity(0.5)),
                          ),
                          child: Row(
                            children: [
                              const Icon(LucideIcons.alertTriangle, color: AppTheme.duoOrange, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // AI Feedback Card
                      if (_isSubmitted)
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: _isCorrect
                                ? AppTheme.duoGreen.withOpacity(0.08)
                                : AppTheme.duoRed.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _isCorrect
                                  ? AppTheme.duoGreen.withOpacity(0.4)
                                  : AppTheme.duoRed.withOpacity(0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _isCorrect ? LucideIcons.checkCircle : LucideIcons.xCircle,
                                    color: _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _isCorrect ? 'AI REVIEW: CORRECT' : 'AI REVIEW: NEEDS IMPROVEMENT',
                                    style: TextStyle(
                                      color: _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 11,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              MathMarkdown(
                                data: _feedback,
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomBarWidget,
      ],
    );
  }

  // Custom Bottom Bar Implementation
  Widget get bottomBarWidget {
    final canCheck = _answerController.text.trim().isNotEmpty || _attachedPhotos.isNotEmpty;

    if (_isChecking) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.duoBlue),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'AI analyzing... ($_secondsRemaining s remaining)',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
            if (_showBypass)
              DuoButton(
                text: 'SKIP',
                color: AppTheme.duoOrange,
                shadowColor: AppTheme.duoOrangeDark,
                onPressed: widget.onComplete,
              ),
          ],
        ),
      );
    }

    if (_showBypass && !_isSubmitted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: const Color(0xFF111827),
        child: Row(
          children: [
            Expanded(
              child: DuoButton(
                text: 'TRY CHECK AGAIN',
                color: AppTheme.duoBlue,
                shadowColor: AppTheme.duoBlueDark,
                onPressed: () => _checkAnswer(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DuoButton(
                text: 'SKIP QUESTION',
                color: AppTheme.duoOrange,
                shadowColor: AppTheme.duoOrangeDark,
                onPressed: widget.onComplete,
              ),
            ),
          ],
        ),
      );
    }

    if (!_isSubmitted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: const Color(0xFF111827),
        child: DuoButton(
          text: 'CHECK ANSWER',
          color: canCheck ? AppTheme.duoGreen : const Color(0xFF334155),
          shadowColor: canCheck ? AppTheme.duoGreenDark : const Color(0xFF1E293B),
          onPressed: () {
            if (canCheck) _checkAnswer();
          },
        ),
      );
    }

    // Is submitted
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF111827),
      child: _isCorrect
          ? DuoButton(
              text: 'CONTINUE',
              color: AppTheme.duoGreen,
              shadowColor: AppTheme.duoGreenDark,
              onPressed: widget.onComplete,
            )
          : Row(
              children: [
                Expanded(
                  child: DuoButton(
                    text: 'TRY AGAIN',
                    color: AppTheme.duoOrange,
                    shadowColor: AppTheme.duoOrangeDark,
                    onPressed: _retry,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DuoButton(
                    text: 'SKIP',
                    color: const Color(0xFF475569),
                    shadowColor: const Color(0xFF334155),
                    onPressed: widget.onComplete,
                  ),
                ),
              ],
            ),
    );
  }
}
