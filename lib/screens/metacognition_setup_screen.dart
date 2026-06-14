import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../services/ai_service.dart';
import '../widgets/duo_button.dart';
import '../widgets/responsive_center.dart';

class MetacognitionSetupScreen extends StatefulWidget {
  final bool isSettingsMode;

  const MetacognitionSetupScreen({
    super.key,
    this.isSettingsMode = false,
  });

  @override
  State<MetacognitionSetupScreen> createState() => _MetacognitionSetupScreenState();
}

class _MetacognitionSetupScreenState extends State<MetacognitionSetupScreen> {
  final _answersCtrl1 = TextEditingController();
  final _answersCtrl2 = TextEditingController();

  int _words1 = 0;
  int _sentences1 = 0;
  int _words2 = 0;
  int _sentences2 = 0;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _answersCtrl1.addListener(_updateCounts1);
    _answersCtrl2.addListener(_updateCounts2);
  }

  @override
  void dispose() {
    _answersCtrl1.dispose();
    _answersCtrl2.dispose();
    super.dispose();
  }

  void _updateCounts1() {
    final text = _answersCtrl1.text;
    setState(() {
      _words1 = _countWords(text);
      _sentences1 = _countSentences(text);
    });
  }

  void _updateCounts2() {
    final text = _answersCtrl2.text;
    setState(() {
      _words2 = _countWords(text);
      _sentences2 = _countSentences(text);
    });
  }

  int _countWords(String text) {
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).length;
  }

  int _countSentences(String text) {
    if (text.trim().isEmpty) return 0;
    // Split by punctuation followed by space or end of string
    return text.split(RegExp(r'[.!?](\s+|$)')).where((s) => s.trim().isNotEmpty).length;
  }

  bool get _isValid1 => _words1 >= 50 || _sentences1 >= 3;
  bool get _isValid2 => _words2 >= 50 || _sentences2 >= 3;
  bool get _canSubmit => _isValid1 && _isValid2;

  void _submit() async {
    if (!_canSubmit || _isSaving) return;

    setState(() => _isSaving = true);

    try {
      final answers = [
        _answersCtrl1.text.trim(),
        _answersCtrl2.text.trim(),
      ];

      final profileMap = await AiService().extractWritingStyleProfile(answers: answers);

      if (profileMap != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_writing_style_profile', jsonEncode(profileMap));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Writing style analysis complete! Lessons will now adapt to you.'),
              backgroundColor: AppTheme.duoGreen,
            ),
          );
          Navigator.of(context).pop(true);
        }
      } else {
        throw Exception('Extraction returned null.');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to analyze style: $e. Using standard default style instead.'),
            backgroundColor: AppTheme.duoRed,
          ),
        );
        _skip();
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _skip() async {
    final defaultProfile = {
      "syntactic_complexity": "medium",
      "lexical_richness": "moderate",
      "pacing_and_rhythm": "flowing, analytical prose",
      "transitional_mechanics": ["however", "consequently", "furthermore"],
      "tone_and_register": "objective"
    };

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_writing_style_profile', jsonEncode(defaultProfile));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Default professional writing style applied.'),
        ),
      );
      Navigator.of(context).pop(true);
    }
  }

  Widget _buildField({
    required String question,
    required TextEditingController controller,
    required int words,
    required int sentences,
    required bool isValid,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(18),
      decoration: AppTheme.glassDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            question,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            maxLines: 4,
            style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
            decoration: InputDecoration(
              hintText: 'Type your answer here...',
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
              filled: true,
              fillColor: Colors.black12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.duoBlue, width: 1.5),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Words: $words/50  •  Sentences: $sentences/3',
                style: TextStyle(
                  color: isValid ? AppTheme.duoGreen : Colors.white38,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isValid)
                const Icon(
                  LucideIcons.checkCircle2,
                  color: AppTheme.duoGreen,
                  size: 16,
                )
              else
                const Icon(
                  LucideIcons.circle,
                  color: Colors.white24,
                  size: 16,
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          'Metacognitive Setup',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        automaticallyImplyLeading: widget.isSettingsMode,
      ),
      body: Stack(
        children: [
          ResponsiveCenter(
            maxWidth: ResponsiveMaxWidth.form,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    LucideIcons.brain,
                    color: AppTheme.duoBlue,
                    size: 64,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Personalize Your Learning Style',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'To reduce cognitive load, our AI will adapt textbook content to match the best academic version of your writing style. Answer the questions below to profile your syntax.',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  _buildField(
                    question: '1. Describe a topic or field of study you are deeply interested in (e.g. physics, art, history). Explain it in your own words.',
                    controller: _answersCtrl1,
                    words: _words1,
                    sentences: _sentences1,
                    isValid: _isValid1,
                  ),
                  
                  _buildField(
                    question: '2. Tell us about a time you found a concept difficult to learn. How did you eventually understand it, and what helps you learn best?',
                    controller: _answersCtrl2,
                    words: _words2,
                    sentences: _sentences2,
                    isValid: _isValid2,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  DuoButton(
                    text: 'Analyze Style Signature',
                    onPressed: () {
                      if (_canSubmit) {
                        _submit();
                      }
                    },
                    color: _canSubmit ? AppTheme.duoBlue : Colors.white12,
                    shadowColor: _canSubmit ? AppTheme.duoBlueDark : Colors.transparent,
                  ),
                  
                  if (!widget.isSettingsMode) ...[
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _skip,
                      child: const Text(
                        'Skip for now (Use default style)',
                        style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (_isSaving)
            Container(
              color: Colors.black.withOpacity(0.75),
              child: Center(
                child: AppTheme.applyGlassBlur(
                  borderRadius: 24,
                  color: const Color(0xFF1E293B).withOpacity(0.85),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                    width: 320,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: AppTheme.duoBlue),
                        SizedBox(height: 24),
                        Text(
                          'Analyzing Writing Style...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Extracting syntactical signature parameters.',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
