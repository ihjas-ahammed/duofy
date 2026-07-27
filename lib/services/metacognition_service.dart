import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_models.dart';
import 'database_service.dart';
import 'fb/fb_auth.dart';
import 'global_state.dart';
import 'guest_service.dart';

/// One first-attempt answer with the learner's self-rated confidence.
/// The confidence-vs-correctness pairing is what powers calibration insights
/// ("you're right 90% of the time you feel unsure — trust yourself more").
class MetacogEvent {
  final String slideId;
  final String lessonId;
  final String bookId;
  final String type;
  final bool correct;

  /// 0 = guessing, 1 = unsure, 2 = confident, null = not rated.
  final int? confidence;
  final int ts;

  const MetacogEvent({
    required this.slideId,
    required this.lessonId,
    required this.bookId,
    required this.type,
    required this.correct,
    required this.confidence,
    required this.ts,
  });

  Map<String, dynamic> toJson() => {
        'slideId': slideId,
        'lessonId': lessonId,
        'bookId': bookId,
        'type': type,
        'correct': correct,
        if (confidence != null) 'confidence': confidence,
        'ts': ts,
      };

  factory MetacogEvent.fromJson(Map<String, dynamic> json) => MetacogEvent(
        slideId: json['slideId']?.toString() ?? '',
        lessonId: json['lessonId']?.toString() ?? '',
        bookId: json['bookId']?.toString() ?? '',
        type: json['type']?.toString() ?? '',
        correct: json['correct'] == true,
        confidence: json['confidence'] is num ? (json['confidence'] as num).toInt() : null,
        ts: json['ts'] is num ? (json['ts'] as num).toInt() : 0,
      );
}

/// A slide waiting in the spaced-review queue (1 → 3 → 7 days, then out).
class ReviewItem {
  final String slideId;
  final String lessonId;
  final String bookId;
  final int due; // epoch ms
  final int interval; // days
  final int lapses;

  const ReviewItem({
    required this.slideId,
    required this.lessonId,
    required this.bookId,
    required this.due,
    required this.interval,
    required this.lapses,
  });

  Map<String, dynamic> toJson() => {
        'lessonId': lessonId,
        'bookId': bookId,
        'due': due,
        'interval': interval,
        'lapses': lapses,
      };

  factory ReviewItem.fromJson(String slideId, Map<String, dynamic> json) => ReviewItem(
        slideId: slideId,
        lessonId: json['lessonId']?.toString() ?? '',
        bookId: json['bookId']?.toString() ?? '',
        due: json['due'] is num ? (json['due'] as num).toInt() : 0,
        interval: json['interval'] is num ? (json['interval'] as num).toInt() : 1,
        lapses: json['lapses'] is num ? (json['lapses'] as num).toInt() : 0,
      );
}

/// Aggregated confidence-vs-correctness numbers for the calibration card.
class CalibrationStats {
  final int confidentTotal, confidentCorrect;
  final int unsureTotal, unsureCorrect;
  final int guessingTotal, guessingCorrect;

  const CalibrationStats({
    required this.confidentTotal,
    required this.confidentCorrect,
    required this.unsureTotal,
    required this.unsureCorrect,
    required this.guessingTotal,
    required this.guessingCorrect,
  });

  int get ratedTotal => confidentTotal + unsureTotal + guessingTotal;
  double? get confidentAccuracy =>
      confidentTotal == 0 ? null : confidentCorrect / confidentTotal;
  double? get unsureAccuracy => unsureTotal == 0 ? null : unsureCorrect / unsureTotal;
  double? get guessingAccuracy =>
      guessingTotal == 0 ? null : guessingCorrect / guessingTotal;

