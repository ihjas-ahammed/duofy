import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tree_reader_models.dart';
import 'global_state.dart';

/// Manages interactive state, progress tracking, and cascading completion
/// for the modern hierarchical dropdown tree reader.
class TreeReaderService extends ChangeNotifier {
  final TreeCourse course;

  final Set<String> _doneTopicIds = {};
  final Set<String> _bookmarkedTopicIds = {};
  final Set<String> _openNodeIds = {};
  final Map<String, int> _checkConfidence = {};
  final Set<String> _revealedChecks = {};
  final Map<String, int> _ladderRevealedStep = {};

  bool _initialized = false;
  bool get isInitialized => _initialized;

  Set<String> get doneTopicIds => Set.unmodifiable(_doneTopicIds);
  Set<String> get bookmarkedTopicIds => Set.unmodifiable(_bookmarkedTopicIds);
  Set<String> get openNodeIds => Set.unmodifiable(_openNodeIds);

  TreeReaderService(this.course) {
    _loadState();
  }

  String get _doneKey => 'tree_done_${course.id}';
  String get _bmKey => 'tree_bm_${course.id}';
  String get _openKey => 'tree_open_${course.id}';

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();

    final savedDone = prefs.getStringList(_doneKey);
    if (savedDone != null) {
      _doneTopicIds.addAll(savedDone);
    }

    final savedBm = prefs.getStringList(_bmKey);
    if (savedBm != null) {
      _bookmarkedTopicIds.addAll(savedBm);
    }

    final savedOpen = prefs.getStringList(_openKey);
    if (savedOpen != null) {
      _openNodeIds.addAll(savedOpen);
    } else {
      // By default all drop-downs start closed
      _openNodeIds.clear();
    }

