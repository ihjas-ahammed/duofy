import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import 'practice_session_screen.dart';

/// One generated unit, flattened out of the module/section tree so the range
/// selector can treat a section's units as a single ordered list.
class _UnitRef {
  final String id;
  final String unitTitle;
  final String sectionTitle;
  final List<Slide> slides;
  _UnitRef({required this.id, required this.unitTitle, required this.sectionTitle, required this.slides});
}

/// A section that contains at least one practiceable unit, plus its PYQ pool.
class _SectionRef {
  final String id;
  final String title;
  final List<Slide> pyqQuestions;
  final List<_UnitRef> units;
  _SectionRef({required this.id, required this.title, required this.pyqQuestions, required this.units});
}

/// A module that contains at least one practiceable section.
class _ModuleRef {
  final String title;
  final List<_SectionRef> sections;
  _ModuleRef({required this.title, required this.sections});
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
  // Practiceable modules (each has ≥1 section with ≥1 unit that has slides).
  late final List<_ModuleRef> _modules;
  // Currently selected module.
  int _moduleIdx = 0;
  // Inclusive range of section indices (within the selected module).
  int _secStart = 0;
  int _secEnd = 0;
  // Inclusive range of unit indices (within the selected section range).
  int _startIdx = 0;
  int _endIdx = 0;

  static const List<_PracticeMode> _modes = [
    _PracticeMode('quiz', 'Multiple Choice', 'Test knowledge', LucideIcons.listChecks, AppTheme.duoBlue),
    _PracticeMode('proof', 'Proofs & Logic', 'Step-by-step', LucideIcons.brainCircuit, AppTheme.duoViolet),
    _PracticeMode('step_by_step', 'Big Questions', 'Multi-stage', LucideIcons.layers, AppTheme.duoOrange),
    _PracticeMode('fill_in_blank', 'Fill in Blanks', 'Recall terms', LucideIcons.type, AppTheme.duoRed),
    _PracticeMode('one_word', 'One Word', 'Type the term', LucideIcons.pencil, AppTheme.duoViolet),
    _PracticeMode('numerical', 'Numericals', 'Calculate values', LucideIcons.calculator, AppTheme.duoGreen),
  ];

  @override
  void initState() {
    super.initState();
    _modules = _flattenModules();
    if (_modules.isNotEmpty) _resetSectionRange();
  }

  List<_ModuleRef> _flattenModules() {
    final List<_ModuleRef> out = [];
    for (final module in widget.book.modules) {
      final List<_SectionRef> secs = [];
      for (final section in module.sections) {
        final List<_UnitRef> units = [];
        for (final unit in section.units) {
          // Only units that actually contain lessons can supply practice.
          final hasSlides = unit.lessons.any((l) => l.slides.isNotEmpty);
          if (!hasSlides) continue;
          units.add(_UnitRef(
            id: unit.id,
            unitTitle: unit.title.isNotEmpty ? unit.title : 'Unit',
            sectionTitle: section.title,
            slides: [for (final l in unit.lessons) ...l.slides],
          ));
        }
        if (units.isEmpty) continue;
        secs.add(_SectionRef(
          id: section.id,
          title: section.title.isNotEmpty ? section.title : 'Section',
          pyqQuestions: section.pyqQuestions,
          units: units,
        ));
      }
      if (secs.isEmpty) continue;
      out.add(_ModuleRef(
        title: module.title.isNotEmpty ? module.title : 'Module',
        sections: secs,
      ));
    }
    return out;
  }

  // --- Scope derivation -----------------------------------------------------

  _ModuleRef? get _activeModule => _modules.isEmpty ? null : _modules[_moduleIdx];

  List<_SectionRef> get _sectionsInModule => _activeModule?.sections ?? const [];

  /// Sections inside the selected section range.
  List<_SectionRef> get _selectedSections {
    final secs = _sectionsInModule;
    if (secs.isEmpty) return const [];
    final end = _secEnd.clamp(0, secs.length - 1);
    final start = _secStart.clamp(0, end);
    return [for (int i = start; i <= end; i++) secs[i]];
  }

