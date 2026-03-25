import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';

class OnboardingSurveyScreen extends StatefulWidget {
  const OnboardingSurveyScreen({super.key});

  @override
  State<OnboardingSurveyScreen> createState() => _OnboardingSurveyScreenState();
}

class _OnboardingSurveyScreenState extends State<OnboardingSurveyScreen> {
  int _currentIndex = 0;
  final Map<int, String> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What kind of stories do you enjoy the most?',
      'options': ['Sci-Fi & Future', 'Fantasy & Magic', 'Historical Events', 'Everyday Real Life', 'Mystery & Detective']
    },
    {
      'question': 'How do you learn best?',
      'options': ['Visual & Metaphors', 'Logical & Direct', 'Story-driven', 'Action-oriented']
    },
    {
      'question': 'What tone keeps you most engaged?',
      'options': ['Humorous & Fun', 'Serious & Epic', 'Casual & Friendly', 'Academic & Precise']
    },
    {
      'question': 'Who is your favorite type of protagonist?',
      'options': ['An Underdog Hero', 'A Brilliant Scientist', 'An Intrepid Explorer', 'A Sharp Detective']
    },
    {
      'question': 'Which setting sounds the most exciting?',
      'options': ['Deep Space', 'Medieval Kingdom', 'Modern Bustling City', 'Wild Nature & Jungle']
    },
  ];

  Future<void> _finishSurvey() async {
    final prefs = await SharedPreferences.getInstance();
    
    List<String> collected = [];
    _answers.forEach((key, val) {
      collected.add("${_questions[key]['question']}: $val");
    });
    
    await prefs.setString('user_interests', collected.join('. '));
    await prefs.setBool('has_completed_survey', true);
    
    if (mounted) Navigator.pop(context);
  }

  void _onOptionSelected(String option) {
    setState(() {
      _answers[_currentIndex] = option;
    });
  }

  void _next() {
    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      _finishSurvey();
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    final options = question['options'] as List<String>;
    final hasAnswered = _answers.containsKey(_currentIndex);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: LinearProgressIndicator(
          value: (_currentIndex + 1) / _questions.length,
          backgroundColor: Colors.white12,
          color: AppTheme.duoViolet,
          minHeight: 12,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Personalize Your Learning',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.duoViolet, letterSpacing: 1.2),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question['question'],
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ...options.map((opt) {
                      final isSelected = _answers[_currentIndex] == opt;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () => _onOptionSelected(opt),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isSelected ? AppTheme.duoViolet.withOpacity(0.2) : AppTheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? AppTheme.duoViolet : Colors.white12, 
                                width: 2
                              ),
                            ),
                            child: Text(
                              opt,
                              style: TextStyle(
                                fontSize: 16, 
                                fontWeight: FontWeight.bold,
                                color: isSelected ? AppTheme.duoViolet : Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: DuoButton(
                text: _currentIndex == _questions.length - 1 ? 'Finish & Save' : 'Continue',
                color: hasAnswered ? AppTheme.duoViolet : Colors.grey.shade700,
                shadowColor: hasAnswered ? AppTheme.duoVioletDark : Colors.grey.shade800,
                onPressed: hasAnswered ? _next : () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}