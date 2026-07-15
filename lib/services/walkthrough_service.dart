import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_models.dart';
import 'database_service.dart';

/// Steps of the hands-on first-run tour. The user performs the real taps; the
/// [WalkthroughBanner] shows the instruction for the current step and the
/// screens advance the step as the user acts.
enum WalkStep {
  /// Not running.
  idle,

  /// On Home: guide the user to start creating their first course.
  createCourse,

  /// On the New Material screen: title is pre-filled, guide them to tap create.
  confirmCreate,

  /// Back on Home: the example course now exists, guide them to open it.
  openCourse,

  /// Inside the course: guide them to open the first unit.
  tryUnit,
}

/// Drives the interactive first-run walkthrough: seeds a precreated example
/// course (Basic Algebra by default, or the Python course for programmers) and
/// tracks which coaching step the user is on so every screen can react.
class WalkthroughService {
  WalkthroughService._();
  static final WalkthroughService instance = WalkthroughService._();

  static const String _donePrefsKey = 'walkthrough_done_v1';

  /// Bundled example courses the tour can seed, keyed by a stable slug.
  static const String courseBasicAlgebra = 'basic_algebra';
  static const String coursePython = 'python_programming';

  final ValueNotifier<WalkStep> step = ValueNotifier<WalkStep>(WalkStep.idle);

  /// Which example course this run will seed (set when the tour starts).
  String _courseKey = courseBasicAlgebra;
  String get courseKey => _courseKey;

  /// Title of the course being seeded — used by the New Material screen to
  /// pre-fill the title field and by Home to spotlight the right card.
  String seededTitle = 'Basic Algebra';

  /// Id of the course once seeded, so Home/dashboard can target it.
  String? seededBookId;

  bool get isActive => step.value != WalkStep.idle;

  /// Starts the tour if it hasn't been completed before. [programmer] selects
  /// the Python course branch instead of Basic Algebra.
  Future<void> maybeStart({required bool programmer}) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_donePrefsKey) ?? false) return;
    _courseKey = programmer ? coursePython : courseBasicAlgebra;
    seededTitle = programmer ? 'Python Programming' : 'Basic Algebra';
    seededBookId = null;
    step.value = WalkStep.createCourse;
  }

  void advanceTo(WalkStep next) {
    if (step.value == WalkStep.idle) return; // never resurrect a finished tour
    step.value = next;
  }

  Future<void> finish() async {
    step.value = WalkStep.idle;
    seededBookId = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_donePrefsKey, true);
  }

  /// Whether the tour has been completed (or skipped) already.
  static Future<bool> isDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_donePrefsKey) ?? false;
  }

  /// Builds the example [Book] for the current branch from its bundled JSON,
  /// giving it a unique id so repeat runs never collide, and persists it.
  /// Returns the saved book, or null if seeding failed.
  Future<Book?> seedExampleCourse() async {
    try {
      final asset = 'assets/walkthrough/$_courseKey.json';
      final raw = await rootBundle.loadString(asset);
      final json = jsonDecode(raw) as Map<String, dynamic>;

      // Unique id per run; saveGeneratedBook re-scopes child ids under it.
      final id = '${_courseKey}_${DateTime.now().millisecondsSinceEpoch}';
      json['id'] = id;
      json['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

      final book = Book.fromJson(json);
      await DatabaseService().saveGeneratedBook(book);
      seededBookId = book.id;
      seededTitle = book.title;
      return book;
    } catch (e) {
      debugPrint('[WalkthroughService] seed failed: $e');
      return null;
    }
  }

  /// Instruction shown in the coaching banner for [s].
  static ({String title, String body})? bannerFor(WalkStep s, String title) {
    switch (s) {
      case WalkStep.createCourse:
        return (
          title: 'Create your first course',
          body: 'Tap the + button to start a new course — no PDF needed.',
        );
      case WalkStep.confirmCreate:
        return (
          title: 'We named it “$title”',
          body: 'Just tap Continue — we\'ll build a ready-made example course for you.',
        );
      case WalkStep.openCourse:
        return (
          title: '“$title” is ready!',
          body: 'Open it to see the lessons we generated.',
        );
      case WalkStep.tryUnit:
        return (
          title: 'Try the first unit',
          body: 'Tap Unit 1 and play through a lesson — that\'s all there is to it!',
        );
      case WalkStep.idle:
        return null;
    }
  }
}
