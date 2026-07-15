import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../services/walkthrough_service.dart';
import '../theme/app_theme.dart';

/// A non-blocking coaching banner pinned to the bottom of the screen while the
/// first-run walkthrough is active. It narrates the current [WalkStep]; the
/// user still performs the real taps on the screen behind it. Mounted once via
/// the app's `MaterialApp.builder` so it floats above every route.
class WalkthroughBanner extends StatelessWidget {
  const WalkthroughBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<WalkStep>(
      valueListenable: WalkthroughService.instance.step,
      builder: (context, step, _) {
        final info =
            WalkthroughService.bannerFor(step, WalkthroughService.instance.seededTitle);
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, anim) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
            child: child,
          ),
          child: info == null
              ? const SizedBox.shrink(key: ValueKey('none'))
              : _Card(key: ValueKey(step), title: info.title, body: info.body),
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String body;
  const _Card({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 520),
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.duoGreen.withValues(alpha: 0.55)),
              boxShadow: [
                BoxShadow(
                  color: context.colors.shadow,
                  blurRadius: 28,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.duoGreen.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(LucideIcons.sparkles,
                      size: 18, color: AppTheme.duoGreen),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.5,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        body,
                        style: TextStyle(
                          color: context.colors.textSecondary,
                          fontSize: 12.5,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => WalkthroughService.instance.finish(),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    foregroundColor: context.colors.textFaint,
                  ),
                  child: const Text('Skip', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
