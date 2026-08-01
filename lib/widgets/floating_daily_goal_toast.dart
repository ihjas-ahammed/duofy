import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/daily_goal.dart';
import '../services/daily_goals_service.dart';
import '../theme/app_theme.dart';
import '../screens/daily_goals_screen.dart';

class FloatingDailyGoalToast extends StatefulWidget {
  final DailyGoalUpdateEvent event;
  final VoidCallback onDismiss;

  const FloatingDailyGoalToast({
    super.key,
    required this.event,
    required this.onDismiss,
  });

  @override
  State<FloatingDailyGoalToast> createState() => _FloatingDailyGoalToastState();
}

class _FloatingDailyGoalToastState extends State<FloatingDailyGoalToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _slideAnim;
  late Animation<double> _fadeAnim;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnim = Tween<double>(begin: 80.0, end: 0.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    _animController.forward();

    if (widget.event.justCompleted) {
      HapticFeedback.heavyImpact();
      // Auto open Daily Goals screen on completion so user sees animated progress and claims reward
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          _openGoalsScreen();
        }
      });
    } else {
      HapticFeedback.selectionClick();
    }

    _dismissTimer = Timer(const Duration(seconds: 4), () {
      _dismiss();
    });
  }

  void _openGoalsScreen() {
    _dismissTimer?.cancel();
    _dismiss();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DailyGoalsScreen()),
    );
  }

  void _dismiss() {
    if (!mounted) return;
    _animController.reverse().then((_) {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final goal = widget.event.goal;
    final prevRatio = widget.event.previousCurrent / goal.target;
    final newRatio = widget.event.newCurrent / goal.target;
    final isCompleted = widget.event.justCompleted || goal.isCompleted;

    final primaryColor = isCompleted ? AppTheme.duoGreen : AppTheme.duoOrange;

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnim.value),
          child: Opacity(
            opacity: _fadeAnim.value,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: _openGoalsScreen,
                child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: context.colors.surface.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.25),
                      blurRadius: 16,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCompleted ? LucideIcons.trophy : goal.icon,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    isCompleted
                                        ? 'Goal Completed!'
                                        : 'Daily Goal Progress',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${widget.event.newCurrent}/${goal.target}',
                                    style: TextStyle(
                                      color: context.colors.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                goal.title,
                                style: TextStyle(
                                  color: context.colors.textPrimary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _dismiss,
                          child: Icon(
                            LucideIcons.x,
                            color: context.colors.textFaint,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Animated floating progress bar!
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 8,
                        color: context.colors.surfaceAlt,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: prevRatio.clamp(0.0, 1.0),
                            end: newRatio.clamp(0.0, 1.0),
                          ),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: value,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: isCompleted
                                        ? [AppTheme.duoGreen, const Color(0xFF10B981)]
                                        : [AppTheme.duoOrange, const Color(0xFFFF8C00)],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (isCompleted) ...[
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.zap, color: AppTheme.duoYellow, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            '+${goal.rewardXp} XP Reward Unlocked!',
                            style: TextStyle(
                              color: AppTheme.duoYellow,
                              fontWeight: FontWeight.w900,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      },
    );
  }
}

/// Global Listener Wrapper that overlays floating animated progress bar toasts anywhere in the app.
class FloatingDailyGoalListener extends StatefulWidget {
  final Widget child;

  const FloatingDailyGoalListener({super.key, required this.child});

  @override
  State<FloatingDailyGoalListener> createState() =>
      _FloatingDailyGoalListenerState();
}

class _FloatingDailyGoalListenerState extends State<FloatingDailyGoalListener> {
  DailyGoalUpdateEvent? _currentEvent;

  @override
  void initState() {
    super.initState();
    DailyGoalsService.instance.goalUpdateNotifier.addListener(_onGoalUpdate);
  }

  @override
  void dispose() {
    DailyGoalsService.instance.goalUpdateNotifier
        .removeListener(_onGoalUpdate);
    super.dispose();
  }

  void _onGoalUpdate() {
    final event = DailyGoalsService.instance.goalUpdateNotifier.value;
    if (event != null && mounted) {
      setState(() {
        _currentEvent = event;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_currentEvent != null)
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: FloatingDailyGoalToast(
              key: ValueKey('${_currentEvent!.goal.id}_${_currentEvent!.newCurrent}'),
              event: _currentEvent!,
              onDismiss: () {
                if (mounted) {
                  setState(() {
                    _currentEvent = null;
                  });
                }
              },
            ),
          ),
      ],
    );
  }
}