    _initialized = true;
    notifyListeners();
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_doneKey, _doneTopicIds.toList());
    await prefs.setStringList(_bmKey, _bookmarkedTopicIds.toList());
    await prefs.setStringList(_openKey, _openNodeIds.toList());
  }

  bool isNodeOpen(String nodeId) => _openNodeIds.contains(nodeId);

  void toggleNodeOpen(String nodeId) {
    if (_openNodeIds.contains(nodeId)) {
      _openNodeIds.remove(nodeId);
    } else {
      _openNodeIds.add(nodeId);
    }
    _saveState();
    notifyListeners();
  }

  void expandAll(bool expand) {
    _openNodeIds.clear();
    if (expand) {
      for (final m in course.modules) {
        _openNodeIds.add(m.id);
        for (final s in m.sections) {
          _openNodeIds.add(s.id);
          for (final t in s.topics) {
            _openNodeIds.add(t.id);
          }
        }
      }
    }
    _saveState();
    notifyListeners();
  }

  bool isTopicDone(String topicId) => _doneTopicIds.contains(topicId);

  void toggleTopicDone(String topicId, {bool autoAdvance = true}) {
    final wasDone = _doneTopicIds.contains(topicId);
    if (wasDone) {
      _doneTopicIds.remove(topicId);
    } else {
      _doneTopicIds.add(topicId);
      // Award XP and bump global progress
      GlobalState.addXp(15, course.id);
      GlobalState.bumpProgress();

      // Automatically close current topic tab and open the next one
      if (autoAdvance) {
        _closeAndOpenNextTopic(topicId);
      }
    }
    _saveState();
    notifyListeners();
  }

  void _closeAndOpenNextTopic(String currentTopicId) {
    // 1. Close current topic tab
    _openNodeIds.remove(currentTopicId);

    // 2. Flatten all topics in the course in hierarchical sequence
    final flattened = <({TreeModule module, TreeSection section, TreeTopic topic})>[];
    for (final m in course.modules) {
      for (final s in m.sections) {
        for (final t in s.topics) {
          flattened.add((module: m, section: s, topic: t));
        }
      }
    }

    final currentIdx = flattened.indexWhere((e) => e.topic.id == currentTopicId);
    if (currentIdx != -1 && currentIdx + 1 < flattened.length) {
      final next = flattened[currentIdx + 1];
      // Open the next topic and ensure its parent module & section are open
      _openNodeIds.add(next.module.id);
      _openNodeIds.add(next.section.id);
      _openNodeIds.add(next.topic.id);
    }
  }

  bool isTopicBookmarked(String topicId) => _bookmarkedTopicIds.contains(topicId);

  void toggleBookmark(String topicId) {
    if (_bookmarkedTopicIds.contains(topicId)) {
      _bookmarkedTopicIds.remove(topicId);
    } else {
      _bookmarkedTopicIds.add(topicId);
      GlobalState.bumpBookmarks();
    }
    _saveState();
    notifyListeners();
  }

  // Cascading section toggle:
  // If all topics in section are done, marks all undone.
  // Otherwise, marks all topics done.
  void toggleSectionDone(TreeSection section) {
    final allDone = section.topics.isNotEmpty &&
        section.topics.every((t) => _doneTopicIds.contains(t.id));

    if (allDone) {
      for (final t in section.topics) {
        _doneTopicIds.remove(t.id);
      }
    } else {
      for (final t in section.topics) {
        if (!_doneTopicIds.contains(t.id)) {
          _doneTopicIds.add(t.id);
          GlobalState.addXp(15, course.id);
        }
      }
      GlobalState.bumpProgress();
    }
    _saveState();
    notifyListeners();
  }

  // Cascading module toggle:
  // If all topics in module are done, marks all undone.
  // Otherwise, marks all topics in module done.
  void toggleModuleDone(TreeModule module) {
    final allTopics = module.sections.expand((s) => s.topics).toList();
    final allDone = allTopics.isNotEmpty &&
        allTopics.every((t) => _doneTopicIds.contains(t.id));

    if (allDone) {
      for (final t in allTopics) {
        _doneTopicIds.remove(t.id);
      }
    } else {
      for (final t in allTopics) {
        if (!_doneTopicIds.contains(t.id)) {
          _doneTopicIds.add(t.id);
          GlobalState.addXp(15, course.id);
        }
      }
      GlobalState.bumpProgress();
    }
    _saveState();
    notifyListeners();
  }

  // Progress metrics
  ({int done, int total, bool isAll, bool isSome}) getSectionProgress(TreeSection section) {
    if (section.topics.isEmpty) {
      final done = _doneTopicIds.contains(section.id) ? 1 : 0;
      return (done: done, total: 1, isAll: done == 1, isSome: done == 1);
    }
    final done = section.topics.where((t) => _doneTopicIds.contains(t.id)).length;
    final total = section.topics.length;
    return (
      done: done,
      total: total,
      isAll: total > 0 && done == total,
      isSome: done > 0 && done < total,
    );
  }

  ({int done, int total, bool isAll, bool isSome}) getModuleProgress(TreeModule module) {
    final topics = module.sections.expand((s) => s.topics).toList();
    if (topics.isEmpty) {
      return (done: 0, total: 0, isAll: false, isSome: false);
    }
    final done = topics.where((t) => _doneTopicIds.contains(t.id)).length;
    final total = topics.length;
    return (
      done: done,
      total: total,
      isAll: total > 0 && done == total,
      isSome: done > 0 && done < total,
    );
  }

  ({int done, int total, double percent}) getCourseProgress() {
    final all = course.allTopics;
    if (all.isEmpty) return (done: 0, total: 0, percent: 0.0);
    final done = all.where((t) => _doneTopicIds.contains(t.id)).length;
    final total = all.length;
    return (
      done: done,
      total: total,
      percent: (done / total).clamp(0.0, 1.0),
    );
  }

  // Interactive step ladder state
  int getLadderRevealedStep(String ladderTitle) =>
      _ladderRevealedStep[ladderTitle] ?? 1; // 1st step visible by default

  void revealNextLadderStep(String ladderTitle, int totalRungs) {
    final current = getLadderRevealedStep(ladderTitle);
    if (current < totalRungs) {
      _ladderRevealedStep[ladderTitle] = current + 1;
      notifyListeners();
    }
  }

  void revealAllLadderSteps(String ladderTitle, int totalRungs) {
    _ladderRevealedStep[ladderTitle] = totalRungs;
    notifyListeners();
  }

  void peekLadderStep(String ladderTitle, int stepIndex) {
    final current = getLadderRevealedStep(ladderTitle);
    if (stepIndex + 1 > current) {
      _ladderRevealedStep[ladderTitle] = stepIndex + 1;
      notifyListeners();
    }
  }

  void resetLadderSteps(String ladderTitle) {
    _ladderRevealedStep[ladderTitle] = 1;
    notifyListeners();
  }

  // Interactive self-check state
  int? getCheckConfidence(String checkId) => _checkConfidence[checkId];

  void setCheckConfidence(String checkId, int confidence) {
    _checkConfidence[checkId] = confidence;
    notifyListeners();
  }

  bool isCheckRevealed(String checkId) => _revealedChecks.contains(checkId);

  void revealCheck(String checkId) {
    _revealedChecks.add(checkId);
    notifyListeners();
  }
}
