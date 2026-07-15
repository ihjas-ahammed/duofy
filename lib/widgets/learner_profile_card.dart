import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/personalization_service.dart';
import '../theme/app_theme.dart';

/// Structured learner preferences (profile v2): three chip rows instead of
/// essays. Saved immediately and injected into every generation call by
/// PersonalizationService.
class LearnerProfileCard extends StatefulWidget {
  const LearnerProfileCard({super.key});

  @override
  State<LearnerProfileCard> createState() => _LearnerProfileCardState();
}

class _LearnerProfileCardState extends State<LearnerProfileCard> {
  bool? _examplesFirst;
  String? _languageLevel;
  String? _tone;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _examplesFirst = prefs.getBool(PersonalizationService.prefExamplesFirst);
      _languageLevel = prefs.getString(
        PersonalizationService.prefLanguageLevel,
      );
      _tone = prefs.getString(PersonalizationService.prefTone);
      _loaded = true;
    });
  }

  Widget _chipRow<T>({
    required String label,
    required List<(T, String)> options,
    required T? selected,
    required void Function(T?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: context.colors.textFaint,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final (value, text) in options) ...[
                Expanded(
                  child: GestureDetector(
                    // Tapping the active chip clears the preference.
                    onTap: () => onChanged(selected == value ? null : value),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected == value
                            ? AppTheme.duoBlue.withValues(alpha: 0.18)
                            : context.colors.surfaceAlt,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected == value
                              ? AppTheme.duoBlue
                              : context.colors.outline,
                        ),
                      ),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected == value
                              ? AppTheme.duoBlue
                              : context.colors.textSecondary,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
                if (options.last.$1 != value) const SizedBox(width: 8),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveBool(String key, bool? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(key);
    } else {
      await prefs.setBool(key, value);
    }
  }

  Future<void> _saveString(String key, String? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(key);
    } else {
      await prefs.setString(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.glassOf(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                LucideIcons.slidersHorizontal,
                color: AppTheme.duoBlue,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Teaching preferences',
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Applied to every newly generated lesson. Tap a selected chip to clear it.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 11),
          ),
          const SizedBox(height: 16),
          _chipRow<bool>(
            label: 'TEACHING ORDER',
            options: const [(true, 'Examples first'), (false, 'Theory first')],
            selected: _examplesFirst,
            onChanged: (v) {
              setState(() => _examplesFirst = v);
              _saveBool(PersonalizationService.prefExamplesFirst, v);
            },
          ),
          _chipRow<String>(
            label: 'LANGUAGE',
            options: const [
              ('simple', 'Simple'),
              ('standard', 'Standard'),
              ('technical', 'Technical'),
            ],
            selected: _languageLevel,
            onChanged: (v) {
              setState(() => _languageLevel = v);
              _saveString(PersonalizationService.prefLanguageLevel, v);
            },
          ),
          _chipRow<String>(
            label: 'TONE',
            options: const [
              ('encouraging', 'Encouraging'),
              ('neutral', 'Neutral'),
              ('formal', 'Formal'),
            ],
            selected: _tone,
            onChanged: (v) {
              setState(() => _tone = v);
              _saveString(PersonalizationService.prefTone, v);
            },
          ),
        ],
      ),
    );
  }
}
