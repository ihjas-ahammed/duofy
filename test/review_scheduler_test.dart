import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flow/models/app_models.dart';
import 'package:flow/services/metacognition_service.dart';

Slide _slide(String id) =>
    Slide.fromJson({'id': id, 'type': 'quiz', 'content': 'Q?'});

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    MetacognitionService.uidResolver = () => 'test-user';
  });

  final t0 = DateTime(2026, 7, 7, 10);

  test('wrong answer schedules review for tomorrow', () async {
    await MetacognitionService.recordAnswer(
        slide: _slide('s1'), lessonId: 'l1', bookId: 'b1', correct: false, now: t0);

    expect(await MetacognitionService.dueCount(now: t0), 0);
    expect(await MetacognitionService.dueCount(now: t0.add(const Duration(days: 1))), 1);
  });

  test('correct-but-guessing also enters the queue; confident-correct does not',
      () async {
    await MetacognitionService.recordAnswer(
        slide: _slide('g1'),
        lessonId: 'l1',
        bookId: 'b1',
        correct: true,
        confidence: MetacognitionService.confidenceGuessing,
        now: t0);
    await MetacognitionService.recordAnswer(
        slide: _slide('c1'),
        lessonId: 'l1',
        bookId: 'b1',
        correct: true,
        confidence: MetacognitionService.confidenceConfident,
        now: t0);

    final due = await MetacognitionService.dueItems(now: t0.add(const Duration(days: 2)));
    expect(due.map((r) => r.slideId), ['g1']);
  });

  test('correct reviews advance 1 -> 3 -> 7 -> out', () async {
    await MetacognitionService.recordAnswer(
        slide: _slide('s1'), lessonId: 'l1', bookId: 'b1', correct: false, now: t0);

    final day1 = t0.add(const Duration(days: 1));
    await MetacognitionService.recordAnswer(
        slide: _slide('s1'), lessonId: 'l1', bookId: 'b1', correct: true, now: day1);
    var due = await MetacognitionService.dueItems(now: day1.add(const Duration(days: 3)));
    expect(due.single.interval, 3);

    final day4 = day1.add(const Duration(days: 3));
    await MetacognitionService.recordAnswer(
        slide: _slide('s1'), lessonId: 'l1', bookId: 'b1', correct: true, now: day4);
    due = await MetacognitionService.dueItems(now: day4.add(const Duration(days: 7)));
    expect(due.single.interval, 7);

    final day11 = day4.add(const Duration(days: 7));
    await MetacognitionService.recordAnswer(
        slide: _slide('s1'), lessonId: 'l1', bookId: 'b1', correct: true, now: day11);
    expect(await MetacognitionService.dueCount(now: day11.add(const Duration(days: 30))), 0);
  });

  test('a wrong review lapses back to 1 day', () async {
    await MetacognitionService.recordAnswer(
        slide: _slide('s1'), lessonId: 'l1', bookId: 'b1', correct: false, now: t0);
    final day1 = t0.add(const Duration(days: 1));
    await MetacognitionService.recordAnswer(
        slide: _slide('s1'), lessonId: 'l1', bookId: 'b1', correct: true, now: day1);
    // Now at 3-day interval; fail it.
    final day4 = day1.add(const Duration(days: 3));
    await MetacognitionService.recordAnswer(
        slide: _slide('s1'), lessonId: 'l1', bookId: 'b1', correct: false, now: day4);

    final due = await MetacognitionService.dueItems(now: day4.add(const Duration(days: 1)));
    expect(due.single.interval, 1);
    expect(due.single.lapses, 2);
  });

  test('reflections drive the difficulty signal', () async {
    expect(await MetacognitionService.difficultySignal('b1', 'm1'), 'keep');
    await MetacognitionService.recordReflection('b1', 'm1', 'easy');
    await MetacognitionService.recordReflection('b1', 'm1', 'easy');
    expect(await MetacognitionService.difficultySignal('b1', 'm1'), 'harder');

    await MetacognitionService.recordReflection('b1', 'm2', 'confusing');
    await MetacognitionService.recordReflection('b1', 'm2', 'confusing');
    await MetacognitionService.recordReflection('b1', 'm2', 'confusing');
    expect(await MetacognitionService.difficultySignal('b1', 'm2'), 'easier');
  });

  test('calibration stats aggregate confidence vs correctness', () async {
    for (var i = 0; i < 6; i++) {
      await MetacognitionService.recordAnswer(
          slide: _slide('conf$i'),
          lessonId: 'l1',
          bookId: 'b1',
          correct: i < 3, // 3/6 correct while confident
          confidence: MetacognitionService.confidenceConfident,
          now: t0);
    }
    final stats = await MetacognitionService.calibrationStats();
    expect(stats.confidentTotal, 6);
    expect(stats.confidentCorrect, 3);
    expect(stats.confidentAccuracy, 0.5);
  });
}
