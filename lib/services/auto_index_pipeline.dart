import 'toc_matcher.dart';

class AutoIndexResult {
  final List<int> indexPages;
  final int? chapter1StartPage;

  AutoIndexResult({required this.indexPages, this.chapter1StartPage});

  bool get isComplete => indexPages.isNotEmpty && chapter1StartPage != null;
}

typedef ProgressCallback = void Function(String status, double progress);

/// Pure orchestration of the cheap-first auto-indexing stage chain.
/// All I/O and AI calls are injected so stage ordering is unit-testable.
///
/// Stages: scanned-PDF short-circuit -> offline TocMatcher candidates ->
/// lite-AI confirm + expand -> chapter-1 via printed numbers / links /
/// text scan -> AI optimization pass. Incomplete results are returned
/// as-is; the caller falls back to the manual picker.
class AutoIndexPipeline {
  /// Lite-model page check; returns
  /// {'isContentsPage': bool, 'isChapter1Start': bool} or null.
  final Future<Map<String, dynamic>?> Function(String pageText, int pageNumber)
      verifyPage;

  /// Destination pages (1-based, sorted) of link annotations on the TOC
  /// pages plus document outline/bookmark entries.
  final Future<List<int>> Function(List<int> tocPages) extractLinkDestinations;

  /// Lite-model cleanup pass; returns
  /// `{'indexPages': List<int>, 'chapter1StartPage': int}` or null.
  final Future<Map<String, dynamic>?> Function(
      String tocText, List<int> indexPages, int? chapter1StartPage) optimize;

  AutoIndexPipeline({
    required this.verifyPage,
    required this.extractLinkDestinations,
    required this.optimize,
  });

  /// Max lite-model calls spent confirming TOC candidates, and max spent
  /// confirming chapter-start candidates.
  static const int maxAiConfirmations = 4;
  static const int maxChapterConfirmations = 3;

  Future<AutoIndexResult> run(
      List<String> pageTexts, int pageCount, ProgressCallback onProgress) async {
    // Stage 1: scanned-PDF short-circuit (no embedded text to work with).
    final scanned = pageTexts.length;
    final emptyCount = pageTexts.where((t) => t.trim().isEmpty).length;
    if (scanned == 0 || emptyCount / scanned >= 0.8) {
      onProgress('No embedded text found (scanned PDF?).', 0.3);
      return AutoIndexResult(indexPages: const [], chapter1StartPage: null);
    }

    // Stage 2: offline heuristic TOC candidates.
    onProgress('Matching table-of-contents patterns…', 0.3);
    final scores = <int, double>{};
    for (int i = 0; i < scanned; i++) {
      final s = TocMatcher.tocScore(pageTexts[i]);
      if (s >= TocMatcher.tocThreshold) scores[i + 1] = s;
    }
    final candidates = scores.keys.toList()
      ..sort((a, b) => scores[b]!.compareTo(scores[a]!));

    // Stage 3: lite-model confirm the best candidate, expand to neighbors.
    List<int> tocPages = const [];
    for (final page in candidates.take(maxAiConfirmations)) {
      onProgress('Confirming table of contents on page $page…', 0.45);
      Map<String, dynamic>? v;
      try {
        v = await verifyPage(pageTexts[page - 1], page);
      } catch (_) {
        v = null;
      }
      if (v != null && v['isContentsPage'] == true) {
        tocPages = _expandToc(page, scores);
        break;
      }
    }

    if (tocPages.isEmpty) {
      onProgress('No table of contents found.', 0.5);
      return AutoIndexResult(indexPages: const [], chapter1StartPage: null);
    }

    // Stage 4: chapter-1 resolution.
    final tocText = tocPages.map((p) => pageTexts[p - 1]).join('\n');
    final hasNumbers = TocMatcher.hasPrintedPageNumbers(tocText);
    int? ch1;

    if (!hasNumbers) {
      // TOC without printed page numbers: links/outline are the best signal.
      ch1 = await _chapter1FromLinks(tocPages, pageCount, onProgress);
    }
    ch1 ??= await _scanChapter1(pageTexts, tocPages.last, onProgress);
    if (ch1 == null && hasNumbers) {
      ch1 = await _chapter1FromLinks(tocPages, pageCount, onProgress);
    }

    if (ch1 == null) {
      return AutoIndexResult(indexPages: tocPages, chapter1StartPage: null);
    }

    return _finish(
        AutoIndexResult(indexPages: tocPages, chapter1StartPage: ch1),
        pageTexts,
        pageCount);
  }

  /// TOCs are contiguous: walk out from the confirmed page while neighbors
  /// are also above the heuristic threshold. No extra AI calls.
  List<int> _expandToc(int seed, Map<int, double> scores) {
    final pages = <int>{seed};
    for (int p = seed - 1; scores.containsKey(p); p--) {
      pages.add(p);
    }
    for (int p = seed + 1; scores.containsKey(p); p++) {
      pages.add(p);
    }
    return pages.toList()..sort();
  }

  Future<int?> _chapter1FromLinks(
      List<int> tocPages, int pageCount, ProgressCallback onProgress) async {
    onProgress('Reading links and bookmarks…', 0.7);
    try {
      final dests = await extractLinkDestinations(tocPages);
      final valid = dests
          .where((p) => p > tocPages.last && p <= pageCount)
          .toList()
        ..sort();
      if (valid.isNotEmpty) return valid.first;
    } catch (_) {}
    return null;
  }

  Future<int?> _scanChapter1(List<String> pageTexts, int afterPage,
      ProgressCallback onProgress) async {
    int checked = 0;
    for (int p = afterPage + 1;
        p <= pageTexts.length && checked < maxChapterConfirmations;
        p++) {
      if (TocMatcher.isChapterStart(pageTexts[p - 1])) {
        checked++;
        onProgress('Verifying chapter start on page $p…', 0.75);
        try {
          final v = await verifyPage(pageTexts[p - 1], p);
          if (v != null && v['isChapter1Start'] == true) return p;
        } catch (_) {}
      }
    }
    return null;
  }

  /// AI optimization pass over a successful result. Sanity-checked; on any
  /// failure the heuristic result stands. Must never throw.
  Future<AutoIndexResult> _finish(
      AutoIndexResult result, List<String> pageTexts, int pageCount) async {
    if (!result.isComplete) return result;
    try {
      final tocText = result.indexPages
          .where((p) => p >= 1 && p <= pageTexts.length)
          .map((p) => pageTexts[p - 1])
          .join('\n');
      final opt =
          await optimize(tocText, result.indexPages, result.chapter1StartPage);
      if (opt != null) {
        final pages = <int>[];
        if (opt['indexPages'] is List) {
          for (final p in opt['indexPages']) {
            if (p is int && p >= 1 && p <= pageCount) pages.add(p);
          }
        }
        pages.sort();
        final oc = opt['chapter1StartPage'];
        final int? ch1 = (oc is int && oc >= 1 && oc <= pageCount) ? oc : null;
        if (pages.isNotEmpty && ch1 != null && ch1 > pages.last) {
          return AutoIndexResult(indexPages: pages, chapter1StartPage: ch1);
        }
      }
    } catch (_) {}
    return result;
  }
}