import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/generation_manager.dart';
import '../models/ai_task.dart';
import '../models/app_models.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_center.dart';

class AiQueueScreen extends StatefulWidget {
  const AiQueueScreen({super.key});

  @override
  State<AiQueueScreen> createState() => _AiQueueScreenState();
}

class _AiQueueScreenState extends State<AiQueueScreen> {
  String _scheduleText = 'Auto-schedule: 9:00 PM - 9:00 AM';
  Map<String, Book> _booksMap = {};

  @override
  void initState() {
    super.initState();
    _loadBooksAndSchedule();
  }

  Future<void> _loadBooksAndSchedule() async {
    await _loadScheduleHours();
    try {
      final books = await DatabaseService().fetchBooks(forceRefresh: false);
      if (mounted) {
        setState(() {
          _booksMap = {for (var b in books) b.id: b};
        });
      }
    } catch (e) {
      // Ignore or log error
    }
  }

  Future<void> _loadScheduleHours() async {
    final prefs = await SharedPreferences.getInstance();
    final startHour = prefs.getInt('schedule_start_hour') ?? 21;
    final startMinute = prefs.getInt('schedule_start_minute') ?? 0;
    final endHour = prefs.getInt('schedule_end_hour') ?? 9;
    final endMinute = prefs.getInt('schedule_end_minute') ?? 0;

    String formatTime(int hour, int minute) {
      final period = hour >= 12 ? 'PM' : 'AM';
      final h = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      final m = minute.toString().padLeft(2, '0');
      return '$h:$m $period';
    }

    setState(() {
      _scheduleText = 'Auto-schedule: ${formatTime(startHour, startMinute)} - ${formatTime(endHour, endMinute)}';
    });
  }