  /// One-line coaching insight derived from the numbers, or null when there
  /// isn't enough data yet.
  String? get insight {
    if (ratedTotal < 10) return null;
    final ca = confidentAccuracy;
    final ua = unsureAccuracy;
    if (ca != null && ca < 0.6) {
      return 'You feel confident more often than you\'re right — slow down before answering.';
    }
    if (ua != null && ua > 0.8) {
      return 'When you feel unsure you\'re still right ${(ua * 100).round()}% of the time — trust yourself more.';
    }
    if (ca != null && ca > 0.85) {
      return 'Well calibrated: your confidence matches your results.';
    }
    return null;
  }
}

/// The real metacognitive loop: confidence ratings on answers → calibration
/// stats, wrong/low-confidence answers → a spaced review queue (1/3/7 days),
/// and one-tap post-lesson reflections → a per-module difficulty signal fed
/// back into generation prompts. Storage follows ProgressService's per-uid
/// SharedPreferences key pattern.
///
/// Deliberately LOCAL-ONLY for now: unlike completed lessons/XP (see
/// LearningSync), a cross-device merge of a spaced-review queue needs real
/// conflict semantics (which device's `due` wins?), so v1 keeps this data on
/// the device rather than syncing it naively.
class MetacognitionService {
  MetacognitionService._();

  static const int confidenceGuessing = 0;
  static const int confidenceUnsure = 1;
  static const int confidenceConfident = 2;

  /// Cap so the event log can't grow unbounded (oldest dropped first).
  static const int _maxEvents = 2000;
  static const List<int> _intervals = [1, 3, 7];

  /// Injectable for unit tests (constructing FbAuth outside a real app
  /// initializes firedart, which throws without Firebase).
  static String Function() uidResolver = _defaultUid;

  static String _defaultUid() {
    try {
      return FbAuth.instance.currentUser?.uid ?? GuestService.instance.guestIdSync;
    } catch (_) {
      return GuestService.instance.guestIdSync;
    }
  }

  static String get _uid => uidResolver();

  static String get eventsKey => 'metacog_events_$_uid';
  static String get reviewKey => 'review_queue_$_uid';
  static String get reflectionsKey => 'module_reflections_$_uid';

  // ---- Answers & review scheduling ----------------------------------------

  /// Records a FIRST-attempt answer (callers must dedupe requeued slides) and
  /// updates the review queue:
  /// - wrong, or correct-while-guessing → due tomorrow (interval 1);
  /// - correct answer to a queued slide → advance 1 → 3 → 7 days, then out;
  /// - wrong answer to a queued slide → lapse, back to 1 day.
  static Future<void> recordAnswer({
    required Slide slide,
    required String lessonId,
    required String bookId,
    required bool correct,
    int? confidence,
    DateTime? now,
  }) async {
    final at = now ?? DateTime.now();
    final prefs = await SharedPreferences.getInstance();

    final events = prefs.getStringList(eventsKey) ?? [];
    events.add(jsonEncode(MetacogEvent(
      slideId: slide.id,
      lessonId: lessonId,
      bookId: bookId,
      type: slide.type,
      correct: correct,
      confidence: confidence,
      ts: at.millisecondsSinceEpoch,
    ).toJson()));
    while (events.length > _maxEvents) {
      events.removeAt(0);
    }
    await prefs.setStringList(eventsKey, events);

    final queue = _readQueue(prefs);
    final existing = queue[slide.id];
    if (existing != null) {
      if (correct) {
        final nextIdx = _intervals.indexOf(existing.interval) + 1;
        if (nextIdx >= _intervals.length || nextIdx <= 0) {
          queue.remove(slide.id); // graduated (or unknown interval) → out
        } else {
          final days = _intervals[nextIdx];
          queue[slide.id] = ReviewItem(
            slideId: slide.id,
            lessonId: existing.lessonId,
            bookId: existing.bookId,
            due: at.add(Duration(days: days)).millisecondsSinceEpoch,
            interval: days,
            lapses: existing.lapses,
          );
        }
      } else {
        queue[slide.id] = ReviewItem(
          slideId: slide.id,
          lessonId: existing.lessonId,
          bookId: existing.bookId,
          due: at.add(const Duration(days: 1)).millisecondsSinceEpoch,
          interval: 1,
          lapses: existing.lapses + 1,
        );
      }
    } else if (!correct || confidence == confidenceGuessing) {
      queue[slide.id] = ReviewItem(
        slideId: slide.id,
        lessonId: lessonId,
        bookId: bookId,
        due: at.add(const Duration(days: 1)).millisecondsSinceEpoch,
        interval: 1,
        lapses: correct ? 0 : 1,
      );
    }
    await _writeQueue(prefs, queue);
    await markSlideReviewedToday(slide.id, now: at);
    GlobalState.bumpProgress();
    push();
  }

