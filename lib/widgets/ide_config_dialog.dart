import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/ide_settings_service.dart';
import '../theme/app_theme.dart';

class IdeConfigDialog extends StatefulWidget {
  const IdeConfigDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const IdeConfigDialog(),
    );
  }

  @override
  State<IdeConfigDialog> createState() => _IdeConfigDialogState();
}

class _IdeConfigDialogState extends State<IdeConfigDialog> {
  late IdeSettings _current;

  @override
  void initState() {
    super.initState();
    _current = IdeSettingsService.instance.settings;
  }

  void _update(IdeSettings next) {
    setState(() {
      _current = next;
    });
    IdeSettingsService.instance.updateSettings(next);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: context.colors.outline),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colors.textFaint.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(LucideIcons.slidersHorizontal, color: AppTheme.duoBlue, size: 20),
              const SizedBox(width: 10),
              Text(
                'IDE Editor Settings',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Theme Option
          Text(
            'EDITOR THEME',
            style: TextStyle(
              color: context.colors.textFaint,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          SegmentedButton<bool?>(
            segments: const [
              ButtonSegment(
                value: null,
                label: Text('Auto'),
                icon: Icon(LucideIcons.sparkles, size: 14),
              ),
              ButtonSegment(
                value: true,
                label: Text('Dark'),
                icon: Icon(LucideIcons.moon, size: 14),
              ),
              ButtonSegment(
                value: false,
                label: Text('Light'),
                icon: Icon(LucideIcons.sun, size: 14),
              ),
            ],
            selected: {_current.forceDarkMode},
            onSelectionChanged: (val) {
              _update(_current.copyWith(forceDarkMode: val.first));
            },
          ),
          const SizedBox(height: 20),

          // Font Size Option
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FONT SIZE',
                style: TextStyle(
                  color: context.colors.textFaint,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                '${_current.fontSize.toInt()} px',
                style: TextStyle(
                  color: AppTheme.duoBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              IconButton(
                icon: const Icon(LucideIcons.minusCircle),
                onPressed: _current.fontSize > 10
                    ? () => _update(_current.copyWith(fontSize: _current.fontSize - 1))
                    : null,
              ),
              Expanded(
                child: Slider(
                  value: _current.fontSize,
                  min: 10.0,
                  max: 22.0,
                  divisions: 12,
                  label: '${_current.fontSize.toInt()}px',
                  activeColor: AppTheme.duoBlue,
                  onChanged: (val) => _update(_current.copyWith(fontSize: val)),
                ),
              ),
              IconButton(
                icon: const Icon(LucideIcons.plusCircle),
                onPressed: _current.fontSize < 22
                    ? () => _update(_current.copyWith(fontSize: _current.fontSize + 1))
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Line Numbers & Word Wrap Switches
          SwitchListTile(
            title: const Text('Show Line Numbers'),
            subtitle: const Text('Display line numbers gutter in editor'),
            value: _current.showLineNumbers,
            activeColor: AppTheme.duoGreen,
            contentPadding: EdgeInsets.zero,
            onChanged: (val) => _update(_current.copyWith(showLineNumbers: val)),
          ),
          SwitchListTile(
            title: const Text('Word Wrap'),
            subtitle: const Text('Wrap long code lines instead of horizontal scroll'),
            value: _current.wordWrap,
            activeColor: AppTheme.duoGreen,
            contentPadding: EdgeInsets.zero,
            onChanged: (val) => _update(_current.copyWith(wordWrap: val)),
          ),
        ],
      ),
    );
  }
}
