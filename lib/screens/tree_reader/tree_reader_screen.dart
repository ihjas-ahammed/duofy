import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../models/tree_reader_models.dart';
import '../../services/code_storage_service.dart';
import '../../services/tree_reader_service.dart';
import '../../widgets/interactive_3d_unit_cell.dart';
import '../../widgets/math_markdown.dart';
import '../ide/universal_code_runner_screen.dart';
import 'html_app_viewer_screen.dart';

class TreeReaderScreen extends StatefulWidget {
  final TreeCourse course;

  const TreeReaderScreen({
    super.key,
    required this.course,
  });

  @override
  State<TreeReaderScreen> createState() => _TreeReaderScreenState();
}

class _TreeReaderScreenState extends State<TreeReaderScreen> {
  late TreeReaderService _service;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _showBookmarkedOnly = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _service = TreeReaderService(widget.course);
    _service.addListener(_onServiceUpdate);
  }

  @override
  void dispose() {
    _service.removeListener(_onServiceUpdate);
    _searchController.dispose();
    super.dispose();
  }

  void _onServiceUpdate() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final progress = _service.getCourseProgress();
    final accent = widget.course.accentColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredModules = _filterModules();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D1117) : const Color(0xFFF3F6FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildStickyHeader(progress, accent, isDark),
            if (_isSearching) _buildSearchBar(isDark),
            Expanded(
              child: filteredModules.isEmpty
                  ? _buildEmptyState()
                  : ListView(
                      padding: const EdgeInsets.only(top: 12, bottom: 120),
                      children: [
                        _buildCourseMasthead(accent, isDark),
                        const SizedBox(height: 12),
                        ...filteredModules.map((m) => _buildModuleCard(m, accent, isDark)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<TreeModule> _filterModules() {
    if (_searchQuery.isEmpty && !_showBookmarkedOnly) {
      return widget.course.modules;
    }

    final query = _searchQuery.toLowerCase();
    final result = <TreeModule>[];

    for (final m in widget.course.modules) {
      final matchingSections = <TreeSection>[];

      for (final s in m.sections) {
        final matchingTopics = s.topics.where((t) {
          if (_showBookmarkedOnly && !_service.isTopicBookmarked(t.id)) {
            return false;
          }
          if (query.isNotEmpty) {
            final matchesTitle = t.title.toLowerCase().contains(query);
            final matchesGist = t.gist?.toLowerCase().contains(query) ?? false;
            final matchesContent = t.contentMarkdown.toLowerCase().contains(query);
            return matchesTitle || matchesGist || matchesContent;
          }
          return true;
        }).toList();

        if (matchingTopics.isNotEmpty) {
          matchingSections.add(
            TreeSection(
              id: s.id,
              title: s.title,
              estimate: s.estimate,
              topics: matchingTopics,
            ),
          );
        }
      }

      if (matchingSections.isNotEmpty) {
        result.add(
          TreeModule(
            id: m.id,
            title: m.title,
            subtitle: m.subtitle,
            sections: matchingSections,
          ),
        );
      }
    }

    return result;
  }

  Widget _buildStickyHeader(
    ({int done, int total, double percent}) progress,
    Color accent,
    bool isDark,
  ) {
    final pctInt = (progress.percent * 100).round();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B22) : const Color(0xFFFAFBFD),
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF30363D) : const Color(0xFFD2DCEB),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (Navigator.of(context).canPop()) ...[
                IconButton(
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  padding: const EdgeInsets.all(2),
                  icon: const Icon(LucideIcons.arrowLeft, size: 18),
                  tooltip: 'Back',
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 4),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.course.title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '${progress.done}/${progress.total} topics ($pctInt%)',
                      style: TextStyle(
                        fontSize: 10,
                        color: isDark ? const Color(0xFF8B949E) : const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              // Circular progress ring
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: CircularProgressIndicator(
                      value: progress.percent,
                      backgroundColor: accent.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation<Color>(accent),
                      strokeWidth: 2.5,
                    ),
                  ),
                  Text(
                    '$pctInt%',
                    style: TextStyle(
                      fontSize: 7.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'JetBrainsMono',
                      color: accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 2),
              // Expand/collapse all button
              IconButton(
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                padding: const EdgeInsets.all(2),
                icon: const Icon(LucideIcons.chevronsUpDown, size: 17),
                tooltip: 'Expand / Collapse all',
                onPressed: () {
                  final allOpen = _service.openNodeIds.length > 5;
                  _service.expandAll(!allOpen);
                },
              ),
              // Compact PopupMenu for secondary options
              PopupMenuButton<String>(
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                padding: const EdgeInsets.all(2),
                icon: const Icon(LucideIcons.moreVertical, size: 17),
                tooltip: 'More actions',
                onSelected: (value) {
                  switch (value) {
                    case 'search':
                      setState(() {
                        _isSearching = !_isSearching;
                        if (!_isSearching) {
                          _searchQuery = '';
                          _searchController.clear();
                        }
                      });
                      break;
                    case 'bookmarks':
                      setState(() {
                        _showBookmarkedOnly = !_showBookmarkedOnly;
                      });
                      break;
                    case 'web_app':
                      if (widget.course.htmlAppPath != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => HtmlAppViewerScreen(
                              title: widget.course.title,
                              htmlAssetPath: widget.course.htmlAppPath!,
                            ),
                          ),
                        );
                      }
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'search',
                    child: Row(
                      children: [
                        Icon(
                          _isSearching ? LucideIcons.x : LucideIcons.search,
                          size: 16,
                          color: _isSearching ? accent : null,
                        ),
                        const SizedBox(width: 10),
                        Text(_isSearching ? 'Close Search' : 'Search Topics'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'bookmarks',
                    child: Row(
                      children: [
                        Icon(
                          _showBookmarkedOnly ? Icons.bookmark : Icons.bookmark_border,
                          size: 16,
                          color: _showBookmarkedOnly ? const Color(0xFFF59E0B) : null,
                        ),
                        const SizedBox(width: 10),
                        Text(_showBookmarkedOnly ? 'Show All Topics' : 'Bookmarks Only'),
                      ],
                    ),
                  ),
                  if (widget.course.htmlAppPath != null)
                    const PopupMenuItem(
                      value: 'web_app',
                      child: Row(
                        children: [
                          Icon(LucideIcons.globe, size: 16),
                          SizedBox(width: 10),
                          Text('Open Original Web App'),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Micro progress bar line
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress.percent,
              backgroundColor: isDark ? const Color(0xFF263140) : const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(accent),
              minHeight: 2.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isDark ? const Color(0xFF141A22) : const Color(0xFFEDF2F7),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search topics, formulas, or concepts...',
          hintStyle: TextStyle(
            fontSize: 13,
            color: isDark ? const Color(0xFF6E7681) : const Color(0xFF94A3B8),
          ),
          prefixIcon: const Icon(LucideIcons.search, size: 16),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(LucideIcons.xCircle, size: 16),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: isDark ? const Color(0xFF1C2430) : Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (val) {
          setState(() {
            _searchQuery = val.trim();
          });
        },
      ),
    );
  }

  Widget _buildCourseMasthead(Color accent, bool isDark) {
    final ruleColor = isDark ? const Color(0xFF2E2E36) : const Color(0xFFD5D3CD);
    final totalTopics = widget.course.modules.fold<int>(
      0,
      (sum, m) => sum + m.sections.fold<int>(0, (s2, sec) => s2 + sec.topics.length),
    );
    final totalModules = widget.course.modules.length;
    final progress = _service.getCourseProgress();
    final pctInt = (progress.percent * 100).toInt();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16161A) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ruleColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.35 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'CORE SYLLABUS · COMPLETE TREE',
                  style: TextStyle(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: accent,
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.course.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.course.subtitle,
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: isDark ? const Color(0xFF9E9EAC) : const Color(0xFF55555F),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildStatCell('MODULES', '$totalModules', isDark, accent),
              const SizedBox(width: 8),
              _buildStatCell('TOPICS', '$totalTopics', isDark, accent),
              const SizedBox(width: 8),
              _buildStatCell('MASTERY', '$pctInt%', isDark, accent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCell(String label, String value, bool isDark, Color accent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1D1D22) : const Color(0xFFEAE9E5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0xFF2E2E36) : const Color(0xFFD5D3CD),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 8.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                fontFamily: 'JetBrainsMono',
                color: isDark ? const Color(0xFF9E9EAC) : const Color(0xFF55555F),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                fontFamily: 'JetBrainsMono',
                color: accent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // LEVEL 1: MODULE DROPDOWN ACCORDION
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildModuleCard(TreeModule module, Color accent, bool isDark) {
    final isOpen = _service.isNodeOpen(module.id);
    final modProgress = _service.getModuleProgress(module);
    final ruleColor = isDark ? const Color(0xFF30363D) : const Color(0xFFD2DCEB);
    final paperColor = isDark ? const Color(0xFF161B22) : const Color(0xFFFAFBFD);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      margin: isOpen
          ? const EdgeInsets.symmetric(horizontal: 0, vertical: 8)
          : const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: paperColor,
        borderRadius: isOpen ? BorderRadius.zero : BorderRadius.circular(14),
        border: isOpen
            ? Border(
                top: BorderSide(color: ruleColor, width: 1.2),
                bottom: BorderSide(color: ruleColor, width: 1.2),
              )
            : Border.all(
                color: ruleColor,
                width: 1.0,
              ),
        boxShadow: isOpen
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.35 : 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Module Header
          InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              _service.toggleNodeOpen(module.id);
            },
            borderRadius: isOpen ? BorderRadius.zero : BorderRadius.circular(14),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: isOpen ? 16 : 14,
                vertical: 13,
              ),
              child: Row(
                children: [
                  // Caret indicator
                  AnimatedRotation(
                    turns: isOpen ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      LucideIcons.chevronRight,
                      size: 18,
                      color: isOpen ? accent : (isDark ? const Color(0xFF8B949E) : const Color(0xFF7E8E9F)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Cascading tick checkbox for whole module
                  _buildTickBox(
                    isAll: modProgress.isAll,
                    isSome: modProgress.isSome,
                    accent: accent,
                    onTap: () => _service.toggleModuleDone(module),
                  ),
                  const SizedBox(width: 12),
                  // Title & Subtitle with Special Styled Module Tag
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final modIdx = widget.course.modules.indexOf(module);
                        final fallbackTag = 'MODULE ${modIdx >= 0 ? modIdx + 1 : 1}';
                        final regExp = RegExp(r'^(Module\s+[0-9IVXLCDM]+)[\s:.\-]+(.*)$', caseSensitive: false);
                        final match = regExp.firstMatch(module.title.trim());
                        final String tag;
                        final String cleanTitle;
                        if (match != null) {
                          tag = match.group(1)!.trim().toUpperCase();
                          final rest = match.group(2)!.trim();
                          cleanTitle = rest.isNotEmpty ? rest : module.title;
                        } else {
                          tag = fallbackTag;
                          cleanTitle = module.title;
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Special styled module tag badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                              margin: const EdgeInsets.only(bottom: 4),
                              decoration: BoxDecoration(
                                color: accent.withValues(alpha: isDark ? 0.16 : 0.10),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: accent.withValues(alpha: isDark ? 0.38 : 0.28),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: accent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    tag,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.9,
                                      fontFamily: 'Nunito',
                                      color: accent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              cleanTitle,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                                color: modProgress.isAll
                                    ? (isDark ? const Color(0xFF8B949E) : const Color(0xFF94A3B8))
                                    : (isDark ? const Color(0xFFE6EDF3) : const Color(0xFF18202A)),
                                decoration: modProgress.isAll ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            if (module.subtitle.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  module.subtitle,
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: isDark ? const Color(0xFF8B949E) : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Counter badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF21262D) : const Color(0xFFEAEFF6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isDark ? const Color(0xFF30363D) : const Color(0xFFD2DCEB),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      '${modProgress.done}/${modProgress.total}',
                      style: TextStyle(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: modProgress.isAll ? const Color(0xFF10B981) : accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Collapsible sections
          if (isOpen) ...[
            Divider(
              height: 1,
              thickness: 1,
              color: isDark ? const Color(0xFF30363D) : const Color(0xFFD2DCEB),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              child: Column(
                children: module.sections.map((s) => _buildSectionCard(s, accent, isDark)).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // LEVEL 2: SECTION DROPDOWN ACCORDION
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildSectionCard(TreeSection section, Color accent, bool isDark) {
    final isOpen = _service.isNodeOpen(section.id);
    final secProgress = _service.getSectionProgress(section);
    final ruleSoft = isDark ? const Color(0xFF262C36) : const Color(0xFFE2EAF5);
    final benchColor = isDark ? const Color(0xFF1C2128) : const Color(0xFFFFFFFF);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      margin: isOpen
          ? const EdgeInsets.symmetric(horizontal: 0, vertical: 6)
          : const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: benchColor,
        borderRadius: isOpen ? BorderRadius.zero : BorderRadius.circular(10),
        border: isOpen
            ? Border(
                top: BorderSide(color: ruleSoft, width: 1.0),
                bottom: BorderSide(color: ruleSoft, width: 1.0),
              )
            : Border.all(
                color: isDark ? const Color(0xFF30363D) : const Color(0xFFD2DCEB),
                width: 1.0,
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              _service.toggleNodeOpen(section.id);
            },
            borderRadius: isOpen ? BorderRadius.zero : BorderRadius.circular(10),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: isOpen ? 16 : 12,
                vertical: 10,
              ),
              child: Row(
                children: [
                  AnimatedRotation(
                    turns: isOpen ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      LucideIcons.chevronRight,
                      size: 16,
                      color: isOpen ? accent : (isDark ? const Color(0xFF6E7681) : const Color(0xFF94A3B8)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildTickBox(
                    isAll: secProgress.isAll,
                    isSome: secProgress.isSome,
                    accent: accent,
                    onTap: () => _service.toggleSectionDone(section),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      section.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: secProgress.isAll
                            ? (isDark ? const Color(0xFF8B949E) : const Color(0xFF94A3B8))
                            : (isDark ? const Color(0xFFE6EDF3) : const Color(0xFF18202A)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (section.estimate.isNotEmpty)
                    Text(
                      section.estimate,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: isDark ? const Color(0xFF6E7681) : const Color(0xFF94A3B8),
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  const SizedBox(width: 8),
                  Text(
                    '${secProgress.done}/${secProgress.total}',
                    style: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: secProgress.isAll ? const Color(0xFF10B981) : accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isOpen) ...[
            Divider(
              height: 1,
              thickness: 1,
              color: isDark ? const Color(0xFF262C36) : const Color(0xFFE2EAF5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Column(
                children: section.topics.map((t) => _buildTopicCard(t, accent, isDark)).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // LEVEL 3: TOPIC DROPDOWN & RICH CONTENT BODY
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildTopicCard(TreeTopic topic, Color accent, bool isDark) {
    final isOpen = _service.isNodeOpen(topic.id);
    final isDone = _service.isTopicDone(topic.id);
    final isBm = _service.isTopicBookmarked(topic.id);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B22) : const Color(0xFFFAFBFD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDone
              ? const Color(0xFF10B981).withOpacity(0.5)
              : (isOpen
                  ? accent.withOpacity(0.5)
                  : (isDark ? const Color(0xFF30363D) : const Color(0xFFD2DCEB))),
          width: (isDone || isOpen) ? 1.2 : 1.0,
        ),
        boxShadow: isOpen
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.25 : 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Topic Header
          InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              _service.toggleNodeOpen(topic.id);
            },
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              child: Row(
                children: [
                  AnimatedRotation(
                    turns: isOpen ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      LucideIcons.chevronRight,
                      size: 15,
                      color: isOpen ? accent : (isDark ? const Color(0xFF6E7681) : const Color(0xFF94A3B8)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildTickBox(
                    isAll: isDone,
                    isSome: false,
                    accent: accent,
                    onTap: () => _service.toggleTopicDone(topic.id),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      topic.title,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: isDone
                            ? (isDark ? const Color(0xFF6E7681) : const Color(0xFF94A3B8))
                            : (isDark ? const Color(0xFFE6EDF3) : const Color(0xFF18202A)),
                        decoration: isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isBm ? Icons.bookmark_added_rounded : LucideIcons.bookmark,
                      size: 16,
                      color: isBm ? const Color(0xFFF59E0B) : (isDark ? const Color(0xFF6E7681) : const Color(0xFF94A3B8)),
                    ),
                    tooltip: isBm ? 'Bookmarked' : 'Bookmark topic',
                    onPressed: () => _service.toggleBookmark(topic.id),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  ),
                ],
              ),
            ),
          ),
          // Topic Body
          if (isOpen) ...[
            Divider(
              height: 1,
              thickness: 1,
              color: isDark ? const Color(0xFF262C36) : const Color(0xFFE2EAF5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gist Banner
                  if (topic.gist != null && topic.gist!.isNotEmpty)
                    _buildGistBanner(topic.gist!, accent, isDark),
                  // Markdown & Math Content
                  if (topic.contentMarkdown.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    MathMarkdown(
                      data: topic.contentMarkdown,
                      selectable: true,
                    ),
                  ],
                  // Interactive 3D Crystal / Unit Cell Diagram
                  if (topic.diagramType == 'unit_cell')
                    const Interactive3dUnitCell(),
                  // Interactive 3D Miller Planes Diagram
                  if (topic.diagramType == 'miller_planes')
                    const Interactive3dMillerPlanes(),
                  // Callout Notes (Pitfalls, Why, Keys)
                  for (final note in topic.notes) ...[
                    const SizedBox(height: 12),
                    _buildNoteCard(note, isDark),
                  ],
                  // Interactive Step Ladder (Derivations / Proofs)
                  if (topic.ladder != null) ...[
                    const SizedBox(height: 16),
                    _buildLadderWidget(topic.ladder!, accent, isDark),
                  ],
                  // Code Snippet & Runner
                  if (topic.codeSnippet != null && topic.codeSnippet!.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    _buildCodeSnippetBox(topic.codeSnippet!, topic.codeLanguage ?? 'python', accent, isDark),
                  ],
                  // Interactive Self-Checks
                  for (final check in topic.checks) ...[
                    const SizedBox(height: 16),
                    _buildCheckWidget(check, accent, isDark),
                  ],
                  // Bottom Topic Done Bar
                  const SizedBox(height: 20),
                  _buildDoneBar(topic, isDone, isBm, accent, isDark),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // PEDAGOGICAL COMPONENTS
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildGistBanner(String gistText, Color accent, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: accent.withOpacity(isDark ? 0.09 : 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withOpacity(0.28), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'GIST',
              style: TextStyle(
                color: Color(0xFF0D1117),
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              gistText,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFFE6EDF3) : const Color(0xFF18202A),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(TreeNote note, bool isDark) {
    final isPitfall = note.type == 'pitfall';
    final isWhy = note.type == 'why';

    final Color noteColor = isPitfall
        ? const Color(0xFFF43F5E)
        : (isWhy ? const Color(0xFFF59E0B) : const Color(0xFF10B981));

    final IconData noteIcon = isPitfall
        ? LucideIcons.alertTriangle
        : (isWhy ? LucideIcons.helpCircle : LucideIcons.lightbulb);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF21262D) : const Color(0xFFEAEFF6),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        border: Border(
          left: BorderSide(color: noteColor, width: 3.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(noteIcon, size: 14, color: noteColor),
              const SizedBox(width: 6),
              Text(
                note.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: noteColor,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          MathMarkdown(
            data: note.content,
            selectable: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLadderWidget(TreeLadder ladder, Color accent, bool isDark) {
    final revealedStep = _service.getLadderRevealedStep(ladder.title);
    final totalSteps = ladder.rungs.length;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B22) : const Color(0xFFFAFBFD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? const Color(0xFF30363D) : const Color(0xFFD2DCEB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF21262D) : const Color(0xFFEAEFF6),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? const Color(0xFF30363D) : const Color(0xFFD2DCEB),
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.gitCommit, size: 15, color: accent),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ladder.title,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: isDark ? const Color(0xFFE6EDF3) : const Color(0xFF18202A),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'DERIVATION',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: accent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < ladder.rungs.length; i++) ...[
                  if (i > 0) const SizedBox(height: 10),
                  _buildRungItem(
                    ladder.title,
                    ladder.rungs[i],
                    i,
                    i < revealedStep,
                    accent,
                    isDark,
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (revealedStep < totalSteps) ...[
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: const Color(0xFF0D1117),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                        icon: const Icon(LucideIcons.chevronDown, size: 14),
                        label: const Text('Reveal Next Step'),
                        onPressed: () => _service.revealNextLadderStep(ladder.title, totalSteps),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          textStyle: const TextStyle(fontSize: 11),
                        ),
                        onPressed: () => _service.revealAllLadderSteps(ladder.title, totalSteps),
                        child: const Text('Show All Steps'),
                      ),
                    ] else ...[
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          textStyle: const TextStyle(fontSize: 11),
                        ),
                        icon: const Icon(LucideIcons.rotateCcw, size: 13),
                        label: const Text('Reset Derivation Steps'),
                        onPressed: () => _service.resetLadderSteps(ladder.title),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRungItem(
    String ladderTitle,
    TreeRung rung,
    int index,
    bool isRevealed,
    Color accent,
    bool isDark,
  ) {
    if (!isRevealed) {
      return InkWell(
        onTap: () => _service.peekLadderStep(ladderTitle, index),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1D1D22) : const Color(0xFFEAE9E5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isDark ? const Color(0xFF2E2E36) : const Color(0xFFD5D3CD),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Step ${index + 1}:',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'JetBrainsMono',
                  color: isDark ? const Color(0xFF8B949E) : const Color(0xFF505E70),
                ),
              ),
              const Spacer(),
              Text(
                'Tap to peek ▸',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16161A) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isDark ? const Color(0xFF2E2E36) : const Color(0xFFD5D3CD),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'JetBrainsMono',
                    color: accent,
                  ),
                ),
              ),
              if (rung.why != null) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    rung.why!,
                    style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: isDark ? const Color(0xFF9E9EAC) : const Color(0xFF55555F),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: MathMarkdown(
              data: rung.math.trim().startsWith(r'$') || rung.math.trim().startsWith(r'\(') || rung.math.trim().startsWith(r'\[')
                  ? rung.math
                  : '\$\$\n${rung.math}\n\$\$',
              selectable: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckWidget(TreeCheck check, Color accent, bool isDark) {
    final confidence = _service.getCheckConfidence(check.id);
    final isRevealed = _service.isCheckRevealed(check.id);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16161A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF2E2E36) : const Color(0xFFD5D3CD),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1D1D22) : const Color(0xFFEAE9E5),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? const Color(0xFF2E2E36) : const Color(0xFFD5D3CD),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  '◈ CHECKPOINT',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    fontFamily: 'JetBrainsMono',
                    color: accent,
                  ),
                ),
                const Spacer(),
                if (confidence != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: [
                        const Color(0xFFF43F5E),
                        const Color(0xFFF59E0B),
                        accent,
                        const Color(0xFF10B981)
                      ][confidence].withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      ['No idea', 'Shaky', 'Fairly sure', 'Solid'][confidence],
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: [
                          const Color(0xFFF43F5E),
                          const Color(0xFFF59E0B),
                          accent,
                          const Color(0xFF10B981)
                        ][confidence],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MathMarkdown(
                  data: check.question,
                  selectable: true,
                ),
                const SizedBox(height: 10),
                // Multiple choice options if present
                if (check.options != null && check.options!.isNotEmpty) ...[
                  for (int i = 0; i < check.options!.length; i++) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isRevealed && i == check.correctIndex
                            ? const Color(0xFF10B981).withOpacity(0.12)
                            : (isDark ? const Color(0xFF1D1D22) : Colors.white),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isRevealed && i == check.correctIndex
                              ? const Color(0xFF10B981)
                              : (isDark ? const Color(0xFF2E2E36) : const Color(0xFFD5D3CD)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            String.fromCharCode(65 + i) + '.',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'JetBrainsMono',
                              color: isRevealed && i == check.correctIndex
                                  ? const Color(0xFF10B981)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: MathMarkdown(
                              data: check.options![i],
                              selectable: false,
                            ),
                          ),
                          if (isRevealed && i == check.correctIndex)
                            const Icon(LucideIcons.check, size: 14, color: Color(0xFF10B981)),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                ],
                // Confidence rating selector
                const Text(
                  'Rate your confidence before checking:',
                  style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: _buildConfidenceBtn(check.id, 0, 'No idea', const Color(0xFFEF4444), confidence, isDark)),
                    const SizedBox(width: 4),
                    Expanded(child: _buildConfidenceBtn(check.id, 1, 'Shaky', const Color(0xFFF59E0B), confidence, isDark)),
                    const SizedBox(width: 4),
                    Expanded(child: _buildConfidenceBtn(check.id, 2, 'Fair', accent, confidence, isDark)),
                    const SizedBox(width: 4),
                    Expanded(child: _buildConfidenceBtn(check.id, 3, 'Solid', const Color(0xFF10B981), confidence, isDark)),
                  ],
                ),
                const SizedBox(height: 10),
                if (!isRevealed)
                  InkWell(
                    onTap: () => _service.revealCheck(check.id),
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Answer honestly, then check ▸',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(isDark ? 0.12 : 0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'MODEL ANSWER & EXPLANATION',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF10B981),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        MathMarkdown(
                          data: check.answerExplanation,
                          selectable: true,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfidenceBtn(String checkId, int score, String label, Color color, int? selected, bool isDark) {
    final isSelected = selected == score;
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        _service.setCheckConfidence(checkId, score);
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : (isDark ? const Color(0xFF1D1D22) : const Color(0xFFFAFAFA)),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? color : (isDark ? const Color(0xFF2E2E36) : const Color(0xFFD5D3CD)),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: isSelected ? color : (isDark ? const Color(0xFF9E9EAC) : const Color(0xFF55555F)),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeSnippetBox(String code, String lang, Color accent, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0D1117) : const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? const Color(0xFF30363D) : const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF161B22) : const Color(0xFF0F172A),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Row(
              children: [
                Text(
                  lang.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'JetBrainsMono',
                    color: accent,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(LucideIcons.copy, size: 14, color: Colors.white70),
                  tooltip: 'Copy code',
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Code copied to clipboard!')),
                    );
                  },
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(LucideIcons.play, size: 14, color: Color(0xFF10B981)),
                  tooltip: 'Run in IDE',
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => UniversalCodeRunnerScreen(
                          existingProject: IdeProject(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            title: 'Code Snippet',
                            type: 'universal',
                            language: lang.isNotEmpty ? lang : 'python',
                            codeContent: code,
                            updatedAt: DateTime.now().millisecondsSinceEpoch,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SelectableText(
              code,
              style: const TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 12,
                color: Color(0xFFE2E8F0),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoneBar(
    TreeTopic topic,
    bool isDone,
    bool isBm,
    Color accent,
    bool isDark,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 4),
      padding: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark ? const Color(0xFF212128) : const Color(0xFFE6E4DF),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // Authentic .cb checkbox matching web app
          InkWell(
            onTap: () {
              HapticFeedback.mediumImpact();
              _service.toggleTopicDone(topic.id);
            },
            borderRadius: BorderRadius.circular(7),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isDone ? const Color(0xFF10B981) : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: isDone
                      ? const Color(0xFF10B981)
                      : (isDark ? const Color(0xFF2E2E36) : const Color(0xFFD5D3CD)),
                  width: 2.0,
                ),
              ),
              alignment: Alignment.center,
              child: isDone
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                _service.toggleTopicDone(topic.id);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isDone ? 'Topic Completed' : 'Mark this topic completed',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: isDone
                          ? (isDark ? const Color(0xFF8B949E) : const Color(0xFF64748B))
                          : (isDark ? Colors.white : const Color(0xFF1A1A1E)),
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    '+15 XP · Tap checkbox to toggle',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'JetBrainsMono',
                      color: isDark ? const Color(0xFF61616E) : const Color(0xFF86858F),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bookmark icon
          IconButton(
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: const EdgeInsets.all(4),
            icon: Icon(
              isBm ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              size: 20,
              color: isBm ? const Color(0xFFF59E0B) : (isDark ? const Color(0xFF8B949E) : const Color(0xFF64748B)),
            ),
            tooltip: isBm ? 'Bookmarked' : 'Bookmark topic',
            onPressed: () => _service.toggleBookmark(topic.id),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // HELPER WIDGETS
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildTickBox({
    required bool isAll,
    required bool isSome,
    required Color accent,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isAll ? const Color(0xFF10B981) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isAll
                ? const Color(0xFF10B981)
                : (isSome ? accent : const Color(0xFF94A3B8)),
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: isAll
            ? const Icon(LucideIcons.check, size: 13, color: Colors.white)
            : (isSome
                ? Container(
                    width: 8,
                    height: 2,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  )
                : null),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.searchX, size: 40, color: Colors.grey),
            const SizedBox(height: 12),
            const Text(
              'No topics match your filter.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              'Try adjusting your search query or disabling the bookmark filter.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
