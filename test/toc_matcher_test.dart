import 'package:flutter_test/flutter_test.dart';
import 'package:flow/services/toc_matcher.dart';

const tocWithNumbers = '''
CONTENTS

Chapter 1 Introduction to Botany .................. 1
Chapter 2 Cell Structure and Function ............. 25
Chapter 3 Photosynthesis .......................... 58
Chapter 4 Plant Genetics .......................... 90
Chapter 5 Ecology and Environment ................. 122
''';

const tocContinuation = '''
Chapter 6 Reproduction in Plants .................. 150
Chapter 7 Plant Hormones .......................... 176
Chapter 8 Economic Botany ......................... 201
Appendix A Glossary ............................... 230
Index ............................................. 245
''';

const tocWithoutNumbers = '''
CONTENTS

Chapter 1 Introduction to Botany
Chapter 2 Cell Structure and Function
Chapter 3 Photosynthesis
Chapter 4 Plant Genetics
''';

const chapter1Page = '''
CHAPTER 1
Introduction to Botany

Botany is the scientific study of plants. Plants are essential to life on
Earth, providing oxygen, food, and shelter for countless organisms. The
field of botany covers a wide range of topics including plant anatomy,
physiology, and taxonomy.
''';

const prosePage = '''
The process of photosynthesis converts light energy into chemical energy.
This remarkable mechanism evolved over billions of years and sustains
nearly all life on our planet. Water and carbon dioxide are transformed
into glucose and oxygen inside the chloroplasts of plant cells.
''';

void main() {
  group('tocScore', () {
    test('TOC page with heading and page numbers scores at/above threshold', () {
      expect(TocMatcher.tocScore(tocWithNumbers),
          greaterThanOrEqualTo(TocMatcher.tocThreshold));
    });

    test('TOC continuation page (no heading) still reaches threshold', () {
      expect(TocMatcher.tocScore(tocContinuation),
          greaterThanOrEqualTo(TocMatcher.tocThreshold));
    });

    test('TOC without printed page numbers reaches threshold', () {
      expect(TocMatcher.tocScore(tocWithoutNumbers),
          greaterThanOrEqualTo(TocMatcher.tocThreshold));
    });

    test('chapter content page scores below threshold', () {
      expect(TocMatcher.tocScore(chapter1Page),
          lessThan(TocMatcher.tocThreshold));
    });

    test('prose page scores below threshold', () {
      expect(TocMatcher.tocScore(prosePage),
          lessThan(TocMatcher.tocThreshold));
    });

    test('empty page scores zero', () {
      expect(TocMatcher.tocScore(''), 0.0);
    });
  });

  group('isChapterStart', () {
    test('detects CHAPTER 1 heading page', () {
      expect(TocMatcher.isChapterStart(chapter1Page), isTrue);
    });

    test('detects roman-numeral chapter heading', () {
      expect(TocMatcher.isChapterStart('Chapter I\nThe Beginning\nSome text.'),
          isTrue);
    });

    test('detects numbered-heading style "1. Introduction"', () {
      expect(
          TocMatcher.isChapterStart('1. Introduction\nWelcome to the course.'),
          isTrue);
    });

    test('does not fire on a TOC page (lines end with page numbers)', () {
      expect(TocMatcher.isChapterStart(tocWithNumbers), isFalse);
    });

    test('does not fire on plain prose', () {
      expect(TocMatcher.isChapterStart(prosePage), isFalse);
    });

    test('respects chapterNumber argument', () {
      expect(
          TocMatcher.isChapterStart('Chapter 2\nCells\nText.',
              chapterNumber: 2),
          isTrue);
      expect(TocMatcher.isChapterStart(chapter1Page, chapterNumber: 2),
          isFalse);
    });
  });

  group('hasPrintedPageNumbers', () {
    test('true for a TOC whose lines end in page numbers', () {
      expect(TocMatcher.hasPrintedPageNumbers(tocWithNumbers), isTrue);
    });

    test('false for a TOC without page numbers', () {
      expect(TocMatcher.hasPrintedPageNumbers(tocWithoutNumbers), isFalse);
    });

    test('false for empty text', () {
      expect(TocMatcher.hasPrintedPageNumbers(''), isFalse);
    });
  });

  test('heading table has ~100 entries', () {
    expect(TocMatcher.tocHeadings.length, greaterThanOrEqualTo(90));
  });
}
