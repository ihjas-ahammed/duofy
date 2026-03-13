import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import 'practice_session_screen.dart';

class PracticeScreen extends StatelessWidget {
  final Book book;

  const PracticeScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Arena', style: TextStyle(fontWeight: FontWeight.w900)),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LucideIcons.dumbbell, size: 100, color: AppTheme.duoViolet.withOpacity(0.8)),
              const SizedBox(height: 32),
              const Text(
                'Ready to Train?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'Review past concepts to strengthen your memory. Mistakes here will be repeated until you master them!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 48),
              DuoButton(
                text: 'Start Practice',
                color: AppTheme.duoViolet,
                shadowColor: AppTheme.duoVioletDark,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PracticeSessionScreen(book: book)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}