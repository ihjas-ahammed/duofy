import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/global_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/duo_button.dart';
import '../../widgets/responsive_center.dart';

class _OnboardingPage {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  const _OnboardingPage(this.icon, this.color, this.title, this.body);
}

/// First-run walkthrough: what Sirius does, how learning works, how the AI
/// adapts — then the sign-in / guest choice. Shown once (see the
/// `onboarding_complete` gate in AuthGate); existing users are migrated past
/// it at boot in main.dart.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  /// Answered on the last page. Steers the first-run walkthrough: programmers
  /// get the interactive Python course, everyone else Basic Algebra.
  bool _isProgrammer = false;

  static const List<_OnboardingPage> _pages = [
    _OnboardingPage(
      LucideIcons.bookOpen,
      AppTheme.duoGreen,
      'Any PDF becomes a course',
      'Upload a textbook, handout, or syllabus. Sirius\'s AI maps its chapters and builds an interactive lesson path — like a language app, but for your own books.',
    ),
    _OnboardingPage(
      LucideIcons.gamepad2,
      AppTheme.duoBlue,
      'Learn in bite-sized lessons',
      'Quizzes, fill-in-the-blanks, proofs and live diagrams — one card at a time. Earn XP, keep a streak, and actually remember what you study.',
    ),
    _OnboardingPage(
      LucideIcons.brainCircuit,
      AppTheme.duoViolet,
      'AI that adapts to you',
      'Rate how confident you feel, reflect after each lesson, and Sirius tunes lesson difficulty and review timing to how you really learn.',
    ),
    _OnboardingPage(
      LucideIcons.rocket,
      AppTheme.duoOrange,
      'Ready when you are',
      'Sign in to use the shared AI keys and cloud backup — or explore as a guest and add your own free Gemini API key later in Settings.',
    ),
  ];

  bool get _isLast => _page == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish({required bool toSignIn}) async {
    // Arm the hands-on walkthrough for the first Home visit. HomeScreen picks
    // this up (so it never fires over the sign-in screen for the login path).
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('walkthrough_pending', true);
    await prefs.setBool('is_programmer', _isProgrammer);
    await GlobalState.completeOnboarding();
    GlobalState.isGuestNotifier.value = !toSignIn;
    GlobalState.forceShowAuthScreen.value = toSignIn;
  }

  Widget _buildProgrammerQuestion() {
    return Column(
      children: [
        Text(
          'Are you a programmer?',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: context.colors.textSecondary,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _programmerChip('Yes', true),
            const SizedBox(width: 12),
            _programmerChip('Not really', false),
          ],
        ),
      ],
    );
  }

  Widget _programmerChip(String label, bool value) {
    final selected = _isProgrammer == value;
    final color = value ? AppTheme.duoViolet : AppTheme.duoBlue;
    return GestureDetector(
      onTap: () => setState(() => _isProgrammer = value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.18) : context.colors.surfaceAlt,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? color : context.colors.outline,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: selected ? color : context.colors.textSecondary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: ResponsiveMaxWidth.auth,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: _isLast ? 0 : 1,
                  child: TextButton(
                    onPressed: _isLast
                        ? null
                        : () => _controller.animateToPage(
                              _pages.length - 1,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeOut,
                            ),
                    child: Text('Skip',
                        style: TextStyle(
                            color: context.colors.textFaint, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (context, i) {
                    final p = _pages[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 132,
                            height: 132,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: p.color.withValues(alpha: 0.12),
                              border: Border.all(color: p.color.withValues(alpha: 0.35), width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: p.color.withValues(alpha: 0.25),
                                  blurRadius: 40,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(p.icon, color: p.color, size: 60),
                          ),
                          SizedBox(height: 40),
                          Text(
                            p.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: context.colors.textPrimary),
                          ),
                          SizedBox(height: 16),
                          Text(
                            p.body,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, height: 1.5, color: context.colors.textSecondary),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < _pages.length; i++)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == _page ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _page ? _pages[_page].color : context.colors.outline,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                child: _isLast
                    ? Column(
                        children: [
                          _buildProgrammerQuestion(),
                          const SizedBox(height: 20),
                          DuoButton(
                            text: 'Sign In / Create Account',
                            color: AppTheme.duoGreen,
                            shadowColor: AppTheme.duoGreenDark,
                            onPressed: () => _finish(toSignIn: true),
                          ),
                          const SizedBox(height: 12),
                          DuoButton(
                            text: 'Continue as Guest',
                            color: AppTheme.duoBlue,
                            shadowColor: AppTheme.duoBlueDark,
                            isOutline: true,
                            onPressed: () => _finish(toSignIn: false),
                          ),
                        ],
                      )
                    : DuoButton(
                        text: 'Continue',
                        color: _pages[_page].color,
                        shadowColor: Color.lerp(_pages[_page].color, Colors.black, 0.35)!,
                        onPressed: () => _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}