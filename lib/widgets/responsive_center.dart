import 'package:flutter/material.dart';

/// Standard content-width tiers used with [ResponsiveCenter]. Centralising
/// them keeps desktop sizing consistent across screens.
abstract final class ResponsiveMaxWidth {
  /// Login / sign-up card.
  static const double auth = 420;

  /// Forms (settings, generation, questionnaires).
  static const double form = 720;

  /// Long-form reading content (lesson body).
  static const double reading = 860;

  /// Lists, dashboards and browsers.
  static const double content = 1100;
}

/// Centers [child] and caps its width on wide (desktop) windows while leaving
/// narrow (phone/tablet) layouts completely untouched.
///
/// Below [breakpoint] the child is returned verbatim — no extra widgets — so
/// existing mobile layouts render exactly as before. At or above the breakpoint
/// the child is centered horizontally and constrained to [maxWidth], with the
/// scaffold background showing in the margins.
///
/// Wrap a screen's `Scaffold` `body` with this; scrollables still fill the
/// available height (the cap only limits width).
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final double breakpoint;

  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = ResponsiveMaxWidth.content,
    this.breakpoint = 900,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < breakpoint) return child;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
