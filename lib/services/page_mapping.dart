import 'dart:math' as math;

/// A resolved 1-based, inclusive absolute PDF page range.
typedef PageRange = ({int start, int end});

/// Result of a range-resolution pass: the ranges plus human-readable notes
/// for every correction that was applied (clamps, reorders, fills), so
/// callers can log or surface exactly what the resolver changed.
class ResolvedRanges {
  final List<PageRange> ranges;
  final List<String> corrections;
  const ResolvedRanges(this.ranges, this.corrections);
}

/// Deterministic printed→absolute page arithmetic for skeleton generation.
/// Pure Dart: no AI, no I/O (mirrors [TocMatcher]'s design).
///
/// The AI models are only asked to READ page numbers exactly as printed in
/// a book's TOC; everything else — offset conversion, end-page derivation,
/// ordering, clamping, gap-filling — happens here, in code, so a weak model
/// can no longer shift or scramble the contents→pages mapping.
class PageMapping {
  PageMapping._();

  /// The offset added to a printed TOC page number to get the absolute
  /// 1-based PDF page. Derived from the one anchor the user (or the
  /// auto-indexer) supplies: where chapter 1 actually starts in the PDF
  /// versus the page number the TOC prints for it. Handles books whose
  /// chapter 1 is NOT printed page 1.
  static int computeOffset({
    required int chapter1AbsPage,
    required int chapter1PrintedPage,
  }) =>
      chapter1AbsPage - chapter1PrintedPage;

  /// Decides whether AI-reported page values are printed numbers (apply
  /// [offset]) or were emitted as absolute positions despite instructions
  /// (apply 0). Picks the interpretation that lands the most values inside
  /// [lo, hi]; ties keep the offset (the instructed behaviour).
  static int chooseEffectiveOffset(
    List<int?> values, {
    required int offset,
    required int lo,
    required int hi,
  }) {
    if (offset == 0) return 0;
    int inWithOffset = 0, inAsIs = 0;
    for (final v in values) {
      if (v == null) continue;
      if (v + offset >= lo && v + offset <= hi) inWithOffset++;
      if (v >= lo && v <= hi) inAsIs++;
    }
    return inAsIs > inWithOffset ? 0 : offset;
  }

  /// Resolves chapter ranges for ONE source book from the printed start
  /// pages the model read out of the TOC.
  ///
  /// - applies [offset] to every printed number,
  /// - fills missing starts by spreading between known neighbours,
  /// - enforces strictly increasing starts (bumping violators),
  /// - clamps everything to `[1, totalPages]`,
  /// - derives ends: one page before the next chapter; the LAST chapter
  ///   runs to [totalPages] (no more `start + 9` guessing).
  static ResolvedRanges resolveChapterRanges(
    List<int?> printedStarts, {
    required int offset,
    required int totalPages,
  }) {
    final n = printedStarts.length;
    if (n == 0) return const ResolvedRanges([], []);
    final notes = <String>[];
    final total = math.max(1, totalPages);

    final starts = List<int?>.generate(
        n, (i) => printedStarts[i] == null ? null : printedStarts[i]! + offset);
    _fillMissingStarts(starts, lo: 1, hi: total, notes: notes, label: 'chapter');
    _enforceIncreasing(starts, lo: 1, hi: total, notes: notes, label: 'chapter');

    final ranges = <PageRange>[];
    for (var i = 0; i < n; i++) {
      final start = starts[i]!;
      var end = i + 1 < n ? starts[i + 1]! - 1 : total;
      if (end < start) {
        notes.add('chapter ${i + 1}: inverted range fixed ($start-$end → $start-$start)');
        end = start;
      }
      ranges.add((start: start, end: end));
    }
    return ResolvedRanges(ranges, notes);
  }

