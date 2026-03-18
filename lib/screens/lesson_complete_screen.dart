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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  children: [
                    const Icon(LucideIcons.trophy, size: 100, color: Colors.amber),
                    const SizedBox(height: 32),
                    Text(
                      _message,
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.amber),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              
              ScaleTransition(
                scale: CurvedAnimation(parent: _animController, curve: const Interval(0.2, 1.0, curve: Curves.elasticOut)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: AppTheme.glassDecoration.copyWith(
                          border: const Border(bottom: BorderSide(color: Colors.amber, width: 4)),
                        ),
                        child: Column(
                          children: [
                            const Icon(LucideIcons.zap, color: Colors.amber, size: 28),
                            const SizedBox(height: 8),
                            const Text('XP EARNED', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54, letterSpacing: 1.2)),
                            const SizedBox(height: 4),
                            Text('+${widget.xpEarned}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: AppTheme.glassDecoration.copyWith(
                          border: const Border(bottom: BorderSide(color: AppTheme.duoBlue, width: 4)),
                        ),
                        child: Column(
                          children: [
                            const Icon(LucideIcons.target, color: AppTheme.duoBlue, size: 28),
                            const SizedBox(height: 8),
                            const Text('ACCURACY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54, letterSpacing: 1.2)),
                            const SizedBox(height: 4),
                            Text('${widget.accuracy}%', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ScaleTransition(
                scale: CurvedAnimation(parent: _animController, curve: const Interval(0.4, 1.0, curve: Curves.elasticOut)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: AppTheme.glassDecoration.copyWith(
                    border: const Border(bottom: BorderSide(color: AppTheme.duoGreen, width: 4)),
                  ),
                  child: Column(
                    children: [
                      const Icon(LucideIcons.clock, color: AppTheme.duoGreen, size: 28),
                      const SizedBox(height: 8),
                      const Text('TIME SPENT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54, letterSpacing: 1.2)),
                      const SizedBox(height: 4),
                      Text(_formattedTime, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ),
              
              const Spacer(),
              ScaleTransition(
                scale: CurvedAnimation(parent: _animController, curve: const Interval(0.6, 1.0, curve: Curves.elasticOut)),
                child: DuoButton(
                  text: 'Continue',
                  color: AppTheme.duoGreen,
                  shadowColor: AppTheme.duoGreenDark,
                  onPressed: () {
                    if (widget.isPractice) {
                      Navigator.pop(context); 
                    } else {
                      Navigator.pop(context); 
                      Navigator.pop(context); 
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}