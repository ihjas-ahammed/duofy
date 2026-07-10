import 'package:flutter_test/flutter_test.dart';
import 'package:duofy/models/app_models.dart';

void main() {
  group('new slide types parse defensively', () {
    test('matching slide parses pairs and drops incomplete ones', () {
      final slide = Slide.fromJson({
        'id': 's1',
        'type': 'matching',
        'title': 'Match',
        'content': 'Match each unit.',
        'matchPairs': [
          {'left': 'Force', 'right': 'newton'},
          {'term': 'Energy', 'definition': 'joule'}, // alias keys
          {'left': '', 'right': 'dropped'}, // incomplete → dropped
          'garbage',
        ],
      });
      expect(slide.type, 'matching');
      expect(slide.matchPairs, hasLength(2));
      expect(slide.matchPairs![1].left, 'Energy');
      expect(slide.matchPairs![1].right, 'joule');
    });

    test('ordering slide keeps order and drops empties', () {
      final slide = Slide.fromJson({
        'id': 's2',
        'type': 'ordering',
        'content': 'Arrange.',
        'orderItems': ['first', '', 'second', 'third'],
      });
      expect(slide.orderItems, ['first', 'second', 'third']);
    });

    test('error_spotting slide parses steps and index (also from string)', () {
      final slide = Slide.fromJson({
        'id': 's3',
        'type': 'error_spotting',
        'content': 'Find it.',
        'proofSteps': ['a', 'b', 'c'],
        'errorIndex': '1',
      });
      expect(slide.errorIndex, 1);
      expect(slide.proofSteps, hasLength(3));
    });

    test('flashcard slide uses content/blankAnswer', () {
      final slide = Slide.fromJson({
        'id': 's4',
        'type': 'flashcard',
        'content': 'State the formula.',
        'blankAnswer': 'A = pi r^2',
      });
      expect(slide.type, 'flashcard');
      expect(slide.blankAnswer, 'A = pi r^2');
    });

    test('new fields round-trip through toJson', () {
      final slide = Slide.fromJson({
        'id': 's5',
        'type': 'matching',
        'content': 'c',
        'matchPairs': [
          {'left': 'A', 'right': 'B'}
        ],
        'orderItems': ['x', 'y'],
        'errorIndex': 0,
      });
      final round = Slide.fromJson(slide.toJson());
      expect(round.matchPairs!.single.left, 'A');
      expect(round.orderItems, ['x', 'y']);
      expect(round.errorIndex, 0);
    });

    test('old slides without new fields still parse (null fields)', () {
      final slide = Slide.fromJson({'id': 'legacy', 'type': 'quiz', 'content': 'Q'});
      expect(slide.matchPairs, isNull);
      expect(slide.orderItems, isNull);
      expect(slide.errorIndex, isNull);
    });
  });

  group('quiz option normalization', () {
    test('duplicate option texts collapse, keeping the correct one', () {
      final slide = Slide.fromJson({
        'id': 'q1',
        'type': 'quiz',
        'content': 'Pick one.',
        'options': [
          {'text': 'Paris', 'isCorrect': false},
          {'text': 'paris', 'isCorrect': true}, // dup (case-insensitive)
          {'text': 'London', 'isCorrect': false},
          {'text': 'Rome', 'isCorrect': false},
        ],
      });
      expect(slide.options, hasLength(3));
      final kept = slide.options!.firstWhere((o) => o.text.toLowerCase() == 'paris');
      expect(kept.isCorrect, isTrue);
    });

    test('options get unique positional ids even with identical text hashes', () {
      final slide = Slide.fromJson({
        'id': 'q2',
        'type': 'quiz',
        'content': 'Pick one.',
        'options': ['A', 'B', 'C', 'D'],
      });
      final ids = slide.options!.map((o) => o.id).toSet();
      expect(ids, hasLength(4));
      expect(ids, containsAll(['opt0', 'opt1', 'opt2', 'opt3']));
    });
  });

  group('fill_in_blank blank/answer normalization', () {
    test('surplus blanks are revealed so counts match', () {
      final slide = Slide.fromJson({
        'id': 'f1',
        'type': 'fill_in_blank',
        'content': 'A ___ eats ___ and ___.',
        'blankAnswer': 'cow', // 1 answer, 3 blanks
      });
      expect(RegExp(r'___+').allMatches(slide.content).length, 1);
      expect(slide.blankAnswer, 'cow');
    });

    test('surplus answers are truncated to blank count', () {
      final slide = Slide.fromJson({
        'id': 'f2',
        'type': 'fill_in_blank',
        'content': 'Water is ___ at room temperature.',
        'blankAnswer': 'liquid, wet, clear',
      });
      expect(slide.blankAnswer, 'liquid');
    });

    test('matched multi-blank passes through unchanged', () {
      final slide = Slide.fromJson({
        'id': 'f3',
        'type': 'fill_in_blank',
        'content': 'Force = ___ × ___.',
        'blankAnswer': 'mass, acceleration',
      });
      expect(RegExp(r'___+').allMatches(slide.content).length, 2);
      expect(slide.blankAnswer, 'mass, acceleration');
    });
  });

  group('long theory slides auto-split', () {
    String para(String word, int n) => List.filled(n, word).join(' ');

    test('theory over ~110 words splits into multiple slides', () {
      final lesson = Lesson.fromJson({
        'id': 'l1',
        'title': 'L',
        'description': '',
        'icon': 'BookOpen',
        'slides': [
          {
            'id': 't1',
            'type': 'theory',
            'title': 'T',
            'content': '${para('alpha', 80)}\n\n${para('beta', 80)}',
          },
        ],
      });
      expect(lesson.slides, hasLength(2));
      expect(lesson.slides[0].content, contains('alpha'));
      expect(lesson.slides[1].content, contains('beta'));
      expect(lesson.slides[1].id, isNot(lesson.slides[0].id));
    });

    test('short theory and unsplittable content stay single slides', () {
      final lesson = Lesson.fromJson({
        'id': 'l2',
        'title': 'L',
        'description': '',
        'icon': 'BookOpen',
        'slides': [
          {'id': 't1', 'type': 'theory', 'title': 'T', 'content': para('word', 50)},
          // 200 words but one unbreakable paragraph → left alone
          {'id': 't2', 'type': 'theory', 'title': 'T', 'content': para('word', 200)},
          {'id': 'q1', 'type': 'quiz', 'content': 'Q', 'options': ['a', 'b', 'c', 'd']},
        ],
      });
      expect(lesson.slides, hasLength(3));
    });
  });
}
