import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import 'practice_session_screen.dart';

class PracticeScreen extends StatelessWidget {
  final Book book;

  const PracticeScreen({super.key, required this.book});

  Widget _buildPracticeCard(BuildContext context, String title, String subtitle, String type, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PracticeSessionScreen(book: book, practiceType: type)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            )
          ]
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.white54, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, color: color.withOpacity(0.5))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Arena', style: TextStyle(fontWeight: FontWeight.w900)),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 24.0, right: 8.0),
                child: Text(
                  'Target specific skills to master the concepts. Mistakes will be repeated until perfected!',
                  style: TextStyle(color: Colors.white54, fontSize: 14, height: 1.4),
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildPracticeCard(context, 'Multiple Choice', 'Test knowledge', 'quiz', LucideIcons.list, AppTheme.duoBlue),
                    _buildPracticeCard(context, 'Proofs & Logic', 'Step-by-step', 'proof', LucideIcons.brainCircuit, AppTheme.duoViolet),
                    _buildPracticeCard(context, 'Big Questions', 'Multi-stage', 'step_by_step', LucideIcons.layers, AppTheme.duoOrange),
                    _buildPracticeCard(context, 'Fill in Blanks', 'Recall terms', 'fill_in_blank', LucideIcons.minus, AppTheme.duoRed),
                    _buildPracticeCard(context, 'Numericals', 'Calculate values', 'numerical', LucideIcons.calculator, AppTheme.duoGreen),
                    const SizedBox(height: 100), // padding for bottom nav
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}