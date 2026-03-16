import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import 'duo_button.dart';

class UnitHeader extends StatelessWidget {
  final Unit unit;
  final bool isGenerated;
  final bool isLoading;
  final VoidCallback onGenerate;

  const UnitHeader({
    super.key,
    required this.unit,
    required this.isGenerated,
    required this.isLoading,
    required this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    return AppTheme.applyGlassBlur(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Text(
              unit.title.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white, letterSpacing: 1.2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              unit.description,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white54),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            if (!isGenerated)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppTheme.duoViolet))
                    : SizedBox(
                        width: double.infinity,
                        child: DuoButton(
                          text: 'Generate Unit',
                          color: AppTheme.duoViolet,
                          shadowColor: AppTheme.duoVioletDark,
                          onPressed: onGenerate,
                        ),
                      ),
              )
          ],
        ),
      ),
    );
  }
}