  /// Cloud push of metacognition state (events, review queue, reflections).
  static Future<void> push() async {
    try {
      final db = DatabaseService();
      if (GuestService.isGuestId(db.uid) || !await db.isCloudEnabled()) return;
      final prefs = await SharedPreferences.getInstance();
      final events = prefs.getStringList(eventsKey) ?? [];
      final queueMap = _readQueue(prefs);
      final reviewQueue = queueMap.entries
          .map((e) => {
                'slideId': e.key,
                ...e.value.toJson(),
              })
          .toList();
      final reflectionsRaw = prefs.getString(reflectionsKey);
      Map<String, dynamic> reflections = {};
      if (reflectionsRaw != null && reflectionsRaw.isNotEmpty) {
        try {
          reflections = Map<String, dynamic>.from(jsonDecode(reflectionsRaw));
        } catch (_) {}
      }
      await db.saveMetacognitionState(
        events: events,
        reviewQueue: reviewQueue,
        reflections: reflections,
      );
    } catch (_) {
      // Ignore when Firebase is uninitialized (e.g. unit tests or guest)
    }
  }

  /// Cloud pull and merge of metacognition state.
  static Future<bool> pullAndMerge() async {
    try {
      final db = DatabaseService();
      if (GuestService.isGuestId(db.uid) || !await db.isCloudEnabled()) return false;
      final remote = await db.fetchMetacognitionState();
      if (remote == null) return false;

      final prefs = await SharedPreferences.getInstance();
      bool changed = false;

      // Events union
      final localEvents = prefs.getStringList(eventsKey) ?? [];
      final remoteEvents = List<String>.from(remote['events'] ?? []);
      final mergedEvents = {...localEvents, ...remoteEvents}.toList();
      if (mergedEvents.length != localEvents.length) {
        while (mergedEvents.length > _maxEvents) {
          mergedEvents.removeAt(0);
        }
        await prefs.setStringList(eventsKey, mergedEvents);
        changed = true;
      }

      // Review queue merge
      final localQueue = _readQueue(prefs);
      final remoteQueueRaw = List<Map<String, dynamic>>.from(remote['reviewQueue'] ?? []);
      final Map<String, ReviewItem> mergedQueue = {...localQueue};
      for (final r in remoteQueueRaw) {
        final sId = r['slideId']?.toString() ?? '';
        if (sId.isEmpty) continue;
        final remoteItem = ReviewItem.fromJson(sId, r);
        final localItem = localQueue[sId];
        if (localItem == null) {
          mergedQueue[sId] = remoteItem;
          changed = true;
        } else {
          final bestLapses = localItem.lapses > remoteItem.lapses ? localItem.lapses : remoteItem.lapses;
          final bestInterval = localItem.interval > remoteItem.interval ? localItem.interval : remoteItem.interval;
          final bestDue = localItem.due > remoteItem.due ? localItem.due : remoteItem.due;
          mergedQueue[sId] = ReviewItem(
            slideId: sId,
            lessonId: localItem.lessonId.isNotEmpty ? localItem.lessonId : remoteItem.lessonId,
            bookId: localItem.bookId.isNotEmpty ? localItem.bookId : remoteItem.bookId,
            due: bestDue,
            interval: bestInterval,
            lapses: bestLapses,
          );
        }
      }
      if (mergedQueue.length != localQueue.length || changed) {
        await _writeQueue(prefs, mergedQueue);
        changed = true;
      }

      // Module reflections merge
      final localRefRaw = prefs.getString(reflectionsKey);
      Map<String, dynamic> localRef = {};
      if (localRefRaw != null && localRefRaw.isNotEmpty) {
        try {
          localRef = Map<String, dynamic>.from(jsonDecode(localRefRaw));
        } catch (_) {}
      }
      final remoteRef = Map<String, dynamic>.from(remote['reflections'] ?? {});
      final mergedRef = {...remoteRef, ...localRef};
      if (mergedRef.length != localRef.length) {
        await prefs.setString(reflectionsKey, jsonEncode(mergedRef));
        changed = true;
      }

      if (changed) {
        await push();
      }
      return changed;
    } catch (_) {
      return false;
    }
  }

