import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';

class LessonCompleteScreen extends StatefulWidget {
  final int xpEarned;
  final int accuracy;
  final int timeSpentSeconds;
  final bool isPractice; 

  const LessonCompleteScreen({
    super.key,
    required this.xpEarned,
    required this.accuracy,
    required this.timeSpentSeconds,
    this.isPractice = false,
  });

  @override
  State<LessonCompleteScreen> createState() => _LessonCompleteScreenState();
}

class _LessonCompleteScreenState extends State<LessonCompleteScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut)
    );
    
    _animController.forward();
    
    Future.delayed(const Duration(milliseconds: 100), () {
      HapticFeedback.heavyImpact();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  String get _formattedTime {
    int m = widget.timeSpentSeconds ~/ 60;
    int s = widget.timeSpentSeconds % 60;
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  String get _message {
    if (widget.accuracy == 100) return "Perfect!";
    if (widget.accuracy >= 80) return "Great Job!";
    if (widget.accuracy >= 60) return "Good Effort!";
    return "Complete!";
  }

  /// Wraps [child] in the staggered elastic pop-in used across the stat tiles.
  Widget _staggered(double start, Widget child) => ScaleTransition(
        scale: CurvedAnimation(
          parent: _animController,
          curve: Interval(start, 1.0, curve: Curves.elasticOut),
        ),
        child: child,
      );

  /// A single stat tile (XP / accuracy / time). [accentColor] tints the icon
  /// and the bottom rule.
  Widget _statTile({
    required IconData icon,
    required Color accentColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: AppTheme.glassDecoration.copyWith(
        border: Border(bottom: BorderSide(color: accentColor, width: 4)),
      ),
      child: Column(
        children: [
          Icon(icon, color: accentColor, size: 28),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54, letterSpacing: 1.2)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget get _hero => ScaleTransition(
        scale: _scaleAnim,
        child: Column(
          children: [
            const Icon(LucideIcons.trophy, size: 96, color: Colors.amber),
            const SizedBox(height: 28),
            Text(
              _message,
              style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.amber),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  Widget get _continueButton => _staggered(
        0.6,
        DuoButton(
          text: 'Continue',
          color: AppTheme.duoGreen,
          shadowColor: AppTheme.duoGreenDark,
          // Because pushReplacement is used in both LessonScreen and
          // PracticeSessionScreen, popping exactly once properly returns back
          // to the lesson path or practice menu.
          onPressed: () => Navigator.pop(context),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;
    return Scaffold(
      body: SafeArea(
        child: isDesktop ? _buildDesktop() : _buildMobile(),
      ),
    );
  }

  /// Desktop: a single centered glass card holding the hero, all three stats
  /// in one row, and the continue button.
  Widget _buildDesktop() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 56),
            decoration: AppTheme.glassDecoration.copyWith(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _hero,
                const SizedBox(height: 48),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _staggered(0.2, _statTile(icon: LucideIcons.zap, accentColor: Colors.amber, label: 'XP EARNED', value: '+${widget.xpEarned}')),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _staggered(0.35, _statTile(icon: LucideIcons.target, accentColor: AppTheme.duoBlue, label: 'ACCURACY', value: '${widget.accuracy}%')),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _staggered(0.5, _statTile(icon: LucideIcons.clock, accentColor: AppTheme.duoGreen, label: 'TIME SPENT', value: _formattedTime)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 44),
                SizedBox(width: 280, child: _continueButton),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Mobile: original full-height stacked layout.
  Widget _buildMobile() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Spacer(),
          _hero,
          const SizedBox(height: 48),
          _staggered(
            0.2,
            Row(
              children: [
                Expanded(child: _statTile(icon: LucideIcons.zap, accentColor: Colors.amber, label: 'XP EARNED', value: '+${widget.xpEarned}')),
                const SizedBox(width: 16),
                Expanded(child: _statTile(icon: LucideIcons.target, accentColor: AppTheme.duoBlue, label: 'ACCURACY', value: '${widget.accuracy}%')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _staggered(
            0.4,
            SizedBox(
              width: double.infinity,
              child: _statTile(icon: LucideIcons.clock, accentColor: AppTheme.duoGreen, label: 'TIME SPENT', value: _formattedTime),
            ),
          ),
          const Spacer(),
          _continueButton,
        ],
      ),
    );
  }
}