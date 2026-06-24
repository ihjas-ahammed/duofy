import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/progress_service.dart';
import '../services/database_service.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

class AnalyticsView extends StatefulWidget {
  final String? courseId;

  const AnalyticsView({super.key, this.courseId});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _dataFuture = _fetchAnalyticsData();
  }

  Future<Map<String, dynamic>> _fetchAnalyticsData() async {
    final logs = await ProgressService.getActivityLogs();
    final books = await DatabaseService().fetchBooks(forceRefresh: false);

    // 1. Filter logs
    final filteredLogs = widget.courseId == null
        ? logs
        : logs.where((log) => log['courseId'] == widget.courseId).toList();

    // 2. Fetch XP
    int totalXp = 0;
    if (widget.courseId == null) {
      totalXp = await ProgressService.getXp();
    } else {
      totalXp = await ProgressService.getXpForCourse(widget.courseId!);
    }

    // 3. Compute Streak count
    final activeDates = filteredLogs.map((log) {
      final ts = log['timestamp'] is int ? log['timestamp'] as int : 0;
      return DateTime.fromMillisecondsSinceEpoch(ts);
    }).toList();
    final streak = _calculateStreak(activeDates);

    // 4. Compute Time spent
    final totalTimeSeconds = filteredLogs.fold<int>(0, (sum, log) {
      final seconds = log['timeSpent'] is int ? log['timeSpent'] as int : 0;
      return sum + seconds;
    });

    // 5. Compute Avg accuracy
    final accuracies = filteredLogs.map((log) {
      return log['accuracy'] is int ? log['accuracy'] as int : 100;
    }).toList();
    final avgAccuracy = _calculateAvgAccuracy(accuracies);

    // 6. Last 7 days daily XP
    final now = DateTime.now();
    final Map<String, int> dailyXp = {};
    for (final log in filteredLogs) {
      final ts = log['timestamp'] is int ? log['timestamp'] as int : 0;
      final d = DateTime.fromMillisecondsSinceEpoch(ts);
      final dayStr = "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
      final xpEarned = log['xp'] is int ? log['xp'] as int : 0;
      dailyXp[dayStr] = (dailyXp[dayStr] ?? 0) + xpEarned;
    }

    final List<Map<String, dynamic>> graphData = [];
    final List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    for (int i = 6; i >= 0; i--) {
      final targetDate = now.subtract(Duration(days: i));
      final dayStr = "${targetDate.year}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')}";
      final xp = dailyXp[dayStr] ?? 0;
      graphData.add({
        'day': weekdays[targetDate.weekday - 1],
        'xp': xp,
        'date': dayStr,
      });
    }

    // 7. Course breakdown data (for overall view)
    final List<Map<String, dynamic>> courseStats = [];
    if (widget.courseId == null) {
      for (final book in books) {
        final bookXp = await ProgressService.getXpForCourse(book.id);
        final bookProgress = await ProgressService.getBookProgress(book);
        
        final bookLogs = logs.where((log) => log['courseId'] == book.id);
        final bookAccuracies = bookLogs.map((l) => l['accuracy'] is int ? l['accuracy'] as int : 100).toList();
        final bookAvgAccuracy = _calculateAvgAccuracy(bookAccuracies);

        courseStats.add({
          'book': book,
          'xp': bookXp,
          'progress': bookProgress,
          'accuracy': bookAvgAccuracy,
        });
      }
    }

    return {
      'totalXp': totalXp,
      'streak': streak,
      'timeSpent': totalTimeSeconds,
      'accuracy': avgAccuracy,
      'graphData': graphData,
      'courseStats': courseStats,
      'logs': filteredLogs.reversed.toList(), // show newest first
    };
  }

  int _calculateStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    
    final dateSet = dates.map((d) => "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}").toSet();
    final now = DateTime.now();
    
    String formatDate(DateTime d) {
      return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
    }
    
    final todayStr = formatDate(now);
    final yesterdayStr = formatDate(now.subtract(const Duration(days: 1)));
    
    if (!dateSet.contains(todayStr) && !dateSet.contains(yesterdayStr)) {
      return 0;
    }
    
    int streak = 0;
    DateTime checkDate = dateSet.contains(todayStr) ? now : now.subtract(const Duration(days: 1));
    
    while (true) {
      final checkStr = formatDate(checkDate);
      if (dateSet.contains(checkStr)) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    
    return streak;
  }

  int _calculateAvgAccuracy(List<int> accuracies) {
    if (accuracies.isEmpty) return 100;
    final sum = accuracies.reduce((a, b) => a + b);
    return (sum / accuracies.length).round();
  }

  String _formatTimeSpent(int seconds) {
    if (seconds < 60) {
      return "${seconds}s";
    }
    final minutes = seconds ~/ 60;
    if (minutes < 60) {
      final remainingSecs = seconds % 60;
      return "${minutes}m ${remainingSecs}s";
    }
    final hours = minutes ~/ 60;
    final remainingMins = minutes % 60;
    return "${hours}h ${remainingMins}m";
  }

  String _formatDateString(dynamic timestamp) {
    if (timestamp == null) return '';
    final d = DateTime.fromMillisecondsSinceEpoch(timestamp is int ? timestamp : int.parse(timestamp.toString()));
    final monthStr = d.month.toString().padLeft(2, '0');
    final dayStr = d.day.toString().padLeft(2, '0');
    final hourStr = d.hour.toString().padLeft(2, '0');
    final minStr = d.minute.toString().padLeft(2, '0');
    return "$monthStr-$dayStr $hourStr:$minStr";
  }

  IconData _getBookIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'atom':
        return LucideIcons.atom;
      case 'bookopen':
      case 'book-open':
        return LucideIcons.bookOpen;
      case 'sun':
        return LucideIcons.sun;
      case 'graduationcap':
      case 'graduation-cap':
        return LucideIcons.graduationCap;
      case 'landmark':
        return LucideIcons.landmark;
      default:
        return LucideIcons.book;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppTheme.duoBlue));
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading analytics: ${snapshot.error}',
              style: const TextStyle(color: Colors.white70),
            ),
          );
        }

        final data = snapshot.data!;
        final int totalXp = data['totalXp'];
        final int streak = data['streak'];
        final int timeSpent = data['timeSpent'];
        final int accuracy = data['accuracy'];
        final List<Map<String, dynamic>> graphData = data['graphData'];
        final List<Map<String, dynamic>> courseStats = data['courseStats'];
        final List<dynamic> logs = data['logs'];

        // Determine max XP in graph to scale height
        final maxXP = graphData.map((d) => d['xp'] as int).fold<int>(20, (max, xp) => xp > max ? xp : max);

        return RefreshIndicator(
          color: AppTheme.duoBlue,
          onRefresh: () async {
            setState(() {
              _loadData();
            });
          },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  // Header Card
                  AppTheme.applyGlassBlur(
                    borderRadius: 24,
                    color: Colors.black.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.duoBlue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppTheme.duoBlue.withOpacity(0.3)),
                            ),
                            child: const Icon(LucideIcons.barChart2, color: AppTheme.duoBlue, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.courseId == null ? 'OVERALL PERFORMANCE' : 'COURSE PERFORMANCE',
                                  style: const TextStyle(
                                    color: AppTheme.duoBlue,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 10,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.courseId == null ? 'Your Learning Analytics' : 'Course Progress Stats',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Stats Grid (2x2)
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.4,
                    children: [
                      _buildStatCard(
                        title: 'STREAK COUNT',
                        value: '$streak Days',
                        icon: LucideIcons.flame,
                        iconColor: AppTheme.duoOrange,
                        glowColor: AppTheme.duoOrange.withOpacity(0.15),
                      ),
                      _buildStatCard(
                        title: 'TIME SPENT',
                        value: _formatTimeSpent(timeSpent),
                        icon: LucideIcons.clock,
                        iconColor: AppTheme.duoBlue,
                        glowColor: AppTheme.duoBlue.withOpacity(0.15),
                      ),
                      _buildStatCard(
                        title: 'AVG ACCURACY',
                        value: '$accuracy%',
                        icon: LucideIcons.target,
                        iconColor: AppTheme.duoGreen,
                        glowColor: AppTheme.duoGreen.withOpacity(0.15),
                      ),
                      _buildStatCard(
                        title: 'TOTAL XP',
                        value: '$totalXp XP',
                        icon: LucideIcons.zap,
                        iconColor: const Color(0xFFFBBF24),
                        glowColor: const Color(0xFFFBBF24).withOpacity(0.15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Last 7 Days XP Graph Card
                  AppTheme.applyGlassBlur(
                    borderRadius: 24,
                    color: Colors.black.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'XP ACTIVITY (LAST 7 DAYS)',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Icon(LucideIcons.activity, color: Colors.white54, size: 16),
                            ],
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: graphData.map((d) {
                                final xp = d['xp'] as int;
                                final dayStr = d['day'] as String;
                                final double percentHeight = xp / maxXP;
                                // Constrain height between 6 (for 0 XP) and 110 pixels
                                final double barHeight = (percentHeight * 110).clamp(6.0, 110.0);

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (xp > 0)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          '$xp',
                                          style: const TextStyle(
                                            color: Color(0xFFFBBF24),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    Container(
                                      width: 18,
                                      height: barHeight,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: xp > 0
                                              ? [
                                                  AppTheme.duoBlue.withOpacity(0.8),
                                                  AppTheme.duoViolet.withOpacity(0.9),
                                                ]
                                              : [
                                                  Colors.white.withOpacity(0.05),
                                                  Colors.white.withOpacity(0.1),
                                                ],
                                        ),
                                        boxShadow: xp > 0
                                            ? [
                                                BoxShadow(
                                                  color: AppTheme.duoBlue.withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 2),
                                                )
                                              ]
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      dayStr,
                                      style: TextStyle(
                                        color: xp > 0 ? Colors.white : Colors.white38,
                                        fontWeight: xp > 0 ? FontWeight.bold : FontWeight.normal,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Section 3: Course Breakdown (overall) OR Activity Logs (course-specific)
                  if (widget.courseId == null) ...[
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 12),
                      child: Text(
                        'COURSE BREAKDOWN',
                        style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    if (courseStats.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        alignment: Alignment.center,
                        child: const Text('No courses found in library.', style: TextStyle(color: Colors.white38)),
                      )
                    else
                      ...courseStats.map((stat) {
                        final Book book = stat['book'];
                        final int xp = stat['xp'];
                        final double progress = stat['progress'];
                        final int acc = stat['accuracy'];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: AppTheme.applyGlassBlur(
                            borderRadius: 20,
                            color: Colors.black.withOpacity(0.25),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.06),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Icon(_getBookIcon(book.icon), color: Colors.white, size: 20),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              book.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Accuracy: $acc%  •  XP: $xp',
                                              style: const TextStyle(
                                                color: Colors.white54,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${(progress * 100).round()}%',
                                        style: const TextStyle(
                                          color: AppTheme.duoBlue,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 6,
                                      backgroundColor: Colors.white12,
                                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.duoBlue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                  ] else ...[
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 12),
                      child: Text(
                        'RECENT ACTIVITY LOGS',
                        style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    if (logs.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        alignment: Alignment.center,
                        child: const Text('No activities completed in this course yet.', style: TextStyle(color: Colors.white38)),
                      )
                    else
                      ...logs.take(15).map((log) {
                        final String actType = log['activityType'] ?? 'lesson';
                        final int xpEarned = log['xp'] ?? 0;
                        final int timeSec = log['timeSpent'] ?? 0;
                        final int acc = log['accuracy'] ?? 100;
                        final String dateStr = _formatDateString(log['timestamp']);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: AppTheme.applyGlassBlur(
                            borderRadius: 16,
                            color: Colors.black.withOpacity(0.25),
                            child: ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: actType == 'practice'
                                      ? AppTheme.duoViolet.withOpacity(0.15)
                                      : AppTheme.duoGreen.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  actType == 'practice' ? LucideIcons.dumbbell : LucideIcons.bookOpen,
                                  color: actType == 'practice' ? AppTheme.duoViolet : AppTheme.duoGreen,
                                  size: 18,
                                ),
                              ),
                              title: Text(
                                actType == 'practice' ? 'Practice Arena' : 'Lesson Completed',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              subtitle: Text(
                                '$dateStr  •  Acc: $acc%  •  Time: ${_formatTimeSpent(timeSec)}',
                                style: const TextStyle(color: Colors.white54, fontSize: 11),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBBF24).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '+$xpEarned XP',
                                  style: const TextStyle(
                                    color: Color(0xFFFBBF24),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                  ],
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color glowColor,
  }) {
    return AppTheme.applyGlassBlur(
      borderRadius: 20,
      color: Colors.black.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontWeight: FontWeight.w900,
                    fontSize: 9,
                    letterSpacing: 0.8,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: glowColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 14),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  width: 24,
                  height: 2,
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
