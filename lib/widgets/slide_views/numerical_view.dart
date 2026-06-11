import 'package:flutter/material.dart';
import '../../models/app_models.dart';
import '../../theme/app_theme.dart';
import '../math_markdown.dart';

class NumericalView extends StatelessWidget {
  final Slide slide;
  final String value;
  final bool isAnswered;
  final bool isCorrect;
  final Function(String) onChanged;

  final Widget? bottomBar;

  const NumericalView({
    super.key, 
    required this.slide, 
    required this.value, 
    required this.isAnswered, 
    required this.isCorrect, 
    required this.onChanged,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    String placeholder = '0.0';
    if (slide.numericAnswer != null) {
      final str = slide.numericAnswer!.toString();
      final parts = str.split('.');
      if (parts.length < 2) {
        placeholder = '0';
      } else {
        final fraction = parts[1];
        if (fraction == '0') {
          placeholder = '0';
        } else {
          placeholder = '0.' + ('0' * fraction.length);
        }
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.glassDecoration,
            child: MathMarkdown(data: slide.content, textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isAnswered ? (isCorrect ? AppTheme.duoGreen : AppTheme.duoRed) : Colors.white12, width: 2),
            ),
            child: Column(
              children: [
                const Text('ENTER NUMBER', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1.5)),
                const SizedBox(height: 12),
                TextField(
                  enabled: !isAnswered,
                  onChanged: onChanged,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.w900,
                    color: isAnswered ? (isCorrect ? AppTheme.duoGreen : AppTheme.duoRed) : Colors.amber,
                  ),
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: const TextStyle(color: Colors.white24),
                    filled: true,
                    fillColor: Colors.black45,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.amber, width: 2)),
                  ),
                ),
              ],
            ),
          ),
          if (bottomBar != null) ...[
            const SizedBox(height: 24),
            bottomBar!,
          ],
        ],
      ),
    );
  }
}