  /// All units within the selected section range (ordered).
  List<_UnitRef> get _unitsInScope => [for (final s in _selectedSections) ...s.units];

  /// Units inside the selected unit range.
  List<_UnitRef> get _selectedUnits {
    final scope = _unitsInScope;
    if (scope.isEmpty) return const [];
    final end = _endIdx.clamp(0, scope.length - 1);
    final start = _startIdx.clamp(0, end);
    return [for (int i = start; i <= end; i++) scope[i]];
  }

  /// Resets the section range to the whole module, then the unit range too.
  void _resetSectionRange() {
    _secStart = 0;
    _secEnd = _sectionsInModule.isEmpty ? 0 : _sectionsInModule.length - 1;
    _resetUnitRange();
  }

  /// Resets the unit range to span every unit in the current section scope.
  void _resetUnitRange() {
    _startIdx = 0;
    _endIdx = _unitsInScope.isEmpty ? 0 : _unitsInScope.length - 1;
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
      case 'one_word':
        return slideType == 'one_word';
      case 'numerical':
        return slideType == 'numerical';
    }
    return false;
  }

  List<String> get _selectedUnitIds => [for (final u in _selectedUnits) u.id];

  /// Slides within the selected scope (or the whole book when no generated
  /// units were detected, so the legacy fallback still works).
  Iterable<Slide> get _slidesInRange {
    if (_modules.isEmpty) {
      return [
        for (final m in widget.book.modules)
          for (final s in m.sections)
            for (final u in s.units)
              for (final l in u.lessons) ...l.slides
      ];
    }
    return [for (final u in _selectedUnits) ...u.slides];
  }

  List<Slide> get _pyqQuestionsInRange {
    if (_modules.isEmpty) {
      return [
        for (final m in widget.book.modules)
          for (final s in m.sections) ...s.pyqQuestions
      ];
    }
    final selectedUnitIds = _selectedUnitIds.toSet();
    final List<Slide> out = [];
    final Set<String> seen = {};
    for (final s in _selectedSections) {
      if (s.units.any((u) => selectedUnitIds.contains(u.id))) {
        for (final q in s.pyqQuestions) {
          if (seen.add(q.content.trim().toLowerCase())) {
            out.add(q);
          }
        }
      }
    }
    return out;
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
          unitIds: _modules.isEmpty ? null : _selectedUnitIds,
        ),
      ),
    );
  }

  void _configureAndStartPyq() {
    final pyqs = _pyqQuestionsInRange;
    final oneWordAvailable = pyqs.where((q) => q.type == 'one_word').length;
    final proofAvailable = pyqs.where((q) => q.type == 'proof').length;

    int oneWordCount = oneWordAvailable > 5 ? 5 : oneWordAvailable;
    int proofCount = proofAvailable > 2 ? 2 : proofAvailable;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: AppTheme.surface,
            title: const Text(
              'Configure PYQ Session',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Select how many questions of each type to include in this practice session.',
                  style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 24),
                
                // One word questions configuration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('One Word Questions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('Available: $oneWordAvailable', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(LucideIcons.minusCircle, color: Colors.white54),
                          onPressed: oneWordCount > 0 ? () => setDialogState(() => oneWordCount--) : null,
                        ),
                        Text(
                          '$oneWordCount',
                          style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.plusCircle, color: Colors.white54),
                          onPressed: oneWordCount < oneWordAvailable ? () => setDialogState(() => oneWordCount++) : null,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),

                // Proof / Big questions configuration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Proofs & Big Questions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('Available: $proofAvailable', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(LucideIcons.minusCircle, color: Colors.white54),
                          onPressed: proofCount > 0 ? () => setDialogState(() => proofCount--) : null,
                        ),
                        Text(
                          '$proofCount',
                          style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.plusCircle, color: Colors.white54),
                          onPressed: proofCount < proofAvailable ? () => setDialogState(() => proofCount++) : null,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
              ),
              TextButton(
                onPressed: (oneWordCount == 0 && proofCount == 0)
                    ? null
                    : () {
                        Navigator.pop(ctx);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PracticeSessionScreen(
                              book: widget.book,
                              practiceType: 'pyq',
                              unitIds: _modules.isEmpty ? null : _selectedUnitIds,
                              pyqOneWordCount: oneWordCount,
                              pyqProofCount: proofCount,
                            ),
                          ),
                        );
                      },
                child: const Text('Start Practice', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
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
        bottom: false,
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
            _buildScopeSelector(),
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

  Widget _buildScopeSelector() {
    if (_modules.isEmpty) {
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

    final sections = _sectionsInModule;
    final unitsInScope = _unitsInScope;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
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
              const Text('PRACTICE SCOPE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.duoBlue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_selectedUnits.length} unit${_selectedUnits.length == 1 ? '' : 's'}',
                  style: const TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.w900, fontSize: 12),
                ),
              ),
            ],
          ),

          // Module picker — only meaningful when there's more than one module.
          if (_modules.length > 1) ...[
            const SizedBox(height: 14),
            const Text('MODULE', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: _moduleIdx,
                  dropdownColor: AppTheme.surface,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  items: [
                    for (int i = 0; i < _modules.length; i++)
                      DropdownMenuItem(
                        value: i,
                        child: Text(_modules[i].title, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                  ],
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      _moduleIdx = v;
                      _resetSectionRange();
                    });
                  },
                ),
              ),
            ),
          ],

          // Section range — within the selected module.
          _buildRangeBlock(
            label: 'SECTIONS',
            titles: [for (final s in sections) s.title],
            start: _secStart,
            end: _secEnd,
            onChanged: (s, e) => setState(() {
              _secStart = s;
              _secEnd = e;
              _resetUnitRange();
            }),
            onSelectAll: () => setState(() => _resetSectionRange()),
          ),

          // Unit range — within the selected section range.
          _buildRangeBlock(
            label: 'UNITS',
            titles: [for (final u in unitsInScope) u.unitTitle],
            start: _startIdx,
            end: _endIdx,
            onChanged: (s, e) => setState(() {
              _startIdx = s;
              _endIdx = e;
            }),
            onSelectAll: () => setState(() => _resetUnitRange()),
          ),
        ],
      ),
    );
  }

  /// A labelled inclusive-range block (title summary + range slider + a
  /// "Select all" reset). Shared by the section and unit ranges.
  Widget _buildRangeBlock({
    required String label,
    required List<String> titles,
    required int start,
    required int end,
    required void Function(int start, int end) onChanged,
    required VoidCallback onSelectAll,
  }) {
    final total = titles.length;
    if (total == 0) return const SizedBox.shrink();
    final s = start.clamp(0, total - 1);
    final e = end.clamp(s, total - 1);
    final selectedCount = e - s + 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Row(
          children: [
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
            const Spacer(),
            Text(
              selectedCount == total ? 'All $total' : '$selectedCount of $total',
              style: const TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.w900, fontSize: 11),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          selectedCount == 1 ? titles[s] : '${titles[s]}  →  ${titles[e]}',
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
              values: RangeValues(s.toDouble(), e.toDouble()),
              labels: RangeLabels('${s + 1}', '${e + 1}'),
              onChanged: (v) => onChanged(v.start.round(), v.end.round()),
            ),
          ),
        if (total > 1 && selectedCount != total)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onSelectAll,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                minimumSize: const Size(0, 28),
              ),
              child: const Text(
                'Select all',
                style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.w800, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildModeGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final cardWidth = (constraints.maxWidth - spacing) / 2;
        final pyqCount = _pyqQuestionsInRange.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // PYQ Card spanning full width
            _ModeCard(
              mode: const _PracticeMode('pyq', 'PYQ Practice', 'Solve Previous Year Questions', LucideIcons.fileSearch, AppTheme.duoBlue),
              count: pyqCount,
              onTap: pyqCount == 0 ? null : _configureAndStartPyq,
            ),
            const SizedBox(height: spacing),
            Wrap(
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
            ),
          ],
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