  /// Resolves section ranges INSIDE one chapter from printed starts (already
  /// converted or convertible via [offset]) and optional given ends.
  ///
  /// Order is preserved (TOC order is meaning-bearing); out-of-order or
  /// out-of-chapter starts are clamped/bumped instead of re-sorted. Ends are
  /// contiguity-derived — a given end survives only when it fits between its
  /// own start and the next section's start. The last section always runs to
  /// the chapter end so trailing content (e.g. end-of-chapter problems) is
  /// never dropped, and a null end no longer causes the splitter to skip the
  /// section.
  static ResolvedRanges resolveSectionRanges(
    List<({int? start, int? end})> given, {
    required int chapterStart,
    required int chapterEnd,
    int offset = 0,
  }) {
    final n = given.length;
    if (n == 0) return const ResolvedRanges([], []);
    final notes = <String>[];
    final lo = math.min(chapterStart, chapterEnd);
    final hi = math.max(chapterStart, chapterEnd);

    final rawStarts = [for (final g in given) g.start];
    final eff = chooseEffectiveOffset(rawStarts, offset: offset, lo: lo, hi: hi);
    if (eff != offset) {
      notes.add('sections: values already absolute, offset $offset not applied');
    }

    final starts = List<int?>.generate(
        n, (i) => rawStarts[i] == null ? null : rawStarts[i]! + eff);
    for (var i = 0; i < n; i++) {
      final s = starts[i];
      if (s != null && (s < lo || s > hi)) {
        final clamped = s.clamp(lo, hi);
        notes.add('section ${i + 1}: start $s outside chapter [$lo,$hi], clamped to $clamped');
        starts[i] = clamped;
      }
    }
    starts[0] ??= lo;
    if (starts[0] != lo) {
      notes.add('section 1: start ${starts[0]} pulled back to chapter start $lo');
      starts[0] = lo;
    }
    _fillMissingStarts(starts, lo: lo, hi: hi, notes: notes, label: 'section');
    _enforceIncreasing(starts, lo: lo, hi: hi, notes: notes, label: 'section');

    final ranges = <PageRange>[];
    for (var i = 0; i < n; i++) {
      final start = starts[i]!;
      final nextStart = i + 1 < n ? starts[i + 1]! : null;
      var end = i + 1 < n ? nextStart! - 1 : hi;
      final givenEnd = given[i].end == null ? null : given[i].end! + eff;
      if (i + 1 < n &&
          givenEnd != null &&
          givenEnd >= start &&
          givenEnd < nextStart!) {
        end = givenEnd;
      }
      if (end < start) end = start;
      ranges.add((start: start, end: end));
    }
    return ResolvedRanges(ranges, notes);
  }

  /// Fills null bounds of a mixed section list from its neighbours (previous
  /// end + 1 / next start − 1) so the splitter never silently skips a section
  /// that sits between two mapped ones. Returns null entries unchanged when
  /// nothing can be inferred (pure old-flow lists stay untouched).
  static List<({int? start, int? end})> fillMissingSectionBounds(
      List<({int? start, int? end})> sections) {
    final out = List<({int? start, int? end})>.from(sections);
    for (var i = 0; i < out.length; i++) {
      var (:start, :end) = out[i];
      if (start == null) {
        final prevEnd = i > 0 ? out[i - 1].end : null;
        if (prevEnd != null) start = prevEnd + 1;
      }
      if (end == null && start != null) {
        final nextStart = i + 1 < out.length ? out[i + 1].start : null;
        if (nextStart != null && nextStart > start) end = nextStart - 1;
      }
      if (end != null && start != null && end < start) end = start;
      out[i] = (start: start, end: end);
    }
    return out;
  }

  // ---- Title matching (used by MappingVerifier) ---------------------------

  static final RegExp _leadingNumbering = RegExp(
      r'^\s*((chapter|unit|module|lesson|part|section)\s+)?[0-9ivxlc]{1,7}([\.\-][0-9]{1,3})*[\.\):]?\s+',
      caseSensitive: false);
  static final RegExp _nonWord = RegExp(r'[^a-z0-9]+');
  static const Set<String> _stopwords = {
    'the', 'and', 'for', 'with', 'from', 'into', 'onto',
    'that', 'this', 'are', 'was', 'were', 'its', 'their',
  };

