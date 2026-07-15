import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flow/models/app_models.dart';

/// Guards the precreated walkthrough course: it must parse cleanly through the
/// real model layer and keep demonstrating every slide type, so the first-run
/// tour never lands the user on a broken lesson.
void main() {
  // Every interactive slide type the lesson renderer can dispatch.
  const expectedTypes = {
    'theory',
    'concept_pieces',
    'flashcard',
    'quiz',
    'descriptive',
    'step_by_step',
    'proof',
    'error_spotting',
    'fill_in_blank',
    'one_word',
    'numerical',
    'matching',
    'ordering',
    'custom_html',
  };

  test('Basic Algebra example parses and covers all slide types', () {
    final raw =
        File('assets/walkthrough/basic_algebra.json').readAsStringSync();
    final book = Book.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    // Structure: a single unit the tour tells the user to try.
    expect(book.title, 'Basic Algebra');
    expect(book.modules, isNotEmpty);
    final section = book.modules.first.sections.first;
    expect(section.units, isNotEmpty);
    final unit = section.units.first;
    // Old-flow baked-in unit: lessons must be immediately playable (no gating).
    expect(section.needsUnitManifest, isFalse);
    expect(section.needsFormatConfirmation, isFalse);
    expect(unit.lessons, isNotEmpty);

    final slides = [
      for (final l in unit.lessons) ...l.slides,
    ];
    final types = slides.map((s) => s.type).toSet();
    expect(types, containsAll(expectedTypes));

    // Spot-check the interactive slides carry the data their views require.
    final quiz = slides.firstWhere((s) => s.type == 'quiz');
    expect(quiz.options!.where((o) => o.isCorrect).length, 1);

    final numeric = slides.firstWhere((s) => s.type == 'numerical');
    expect(numeric.numericAnswer, isNotNull);

    final matching = slides.firstWhere((s) => s.type == 'matching');
    expect(matching.matchPairs, isNotEmpty);

    final ordering = slides.firstWhere((s) => s.type == 'ordering');
    expect(ordering.orderItems, isNotEmpty);

    final errorSpot = slides.firstWhere((s) => s.type == 'error_spotting');
    expect(errorSpot.proofSteps, isNotEmpty);
    expect(errorSpot.errorIndex, isNotNull);
    expect(errorSpot.errorIndex! < errorSpot.proofSteps!.length, isTrue);

    final proof = slides.firstWhere((s) => s.type == 'proof');
    expect(proof.interactiveSteps, isNotEmpty);
  });

  test('Python example parses with runnable program & try-yourself slides', () {
    final raw =
        File('assets/walkthrough/python_programming.json').readAsStringSync();
    final book = Book.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    expect(book.title, 'Python Programming');
    final unit = book.modules.first.sections.first.units.first;
    final slides = [for (final l in unit.lessons) ...l.slides];

    // A fill-in `program` slide: highlighted code with a blank + an answer.
    final program = slides.firstWhere((s) => s.type == 'program');
    expect(program.language, 'python');
    expect(program.code, contains('___'));
    expect(program.blankAnswer, isNotEmpty);

    // A `try_yourself` runner slide with starter code.
    final runner = slides.firstWhere((s) => s.type == 'try_yourself');
    expect(runner.language, 'python');
    expect(runner.code, isNotNull);
    expect(runner.code!.trim(), isNotEmpty);

    // At least one runner preloads data-science packages.
    expect(
      slides.any((s) => (s.packages ?? const []).contains('numpy')),
      isTrue,
    );
  });
}