  static String _todayKey([DateTime? now]) {
    final n = now ?? DateTime.now();
    return '${n.year}-${n.month.toString().padLeft(2, '0')}-${n.day.toString().padLeft(2, '0')}';
  }

  static String _reviewedTodayPrefKey([DateTime? now]) => 'smart_review_done_${_uid}_${_todayKey(now)}';

  static Future<Set<String>> getReviewedTodaySlideIds({DateTime? now}) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_reviewedTodayPrefKey(now)) ?? [];
    return list.toSet();
  }

  static Future<void> markSlideReviewedToday(String slideId, {DateTime? now}) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_reviewedTodayPrefKey(now)) ?? [];
    if (!list.contains(slideId)) {
      list.add(slideId);
      await prefs.setStringList(_reviewedTodayPrefKey(now), list);
    }
  }

  static Future<List<ReviewItem>> dueItems({DateTime? now, bool excludeReviewedToday = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final at = (now ?? DateTime.now()).millisecondsSinceEpoch;
    final reviewedToday = excludeReviewedToday ? await getReviewedTodaySlideIds(now: now) : <String>{};

    final due = _readQueue(prefs).values.where((r) {
      if (r.due > at) return false;
      if (excludeReviewedToday && reviewedToday.contains(r.slideId)) return false;
      return true;
    }).toList()
      ..sort((a, b) => a.due.compareTo(b.due));
    return due;
  }

  static Future<int> dueCount({DateTime? now}) async {
    final count = (await dueItems(now: now)).length;
    return count > 5 ? 5 : count;
  }

  /// Resolves due review items to their actual [Slide]s via local storage.
  /// Capped at max 5 slides per Smart Review session.
  static Future<List<Slide>> resolveDueSlides({
    int limit = 5,
    DateTime? now,
    bool shuffle = true,
  }) async {
    final effectiveLimit = limit > 5 ? 5 : limit;
    final due = await dueItems(now: now, excludeReviewedToday: true);
    if (due.isEmpty) return [];

    final candidateItems = List<ReviewItem>.from(due);
    if (shuffle) {
      candidateItems.shuffle();
    }

    final prefs = await SharedPreferences.getInstance();
    final queue = _readQueue(prefs);
    final db = DatabaseService();
    final bookCache = <String, Book?>{};
    final slides = <Slide>[];
    var pruned = false;

    for (final item in candidateItems) {
      if (slides.length >= effectiveLimit) break;
      Book? book;
      if (bookCache.containsKey(item.bookId)) {
        book = bookCache[item.bookId];
      } else {
        try {
          book = await db.getBookFromCache(item.bookId);
        } catch (_) {
          book = null;
        }
        bookCache[item.bookId] = book;
      }

      final slide = book == null ? null : await _findSlideAsync(db, book, item.slideId);
      if (slide == null) {
        if (book == null) {
          queue.remove(item.slideId);
          pruned = true;
        }
        continue;
      }
      slides.add(slide);
    }
    if (pruned) await _writeQueue(prefs, queue);
    return slides;
  }

  static Future<Slide?> _findSlideAsync(DatabaseService db, Book book, String slideId) async {
    for (final m in book.modules) {
      for (final s in m.sections) {
        for (final u in s.units) {
          for (final l in u.lessons) {
            List<Slide> slides = l.slides;
            if (slides.isEmpty) {
              try {
                slides = await db.loadSlidesForLesson(book.id, l.id);
              } catch (_) {
                slides = [];
              }
            }
            for (final slide in slides) {
              if (slide.id == slideId) return slide;
            }
          }
        }
      }
    }
    return null;
  }

  // ---- Reflections → difficulty signal -------------------------------------

  /// One-tap post-lesson reflection: feeling ∈ {easy, right, confusing}.
  static Future<void> recordReflection(String bookId, String moduleId, String feeling) async {
    if (!const {'easy', 'right', 'confusing'}.contains(feeling)) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(reflectionsKey);
    Map<String, dynamic> all = {};
    if (raw != null) {
      try {
        all = Map<String, dynamic>.from(jsonDecode(raw));
      } catch (_) {}
    }
    final key = '$bookId::$moduleId';
    final counts = Map<String, dynamic>.from(all[key] ?? {});
    counts[feeling] = ((counts[feeling] as num?) ?? 0).toInt() + 1;
    all[key] = counts;
    await prefs.setString(reflectionsKey, jsonEncode(all));
    push();
  }

  /// How future generation for this module should lean, from the learner's
  /// own reflections: consistently "too easy" → 'harder'; consistently
  /// "confusing" → 'easier'; otherwise 'keep'.
  static Future<String> difficultySignal(String bookId, String moduleId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(reflectionsKey);
    if (raw == null) return 'keep';
    Map<String, dynamic> all;
    try {
      all = Map<String, dynamic>.from(jsonDecode(raw));
    } catch (_) {
      return 'keep';
    }
    final counts = Map<String, dynamic>.from(all['$bookId::$moduleId'] ?? {});
    final easy = ((counts['easy'] as num?) ?? 0).toInt();
    final confusing = ((counts['confusing'] as num?) ?? 0).toInt();
    if (easy >= 2 && easy > confusing) return 'harder';
    if (confusing >= 2 && confusing > easy) return 'easier';
    return 'keep';
  }

  // ---- Calibration ----------------------------------------------------------

  static Future<CalibrationStats> calibrationStats() async {
    final prefs = await SharedPreferences.getInstance();
    final events = prefs.getStringList(eventsKey) ?? [];
    int ct = 0, cc = 0, ut = 0, uc = 0, gt = 0, gc = 0;
    for (final raw in events) {
      MetacogEvent e;
      try {
        e = MetacogEvent.fromJson(Map<String, dynamic>.from(jsonDecode(raw)));
      } catch (_) {
        continue;
      }
      switch (e.confidence) {
        case confidenceConfident:
          ct++;
          if (e.correct) cc++;
        case confidenceUnsure:
          ut++;
          if (e.correct) uc++;
        case confidenceGuessing:
          gt++;
          if (e.correct) gc++;
        default:
          break;
      }
    }
    return CalibrationStats(
      confidentTotal: ct,
      confidentCorrect: cc,
      unsureTotal: ut,
      unsureCorrect: uc,
      guessingTotal: gt,
      guessingCorrect: gc,
    );
  }

  // ---- Queue storage --------------------------------------------------------

  static Map<String, ReviewItem> _readQueue(SharedPreferences prefs) {
    final raw = prefs.getString(reviewKey);
    if (raw == null) return {};
    try {
      final decoded = Map<String, dynamic>.from(jsonDecode(raw));
      return decoded.map((slideId, v) => MapEntry(
          slideId, ReviewItem.fromJson(slideId, Map<String, dynamic>.from(v))));
    } catch (_) {
      return {};
    }
  }

  static Future<void> _writeQueue(
      SharedPreferences prefs, Map<String, ReviewItem> queue) async {
    await prefs.setString(
        reviewKey, jsonEncode(queue.map((k, v) => MapEntry(k, v.toJson()))));
  }
}