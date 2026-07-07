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
}