  void _showCancelAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Cancel All Tasks?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to cancel all currently running and queued generation tasks? This will stop all active AI generations.', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              GenerationManager.instance.cancelAllTasks();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All tasks cancelled.')),
              );
            },
            child: const Text('Yes, Cancel All', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'book_skeleton':
      case 'book_content':
        return LucideIcons.bookOpen;
      case 'module':
        return LucideIcons.package;
      case 'section':
        return LucideIcons.layers;
      case 'unit':
        return LucideIcons.bookmark;
      case 'manifest':
        return LucideIcons.clipboardList;
      case 'qp':
        return LucideIcons.fileQuestion;
      case 'pyq':
        return LucideIcons.fileSpreadsheet;
      case 'lesson_regen':
      case 'slide_regen':
        return LucideIcons.refreshCw;
      case 'canvas_regen':
        return LucideIcons.image;
      case 'index_scan':
        return LucideIcons.search;
      default:
        return LucideIcons.bot;
    }
  }

  Color _getColorForStatus(String status) {
    switch (status) {
      case 'running':
        return AppTheme.duoBlue;
      case 'queued':
        return AppTheme.duoOrange;
      case 'completed':
        return AppTheme.duoGreen;
      case 'failed':
        return AppTheme.duoRed;
      default:
        return Colors.grey;
    }
  }

  Widget _buildSummaryCard(String title, String count, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white),
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(AiTask task, {bool indented = false}) {
    final statusColor = _getColorForStatus(task.status);
    final taskIcon = _getIconForType(task.type);
    final bool isRunning = task.status == 'running';
    final bool isQueued = task.status == 'queued';

    final card = Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isRunning ? AppTheme.duoBlue.withOpacity(0.3) : Colors.white12, 
          width: isRunning ? 2 : 1
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(taskIcon, color: statusColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                task.status.toUpperCase(),
                                style: TextStyle(color: statusColor, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                              ),
                            ),
                            if (task.isScheduled) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.duoViolet.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(LucideIcons.clock, color: AppTheme.duoViolet, size: 8),
                                    SizedBox(width: 3),
                                    Text(
                                      'SCHEDULED',
                                      style: TextStyle(color: AppTheme.duoViolet, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isRunning || isQueued)
                    IconButton(
                      icon: const Icon(LucideIcons.xCircle, color: Colors.white30, size: 22),
                      onPressed: () {
                        GenerationManager.instance.cancelQueuedTask(task.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Task cancelled.')),
                        );
                      },
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                task.statusMessage,
                style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              if (isRunning && task.progress != null) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: task.progress,
                          backgroundColor: Colors.white10,
                          color: AppTheme.duoBlue,
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${(task.progress! * 100).toInt()}%',
                      style: const TextStyle(color: AppTheme.duoBlue, fontSize: 11, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ],
              if (isQueued && task.isScheduled) ...[
                const SizedBox(height: 8),
                const Text(
                  'Waiting for auto-schedule hours...',
                  style: TextStyle(color: Colors.white38, fontSize: 10, fontStyle: FontStyle.italic),
                ),
              ],
              if (task.status == 'failed' && task.errorMessage != null) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.duoRed.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.duoRed.withOpacity(0.2)),
                  ),
                  child: Text(
                    task.errorMessage!,
                    style: const TextStyle(color: AppTheme.duoRed, fontSize: 11, fontFamily: 'monospace'),
                  ),
                ),
              ],
              if (task.startTime != null && task.endTime != null) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Duration: ${task.endTime!.difference(task.startTime!).inSeconds}s',
                      style: const TextStyle(color: Colors.white30, fontSize: 10),
                    ),
                    Text(
                      'Finished: ${task.endTime!.hour.toString().padLeft(2, '0')}:${task.endTime!.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: Colors.white30, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );

    if (indented) {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: card,
      );
    }
    return card;
  }

  Widget _buildCourseHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.duoBlue.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.duoBlue.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(LucideIcons.bookOpen, color: AppTheme.duoBlue, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleDropdown({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: PageStorageKey<String>('module_$title'),
          leading: const Icon(LucideIcons.package, color: AppTheme.duoBlue, size: 20),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
          iconColor: AppTheme.duoBlue,
          collapsedIconColor: Colors.white54,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          expandedAlignment: Alignment.topLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  Widget _buildSectionDropdown({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: PageStorageKey<String>('section_$title'),
          leading: const Icon(LucideIcons.layers, color: AppTheme.duoViolet, size: 18),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          iconColor: AppTheme.duoViolet,
          collapsedIconColor: Colors.white38,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          expandedAlignment: Alignment.topLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  List<Widget> _buildHierarchicalList(List<AiTask> filteredTasks) {
    if (filteredTasks.isEmpty) {
      return [
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 48.0),
            child: Text(
              'No tasks in this category.',
              style: TextStyle(color: Colors.white30, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ];
    }
    final List<Widget> widgets = [];

    // Group by bookId
    final Map<String, List<AiTask>> tasksByBook = {};
    final List<AiTask> generalTasks = [];

    for (final task in filteredTasks) {
      if (task.bookId.isNotEmpty) {
        tasksByBook.putIfAbsent(task.bookId, () => []).add(task);
      } else {
        generalTasks.add(task);
      }
    }

    // Process each Course group
    tasksByBook.forEach((bookId, bookTasks) {
      final book = _booksMap[bookId];
      final String bookTitle = book?.title ?? 'Course: $bookId';

      widgets.add(_buildCourseHeader(bookTitle));

      if (book == null) {
        // Fallback when book structure isn't loaded: group by moduleId, then sectionId
        final Map<String, List<AiTask>> moduleGroups = {};
        final List<AiTask> noModTasks = [];

        for (final t in bookTasks) {
          if (t.moduleId != null && t.moduleId!.isNotEmpty) {
            moduleGroups.putIfAbsent(t.moduleId!, () => []).add(t);
          } else {
            noModTasks.add(t);
          }
        }

        for (final t in noModTasks) {
          widgets.add(_buildTaskCard(t));
        }

        moduleGroups.forEach((modId, modTasks) {
          final Map<String, List<AiTask>> sectionGroups = {};
          final List<AiTask> noSecTasks = [];

          for (final t in modTasks) {
            if (t.sectionId != null && t.sectionId!.isNotEmpty) {
              sectionGroups.putIfAbsent(t.sectionId!, () => []).add(t);
            } else {
              noSecTasks.add(t);
            }
          }

          final List<Widget> modChildren = [];
          for (final t in noSecTasks) {
            modChildren.add(_buildTaskCard(t));
          }

          sectionGroups.forEach((secId, secTasks) {
            modChildren.add(
              _buildSectionDropdown(
                title: 'Section: $secId',
                children: secTasks.map((t) => _buildTaskCard(t)).toList(),
              ),
            );
          });

          widgets.add(
            _buildModuleDropdown(
              title: 'Module: $modId',
              children: modChildren,
            ),
          );
        });
      } else {
        // Book structure exists
        // 1. Separate book-level tasks
        final List<AiTask> bookLevelTasks = [];
        final Map<String, List<AiTask>> tasksByModule = {};

        for (final t in bookTasks) {
          if (t.moduleId == null || t.moduleId!.isEmpty) {
            bookLevelTasks.add(t);
          } else {
            final hasModule = book.modules.any((m) => m.id == t.moduleId);
            if (hasModule) {
              tasksByModule.putIfAbsent(t.moduleId!, () => []).add(t);
            } else {
              bookLevelTasks.add(t);
            }
          }
        }

        for (final t in bookLevelTasks) {
          widgets.add(_buildTaskCard(t));
        }

        // 2. Traverse modules in book order
        for (final module in book.modules) {
          final modTasks = tasksByModule[module.id];
          if (modTasks == null || modTasks.isEmpty) continue;

          final List<AiTask> moduleLevelTasks = [];
          final Map<String, List<AiTask>> tasksBySection = {};

          for (final t in modTasks) {
            if (t.sectionId == null || t.sectionId!.isEmpty) {
              moduleLevelTasks.add(t);
            } else {
              final hasSection = module.sections.any((s) => s.id == t.sectionId);
              if (hasSection) {
                tasksBySection.putIfAbsent(t.sectionId!, () => []).add(t);
              } else {
                moduleLevelTasks.add(t);
              }
            }
          }

          final List<Widget> moduleChildren = [];
          for (final t in moduleLevelTasks) {
            moduleChildren.add(_buildTaskCard(t));
          }

          // Traverse sections in order
          for (final section in module.sections) {
            final secTasks = tasksBySection[section.id];
            if (secTasks == null || secTasks.isEmpty) continue;

            moduleChildren.add(
              _buildSectionDropdown(
                title: section.title,
                children: secTasks.map((t) => _buildTaskCard(t)).toList(),
              ),
            );
          }

          // Fallback: render section tasks not found in structural sections list
          tasksBySection.forEach((secId, secTasks) {
            final isRendered = module.sections.any((s) => s.id == secId);
            if (!isRendered) {
              moduleChildren.add(
                _buildSectionDropdown(
                  title: 'Section: $secId',
                  children: secTasks.map((t) => _buildTaskCard(t)).toList(),
                ),
              );
            }
          });

          widgets.add(
            _buildModuleDropdown(
              title: module.title,
              children: moduleChildren,
            ),
          );
        }

        // Fallback: render module tasks not found in structural modules list
        tasksByModule.forEach((modId, modTasks) {
          final isRendered = book.modules.any((m) => m.id == modId);
          if (!isRendered) {
            final List<Widget> modChildren = modTasks.map((t) => _buildTaskCard(t)).toList();
            widgets.add(
              _buildModuleDropdown(
                title: 'Module: $modId',
                children: modChildren,
              ),
            );
          }
        });
      }

      widgets.add(const SizedBox(height: 12));
    });

    // Render general tasks group
    if (generalTasks.isNotEmpty) {
      widgets.add(_buildCourseHeader('General & System Tasks'));
      widgets.addAll(generalTasks.map((t) => _buildTaskCard(t)));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: AnimatedBuilder(
        animation: GenerationManager.instance,
        builder: (context, _) {
          final queue = GenerationManager.instance.queue;
          final running = queue.where((t) => t.status == 'running').toList();
          final queued = queue.where((t) => t.status == 'queued').toList();
          final finished = queue.where((t) => t.status == 'completed' || t.status == 'failed').toList();

          return Scaffold(
            backgroundColor: AppTheme.background,
            appBar: AppBar(
              title: const Text('AI Generation Center', style: TextStyle(fontWeight: FontWeight.w900)),
              actions: [
                if (running.isNotEmpty || queued.isNotEmpty)
                  IconButton(
                    icon: const Icon(LucideIcons.ban, size: 20, color: AppTheme.duoRed),
                    tooltip: 'Cancel All Tasks',
                    onPressed: () {
                      _showCancelAllDialog(context);
                    },
                  ),
                if (finished.isNotEmpty)
                  IconButton(
                    icon: const Icon(LucideIcons.trash2, size: 20),
                    tooltip: 'Clear History',
                    onPressed: () {
                      GenerationManager.instance.clearCompletedTasks();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cleared history.')),
                      );
                    },
                  ),
              ],
            ),
            body: ResponsiveCenter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top schedule info banner
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.duoViolet.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.duoViolet.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.calendarClock, color: AppTheme.duoViolet, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _scheduleText,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              const Text(
                                'Scheduled tasks run with lowest priority during these hours.',
                                style: TextStyle(color: Colors.white54, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Live statistics cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        _buildSummaryCard('Running', '${running.length}', LucideIcons.play, AppTheme.duoBlue),
                        const SizedBox(width: 12),
                        _buildSummaryCard('Queued', '${queued.length}', LucideIcons.clock, AppTheme.duoOrange),
                        const SizedBox(width: 12),
                        _buildSummaryCard('History', '${finished.length}', LucideIcons.history, AppTheme.duoGreen),
                      ],
                    ),
                  ),
                  
                  // Tabs for Active / Queued / History
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: TabBar(
                      indicatorColor: AppTheme.duoBlue,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white38,
                      labelStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.8),
                      tabs: [
                        Tab(text: 'ACTIVE'),
                        Tab(text: 'QUEUED'),
                        Tab(text: 'HISTORY'),
                      ],
                    ),
                  ),
                  
                  // Tab contents
                  Expanded(
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ListView(
                          padding: const EdgeInsets.all(16),
                          children: _buildHierarchicalList(running),
                        ),
                        ListView(
                          padding: const EdgeInsets.all(16),
                          children: _buildHierarchicalList(queued),
                        ),
                        ListView(
                          padding: const EdgeInsets.all(16),
                          children: _buildHierarchicalList(finished.reversed.toList()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
