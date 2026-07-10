import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
    await GlobalState.completeOnboarding();
    GlobalState.isGuestNotifier.value = !toSignIn;
    GlobalState.forceShowAuthScreen.value = toSignIn;
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
                  duration: const Duration(milliseconds: 200),
                  opacity: _isLast ? 0 : 1,
                  child: TextButton(
                    onPressed: _isLast
                        ? null
                        : () => _controller.animateToPage(
                              _pages.length - 1,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeOut,
                            ),
                    child: const Text('Skip',
                        style: TextStyle(
                            color: Colors.white54, fontWeight: FontWeight.bold)),
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
                              color: p.color.withOpacity(0.12),
                              border: Border.all(color: p.color.withOpacity(0.35), width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: p.color.withOpacity(0.25),
                                  blurRadius: 40,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Icon(p.icon, color: p.color, size: 60),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            p.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            p.body,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, height: 1.5, color: Colors.white70),
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
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == _page ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _page ? _pages[_page].color : Colors.white24,
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
