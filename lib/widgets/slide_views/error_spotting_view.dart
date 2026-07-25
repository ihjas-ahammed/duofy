import 'package:flutter/material.dart';

/// Deprecated: `error_spotting` slide type has been removed from the application.
class ErrorSpottingView extends StatelessWidget {
  const ErrorSpottingView({
    super.key,
    dynamic slide,
    dynamic selectedIndex,
    dynamic isAnswered,
    dynamic isCorrect,
    dynamic onSelect,
    dynamic bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}