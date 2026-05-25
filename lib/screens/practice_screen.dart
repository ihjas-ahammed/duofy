import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import 'practice_session_screen.dart';

/// One generated unit, flattened out of the module/section tree so the range
/// selector can treat the whole book as a single ordered list of units.
class _UnitRef {
  final String id;
  final String unitTitle;
  final String sectionTitle;
  final List<Slide> slides;
  _UnitRef({required this.id, required this.unitTitle, required this.sectionTitle, required this.slides});
}

class _PracticeMode {
  final String type;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  const _PracticeMode(this.type, this.title, this.subtitle, this.icon, this.color);
}

class PracticeScreen extends StatefulWidget {
  final Book book;

  const PracticeScreen({super.key, required this.book});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late final List<_UnitRef> _units;
  // Inclusive range of unit indices selected for practice.
  int _startIdx = 0;
  int _endIdx = 0;

  static const List<_PracticeMode> _modes = [
    _PracticeMode('quiz', 'Multiple Choice', 'Test knowledge', LucideIcons.listChecks, AppTheme.duoBlue),
    _PracticeMode('proof', 'Proofs & Logic', 'Step-by-step', LucideIcons.brainCircuit, AppTheme.duoViolet),
    _PracticeMode('step_by_step', 'Big Questions', 'Multi-stage', LucideIcons.layers, AppTheme.duoOrange),
    _PracticeMode('fill_in_blank', 'Fill in Blanks', 'Recall terms', LucideIcons.type, AppTheme.duoRed),
    _PracticeMode('numerical', 'Numericals', 'Calculate values', LucideIcons.calculator, AppTheme.duoGreen),
  ];

  @override
  void initState() {
    super.initState();
    _units = _flattenUnits();
    _endIdx = _units.isEmpty ? 0 : _units.length - 1;
  }

  List<_UnitRef> _flattenUnits() {
    final List<_UnitRef> out = [];
    for (final module in widget.book.modules) {
      for (final section in module.sections) {
        for (final unit in section.units) {
          // Only units that actually contain lessons can supply practice.
          final hasSlides = unit.lessons.any((l) => l.slides.isNotEmpty);
          if (!hasSlides) continue;
          out.add(_UnitRef(
            id: unit.id,
            unitTitle: unit.title.isNotEmpty ? unit.title : 'Unit',
            sectionTitle: section.title,
            slides: [for (final l in unit.lessons) ...l.slides],
          ));
        }
      }
    }
    return out;
  }

  bool _matchesType(String practiceType, String slideType) {
    switch (practiceType) {
      case 'quiz':
        return slideType == 'quiz';
      case 'proof':
        return slideType == 'proof';
      case 'step_by_step':
        return slideType == 'step_by_step' || slideType == 'proof';
      case 'fill_in_blank':
        return slideType == 'fill_in_blank';
      case 'numerical':
        return slideType == 'numerical';
    }
    return false;
  }

  List<String> get _selectedUnitIds {
    if (_units.isEmpty) return const [];
    return [for (int i = _startIdx; i <= _endIdx; i++) _units[i].id];
  }

  /// Slides within the selected unit range (or the whole book when no units
  /// were detected, so the legacy fallback still works).
  Iterable<Slide> get _slidesInRange {
    if (_units.isEmpty) {
      return [
        for (final m in widget.book.modules)
          for (final s in m.sections)
            for (final u in s.units)
              for (final l in u.lessons) ...l.slides
      ];
    }
    return [for (int i = _startIdx; i <= _endIdx; i++) ..._units[i].slides];
  }

  int _countFor(String type) {
    int n = 0;
    for (final s in _slidesInRange) {
      if (_matchesType(type, s.type)) n++;
    }
    return n;
  }

  void _startPractice(_PracticeMode mode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PracticeSessionScreen(
          book: widget.book,
          practiceType: mode.type,
          unitIds: _units.isEmpty ? null : _selectedUnitIds,
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
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4.0, bottom: 20.0, right: 4.0),
              child: Text(
                'Target specific skills to master the concepts. Mistakes are repeated until perfected!',
                style: TextStyle(color: Colors.white54, fontSize: 14, height: 1.4),
              ),
            ),
            _buildRangeSelector(),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 4.0, top: 8, bottom: 12.0),
              child: Text(
                'CHOOSE A MODE',
                style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5),
              ),
            ),
            _buildModeGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildRangeSelector() {
    if (_units.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white12),
        ),
        child: const Row(
          children: [
            Icon(LucideIcons.info, color: Colors.white38, size: 18),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'No generated units yet — practice will draw from any available questions across the book.',
                style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.35),
              ),
            ),
          ],
        ),
      );
    }

    final total = _units.length;
    final selectedCount = _endIdx - _startIdx + 1;
    final startUnit = _units[_startIdx];
    final endUnit = _units[_endIdx];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.duoBlue.withOpacity(0.25), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.slidersHorizontal, color: AppTheme.duoBlue, size: 18),
              const SizedBox(width: 8),
              const Text('UNIT RANGE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.duoBlue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  selectedCount == total ? 'All $total units' : '$selectedCount of $total',
                  style: const TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.w900, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            selectedCount == 1
                ? startUnit.unitTitle
                : '${startUnit.unitTitle}  →  ${endUnit.unitTitle}',
            style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600, height: 1.3),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (total > 1)
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppTheme.duoBlue,
                inactiveTrackColor: Colors.white12,
                thumbColor: AppTheme.duoBlue,
                overlayColor: AppTheme.duoBlue.withOpacity(0.2),
                rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 9),
                trackHeight: 5,
              ),
              child: RangeSlider(
                min: 0,
                max: (total - 1).toDouble(),
                divisions: total - 1,
                values: RangeValues(_startIdx.toDouble(), _endIdx.toDouble()),
                labels: RangeLabels('${_startIdx + 1}', '${_endIdx + 1}'),
                onChanged: (v) {
                  setState(() {
                    _startIdx = v.start.round();
                    _endIdx = v.end.round();
                  });
                },
              ),
            )
          else
            const SizedBox(height: 8),
          if (total > 1)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (selectedCount == total)
                    ? null
                    : () => setState(() {
                          _startIdx = 0;
                          _endIdx = total - 1;
                        }),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  minimumSize: const Size(0, 32),
                ),
                child: Text(
                  'Select all',
                  style: TextStyle(
                    color: selectedCount == total ? Colors.white24 : AppTheme.duoBlue,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModeGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final cardWidth = (constraints.maxWidth - spacing) / 2;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: _modes.map((m) {
            final count = _countFor(m.type);
            return SizedBox(
              width: cardWidth,
              child: _ModeCard(
                mode: m,
                count: count,
                onTap: count == 0 ? null : () => _startPractice(m),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ModeCard extends StatelessWidget {
  final _PracticeMode mode;
  final int count;
  final VoidCallback? onTap;

  const _ModeCard({required this.mode, required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    final color = disabled ? Colors.white24 : mode.color;
    return Opacity(
      opacity: disabled ? 0.45 : 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(disabled ? 0.2 : 0.4), width: 2),
              boxShadow: disabled
                  ? null
                  : [BoxShadow(color: color.withOpacity(0.12), offset: const Offset(0, 4), blurRadius: 12)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: color.withOpacity(0.18), shape: BoxShape.circle),
                      child: Icon(mode.icon, size: 22, color: color),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        disabled ? 'None' : '$count Q',
                        style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.w900, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  mode.title,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  mode.subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.white54, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