  /// Score in [0, 1]: the fraction of a title's significant tokens present in
  /// the page text. Used to check "does the page we mapped this section to
  /// actually open that section?" without any AI call. A full-title
  /// containment shortcuts to 1.0.
  static double titleMatchScore(String title, String pageText) {
    final tokens = significantTokens(title);
    if (tokens.isEmpty) return 0.0;
    final text = ' ${_normalize(pageText)} ';
    if (tokens.length > 1 && text.contains(' ${tokens.join(' ')} ')) return 1.0;
    var hits = 0;
    for (final t in tokens) {
      // Loose containment so "equation" still hits "equations".
      if (text.contains(t)) hits++;
    }
    return hits / tokens.length;
  }

  /// Meaning-bearing tokens of a heading: lowercased, leading "3.2" /
  /// "Chapter 4:" numbering stripped, stopwords and short tokens dropped.
  /// Falls back to every token ≥3 chars for titles made only of stopwords.
  static List<String> significantTokens(String title) {
    final stripped = title.replaceFirst(_leadingNumbering, '');
    final all = _normalize(stripped)
        .split(' ')
        .where((t) => t.length >= 3)
        .toList();
    final significant =
        all.where((t) => !_stopwords.contains(t)).toSet().toList();
    return significant.isNotEmpty ? significant : all.toSet().toList();
  }

  static String _normalize(String s) =>
      s.toLowerCase().replaceAll(_nonWord, ' ').replaceAll(RegExp(r'\s+'), ' ').trim();

  // ---- Internals -----------------------------------------------------------

  /// Fills null starts: interior runs spread evenly between known
  /// neighbours; leading runs back-fill just before the first known start;
  /// trailing runs step forward from the last known start. An all-null list
  /// spreads evenly across [lo, hi].
  static void _fillMissingStarts(
    List<int?> starts, {
    required int lo,
    required int hi,
    required List<String> notes,
    required String label,
  }) {
    final n = starts.length;
    final knownIdx = [for (var i = 0; i < n; i++) if (starts[i] != null) i];
    if (knownIdx.isEmpty) {
      for (var i = 0; i < n; i++) {
        starts[i] = lo + ((hi - lo) * i / n).floor();
      }
      notes.add('$label starts all missing: spread evenly across [$lo,$hi]');
      return;
    }
    final first = knownIdx.first;
    for (var i = first - 1; i >= 0; i--) {
      starts[i] = math.max(lo, starts[i + 1]! - 1);
      notes.add('$label ${i + 1}: missing start back-filled to ${starts[i]}');
    }
    for (var k = 0; k < knownIdx.length - 1; k++) {
      final a = knownIdx[k], b = knownIdx[k + 1];
      final gap = b - a;
      if (gap <= 1) continue;
      final span = starts[b]! - starts[a]!;
      for (var j = 1; j < gap; j++) {
        starts[a + j] = starts[a]! + (span * j / gap).floor();
        notes.add('$label ${a + j + 1}: missing start interpolated to ${starts[a + j]}');
      }
    }
    final last = knownIdx.last;
    for (var i = last + 1; i < n; i++) {
      starts[i] = math.min(hi, starts[i - 1]! + 1);
      notes.add('$label ${i + 1}: missing start forward-filled to ${starts[i]}');
    }
  }

  /// Clamps every start into [lo, hi] and bumps any start that is not
  /// strictly greater than its predecessor (saturating at [hi]).
  static void _enforceIncreasing(
    List<int?> starts, {
    required int lo,
    required int hi,
    required List<String> notes,
    required String label,
  }) {
    for (var i = 0; i < starts.length; i++) {
      var s = starts[i]!.clamp(lo, hi);
      if (s != starts[i]) {
        notes.add('$label ${i + 1}: start ${starts[i]} clamped to $s');
      }
      if (i > 0 && s <= starts[i - 1]!) {
        final bumped = math.min(hi, starts[i - 1]! + 1);
        if (bumped != s) {
          notes.add('$label ${i + 1}: start $s not after previous ${starts[i - 1]}, bumped to $bumped');
        }
        s = bumped;
      }
      starts[i] = s;
    }
  }
}