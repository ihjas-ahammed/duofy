import 'package:flutter_test/flutter_test.dart';
import 'package:flow/services/page_mapping.dart';

void main() {
  group('computeOffset', () {
    test('front matter shifts printed pages forward', () {
      expect(PageMapping.computeOffset(chapter1AbsPage: 13, chapter1PrintedPage: 1), 12);
    });
    test('chapter 1 not printed as page 1', () {
      expect(PageMapping.computeOffset(chapter1AbsPage: 13, chapter1PrintedPage: 3), 10);
    });
    test('no offset', () {
      expect(PageMapping.computeOffset(chapter1AbsPage: 1, chapter1PrintedPage: 1), 0);
    });
  });

  group('chooseEffectiveOffset', () {
    test('keeps offset when offset interpretation fits better', () {
      final eff = PageMapping.chooseEffectiveOffset([1, 5, 9],
          offset: 12, lo: 13, hi: 36);
      expect(eff, 12);
    });
    test('drops offset when values are already absolute', () {
      final eff = PageMapping.chooseEffectiveOffset([13, 20, 30],
          offset: 12, lo: 13, hi: 36);
      expect(eff, 0);
    });
    test('tie keeps the instructed offset', () {
      final eff = PageMapping.chooseEffectiveOffset([13, 17, 21],
          offset: 12, lo: 13, hi: 36);
      expect(eff, 12);
    });
  });

  group('resolveChapterRanges', () {
    test('applies offset and derives ends, last chapter to totalPages', () {
      final r = PageMapping.resolveChapterRanges([1, 25, 60],
          offset: 12, totalPages: 300);
      expect(r.ranges, [
        (start: 13, end: 36),
        (start: 37, end: 71),
        (start: 72, end: 300),
      ]);
      expect(r.corrections, isEmpty);
    });

    test('interpolates a missing middle start', () {
      final r = PageMapping.resolveChapterRanges([1, null, 60],
          offset: 0, totalPages: 100);
      expect(r.ranges[0].start, 1);
      expect(r.ranges[1].start, 30);
      expect(r.ranges[2], (start: 60, end: 100));
      expect(r.corrections, isNotEmpty);
    });

    test('bumps non-increasing starts', () {
      final r = PageMapping.resolveChapterRanges([10, 5, 20],
          offset: 0, totalPages: 100);
      expect(r.ranges.map((x) => x.start).toList(), [10, 11, 20]);
      expect(r.ranges.last.end, 100);
    });

    test('clamps starts past the end of the PDF', () {
      final r = PageMapping.resolveChapterRanges([1, 500],
          offset: 0, totalPages: 100);
      expect(r.ranges[1], (start: 100, end: 100));
      expect(r.ranges[0].end, 99);
    });

    test('all-null starts spread across the book', () {
      final r = PageMapping.resolveChapterRanges([null, null],
          offset: 0, totalPages: 100);
      expect(r.ranges[0].start, 1);
      expect(r.ranges[1].start, greaterThan(r.ranges[0].start));
      expect(r.ranges[1].end, 100);
    });

    test('single chapter spans everything', () {
      final r = PageMapping.resolveChapterRanges([null],
          offset: 0, totalPages: 40);
      expect(r.ranges.single, (start: 1, end: 40));
    });
  });

  group('resolveSectionRanges', () {
    test('printed sections converted and made contiguous', () {
      final r = PageMapping.resolveSectionRanges(
        [(start: 1, end: null), (start: 5, end: null), (start: 9, end: null)],
        chapterStart: 13,
        chapterEnd: 36,
        offset: 12,
      );
      expect(r.ranges, [
        (start: 13, end: 16),
        (start: 17, end: 20),
        (start: 21, end: 36),
      ]);
    });

    test('detects already-absolute values and skips the offset', () {
      final r = PageMapping.resolveSectionRanges(
        [(start: 13, end: null), (start: 20, end: null), (start: 30, end: null)],
        chapterStart: 13,
        chapterEnd: 36,
        offset: 12,
      );
      expect(r.ranges.first.start, 13);
      expect(r.ranges[1].start, 20);
      expect(r.corrections.any((c) => c.contains('already absolute')), isTrue);
    });

    test('first section is pinned to the chapter start', () {
      final r = PageMapping.resolveSectionRanges(
        [(start: 18, end: null), (start: 25, end: null)],
        chapterStart: 13,
        chapterEnd: 36,
      );
      expect(r.ranges.first.start, 13);
    });

    test('keeps a given end that fits, trims one that overlaps', () {
      final r = PageMapping.resolveSectionRanges(
        [(start: 13, end: 18), (start: 20, end: 50)],
        chapterStart: 13,
        chapterEnd: 30,
      );
      expect(r.ranges[0].end, 18);
      expect(r.ranges[1].end, 30); // forced to chapter end
    });

    test('given end overlapping the next start is replaced by contiguity', () {
      final r = PageMapping.resolveSectionRanges(
        [(start: 13, end: 25), (start: 20, end: null), (start: 26, end: null)],
        chapterStart: 13,
        chapterEnd: 36,
      );
      expect(r.ranges[0].end, 19);
      expect(r.ranges[1].end, 25);
      expect(r.ranges[2].end, 36);
    });

    test('missing middle start interpolates inside the chapter', () {
      final r = PageMapping.resolveSectionRanges(
        [(start: 13, end: null), (start: null, end: null), (start: 25, end: null)],
        chapterStart: 13,
        chapterEnd: 36,
      );
      expect(r.ranges[1].start, 19);
    });

    test('out-of-chapter start is clamped in', () {
      final r = PageMapping.resolveSectionRanges(
        [(start: 13, end: null), (start: 99, end: null)],
        chapterStart: 13,
        chapterEnd: 30,
      );
      expect(r.ranges[1].start, lessThanOrEqualTo(30));
      expect(r.ranges[1].end, 30);
    });
  });

  group('fillMissingSectionBounds', () {
    test('fills an unmapped section between two mapped neighbours', () {
      final out = PageMapping.fillMissingSectionBounds([
        (start: 1, end: 5),
        (start: null, end: null),
        (start: 11, end: 20),
      ]);
      expect(out[1], (start: 6, end: 10));
    });

    test('leaves pure old-flow lists untouched', () {
      final out = PageMapping.fillMissingSectionBounds([
        (start: null, end: null),
        (start: null, end: null),
      ]);
      expect(out[0], (start: null, end: null));
      expect(out[1], (start: null, end: null));
    });
  });

  group('titleMatchScore', () {
    const pageText = '''
      3.2 The Wave Equation
      In this section we derive the one-dimensional wave equation
      from Newton's second law applied to a stretched string.
    ''';

    test('full containment scores 1.0', () {
      expect(PageMapping.titleMatchScore('3.2 The Wave Equation', pageText), 1.0);
    });

    test('partial token overlap scores proportionally', () {
      final s = PageMapping.titleMatchScore('Wave Motion Basics', pageText);
      expect(s, greaterThan(0.0));
      expect(s, lessThan(1.0));
    });

    test('unrelated title scores 0', () {
      expect(PageMapping.titleMatchScore('Organic Chemistry Nomenclature', pageText), 0.0);
    });

    test('numbering and stopwords are ignored', () {
      final tokens = PageMapping.significantTokens('Chapter 4: The Laws of Thermodynamics');
      expect(tokens, contains('thermodynamics'));
      expect(tokens, contains('laws'));
      expect(tokens, isNot(contains('the')));
    });
  });
}
