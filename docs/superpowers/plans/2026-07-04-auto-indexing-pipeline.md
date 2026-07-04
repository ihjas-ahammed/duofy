# Automatic Book Indexing Pipeline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the manual/auto indexing choice with a single automatic, cheap-first detection pipeline (offline matcher → lite-AI confirm → PDF links/outline → AI chunk scan → manual picker fallback).

**Architecture:** A new pure-Dart `TocMatcher` scores pages offline; a new pure `AutoIndexPipeline` orchestrates the stage chain with all I/O and AI injected as closures (unit-testable); `AutoIndexService` wires real implementations (Syncfusion text/link/bookmark extraction, `AiService`, `GenerationManager`). `AutoIndexScreen` routes failures to `IndexPickerScreen` instead of dead-ending; `GenerateBookScreen` loses its indexing-method selector.

**Tech Stack:** Flutter/Dart, `syncfusion_flutter_pdf` (already a dependency), `flutter_test`. Package name is `duofy`.

**Spec:** `docs/superpowers/specs/2026-07-04-auto-indexing-design.md`

**Conventions:** This codebase uses `print` for service-level logging and try/catch-and-continue error handling — follow that. Run all commands from the repo root `/home/ihjas/Documents/GitHub/duofy`. After the final task, run `graphify update .` (project rule in CLAUDE.md).

---

### Task 1: TocMatcher — offline TOC/chapter heuristics

**Files:**
- Create: `lib/services/toc_matcher.dart`
- Test: `test/toc_matcher_test.dart`

- [ ] **Step 1: Write the failing tests**

Create `test/toc_matcher_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:duofy/services/toc_matcher.dart';

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
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `flutter test test/toc_matcher_test.dart`
Expected: FAIL — `Error: Couldn't resolve the package 'duofy/services/toc_matcher.dart'` (file does not exist yet).

- [ ] **Step 3: Implement TocMatcher**

Create `lib/services/toc_matcher.dart`:

```dart
import 'dart:math' as math;

/// Offline heuristics for locating table-of-contents pages and chapter
/// starts in extracted PDF text. Pure Dart: no AI, no I/O.
class TocMatcher {
  TocMatcher._();

  /// Known TOC heading variants, matched case-insensitively as short
  /// standalone lines after whitespace normalization.
  static const List<String> tocHeadings = [
    // English core
    'contents', 'table of contents', 'table of content', 'detailed contents',
    'brief contents', 'contents at a glance', 'contents in brief',
    'contents overview', 'summary of contents', 'analytical contents',
    'general contents', 'complete contents', 'full contents',
    'list of contents', 'contents page',
    // Index variants
    'index', 'subject index', 'topic index', 'chapter index', 'course index',
    'book index', 'main index',
    // Syllabus / course variants
    'syllabus', 'course syllabus', 'detailed syllabus', 'syllabus outline',
    'course outline', 'course contents', 'course content', 'course structure',
    'course plan', 'course map', 'scheme of study',
    // Chapter / unit / module / lesson lists
    'list of chapters', 'chapters', 'chapter list', 'chapters at a glance',
    'chapter overview', 'scheme of chapters', 'table of chapters',
    'chapterwise contents', 'chapter wise contents',
    'units', 'list of units', 'unit index', 'unit overview',
    'units at a glance', 'table of units', 'unitwise contents',
    'unit wise contents',
    'modules', 'list of modules', 'module index', 'module overview',
    'lessons', 'list of lessons', 'lesson index', 'lesson plan',
    'topics', 'list of topics', 'topics covered', 'topic outline',
    'table of topics',
    // Book-structure phrasings
    'outline', 'book outline', 'overview of the book', 'plan of the book',
    'structure of the book', 'organization of the book', 'organisation of the book',
    "what's inside", 'whats inside', 'inside this book', 'in this book',
    // European languages
    'table des matieres', 'table des matières', 'sommaire',
    'indice', 'índice', 'indice general', 'índice general',
    'tabla de contenido', 'tabla de contenidos', 'sumario', 'sumário',
    'inhalt', 'inhaltsverzeichnis', 'inhoud', 'inhoudsopgave',
    'innehåll', 'indholdsfortegnelse', 'spis treści', 'obsah', 'cuprins',
    'içindekiler', 'icindekiler', 'daftar isi',
    // Indic languages
    'सूची', 'विषय सूची', 'विषय-सूची', 'अनुक्रम', 'अनुक्रमणिका', 'सामग्री',
    'বিষয়সূচি', 'সূচীপত্র', 'பொருளடக்கம்', 'உள்ளடக்கம்',
    'വിഷയസൂചിക', 'ഉള്ളടക്കം', 'విషయసూచిక', 'ವಿಷಯಸೂಚಿ', 'સૂચિ', 'ਸੂਚੀ',
    // East Asian / other scripts
    '目次', '目录', '目錄', '차례', '목차',
    'mục lục', 'muc luc', 'فهرست', 'فهرس', 'المحتويات', 'جدول المحتويات',
  ];

  /// Pages scoring at or above this are TOC candidates.
  static const double tocThreshold = 0.45;

  static final RegExp _chapterLineStart = RegExp(
      r'^\s*(chapter|unit|module|lesson|part|section)\s+([0-9]{1,3}|[ivxlc]{1,7})\b',
      caseSensitive: false);
  static final RegExp _numberedHeading =
      RegExp(r'^\s*\d{1,2}(\.\d{1,2})*[\.\)]?\s+\S');
  static final RegExp _trailingPageNumber =
      RegExp(r'(\.{2,}|\s)\s*\d{1,4}\s*$');
  static final RegExp _dotLeader = RegExp(r'\.{3,}');
  static final RegExp _endsWithDigits = RegExp(r'\d{1,4}$');

  static const Map<int, String> _romans = {
    1: 'i', 2: 'ii', 3: 'iii', 4: 'iv', 5: 'v', 6: 'vi',
    7: 'vii', 8: 'viii', 9: 'ix', 10: 'x', 11: 'xi', 12: 'xii',
  };

  static String _normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();

  static List<String> _lines(String pageText) => pageText
      .split('\n')
      .map((l) => l.trim())
      .where((l) => l.isNotEmpty)
      .toList();

  /// Score in [0, 1] combining a heading match with structural signals
  /// (lines ending in page numbers, dot leaders, chapter-numbering density).
  static double tocScore(String pageText) {
    final lines = _lines(pageText);
    if (lines.isEmpty) return 0.0;

    // Heading match: full weight in the first 6 non-empty lines, half after.
    // Only short lines qualify as headings (prose mentioning "index" etc.
    // must not match).
    double headingScore = 0.0;
    final headLines = math.min(lines.length, 6);
    for (int i = 0; i < lines.length && headingScore < 1.0; i++) {
      final norm = _normalize(lines[i]);
      if (norm.length > 48) continue;
      for (final h in tocHeadings) {
        if (norm == h || norm.startsWith('$h ') || norm.endsWith(' $h')) {
          headingScore = i < headLines ? 1.0 : 0.5;
          break;
        }
      }
    }

    int trailingNum = 0, dotLeaders = 0, chapterStarts = 0, numbered = 0;
    for (final l in lines) {
      if (_trailingPageNumber.hasMatch(l)) trailingNum++;
      if (_dotLeader.hasMatch(l)) dotLeaders++;
      if (_chapterLineStart.hasMatch(l)) chapterStarts++;
      if (_numberedHeading.hasMatch(l)) numbered++;
    }
    final n = lines.length;
    final structureScore = math.min(
        1.0,
        (1.2 * trailingNum + 0.6 * dotLeaders + 0.6 * chapterStarts +
                0.4 * numbered) /
            n);

    return 0.5 * headingScore + 0.5 * structureScore;
  }

  /// True when the page opens with a chapter heading for [chapterNumber]
  /// (arabic or roman), a "1. Title" heading, or (for chapter 1) a bare
  /// "Introduction" heading. TOC-style lines that end in a page number
  /// after the title are rejected.
  static bool isChapterStart(String pageText, {int chapterNumber = 1}) {
    final lines = _lines(pageText);
    final head = lines.take(8).toList();
    final roman = _romans[chapterNumber];

    for (final l in head) {
      final m = _chapterLineStart.firstMatch(l);
      if (m != null) {
        final numStr = m.group(2)!.toLowerCase();
        if (numStr == '$chapterNumber' || (roman != null && numStr == roman)) {
          final rest = l.substring(m.end).trim();
          if (!_endsWithDigits.hasMatch(rest)) return true;
        }
      }
      // "1. Introduction" style numbered heading.
      final nm = RegExp('^\\s*$chapterNumber[\\.\\):]\\s+\\S').firstMatch(l);
      if (nm != null && !_endsWithDigits.hasMatch(l)) return true;
    }

    if (chapterNumber == 1) {
      for (final l in lines.take(3)) {
        if (_normalize(l) == 'introduction') return true;
      }
    }
    return false;
  }

  /// True when a meaningful fraction of TOC lines end in a page number,
  /// i.e. the printed TOC carries page counts.
  static bool hasPrintedPageNumbers(String tocText) {
    final lines = _lines(tocText);
    if (lines.isEmpty) return false;
    final withNum =
        lines.where((l) => _trailingPageNumber.hasMatch(l)).length;
    return withNum >= 3 && withNum / lines.length >= 0.3;
  }
}
```

- [ ] **Step 4: Run tests to verify they pass**

Run: `flutter test test/toc_matcher_test.dart`
Expected: PASS (all tests). If a scoring test fails, print the actual score in the failing test (`print(TocMatcher.tocScore(...))`) and adjust the structural weights in `tocScore` — do not weaken the tests.

- [ ] **Step 5: Commit**

```bash
git add lib/services/toc_matcher.dart test/toc_matcher_test.dart
git commit -m "feat: add offline TocMatcher heuristics for TOC/chapter detection"
```

---

### Task 2: AutoIndexPipeline — pure stage-chain orchestration

**Files:**
- Create: `lib/services/auto_index_pipeline.dart`
- Test: `test/auto_index_pipeline_test.dart`

`AutoIndexResult` moves here from `auto_index_service.dart` (Task 4 re-exports it, so existing imports keep working).

- [ ] **Step 1: Write the failing tests**

Create `test/auto_index_pipeline_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:duofy/services/auto_index_pipeline.dart';

const cover = 'Botany Textbook\nFirst Edition';
const preface =
    'Preface\nThis book is intended for undergraduate students of botany.';
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
''';
const tocWithoutNumbers = '''
CONTENTS

Chapter 1 Introduction to Botany
Chapter 2 Cell Structure and Function
Chapter 3 Photosynthesis
''';
const chapter1Page = '''
CHAPTER 1
Introduction to Botany

Botany is the scientific study of plants. Plants are essential to life on
Earth, providing oxygen, food, and shelter for countless organisms.
''';

void noProgress(String s, double p) {}

/// Builds a pipeline whose collaborators are recorded fakes.
class Harness {
  bool linksCalled = false;
  bool chunkCalled = false;
  final List<int> verifiedPages = [];

  Map<String, dynamic>? Function(int page)? verifyAnswers;
  List<int> linkDestinations = const [];
  AutoIndexResult chunkResult =
      AutoIndexResult(indexPages: const [], chapter1StartPage: null);
  Map<String, dynamic>? optimizeResult;

  late final AutoIndexPipeline pipeline = AutoIndexPipeline(
    verifyPage: (text, page) async {
      verifiedPages.add(page);
      return verifyAnswers?.call(page);
    },
    extractLinkDestinations: (tocPages) async {
      linksCalled = true;
      return linkDestinations;
    },
    chunkScanFallback: (onProgress) async {
      chunkCalled = true;
      return chunkResult;
    },
    optimize: (tocText, indexPages, ch1) async => optimizeResult,
  );
}

void main() {
  test('happy path: TOC with page numbers -> text scan finds chapter 1', () async {
    final h = Harness()
      ..verifyAnswers = ((page) {
        if (page == 3) return {'isContentsPage': true, 'isChapter1Start': false};
        if (page == 5) return {'isContentsPage': false, 'isChapter1Start': true};
        return {'isContentsPage': false, 'isChapter1Start': false};
      });
    final result = await h.pipeline
        .run([cover, '', tocWithNumbers, preface, chapter1Page], 5, noProgress);

    expect(result.indexPages, [3]);
    expect(result.chapter1StartPage, 5);
    expect(h.linksCalled, isFalse);
    expect(h.chunkCalled, isFalse);
  });

  test('multi-page TOC expands to adjacent candidate pages', () async {
    final h = Harness()
      ..verifyAnswers = ((page) => {
            'isContentsPage': page == 3 || page == 4,
            'isChapter1Start': page == 5,
          });
    final result = await h.pipeline.run(
        [cover, preface, tocWithNumbers, tocContinuation, chapter1Page],
        5,
        noProgress);

    expect(result.indexPages, [3, 4]);
    expect(result.chapter1StartPage, 5);
  });

  test('scanned PDF (mostly empty text) goes straight to chunk scan', () async {
    final h = Harness()
      ..chunkResult = AutoIndexResult(indexPages: [2], chapter1StartPage: 4);
    final result = await h.pipeline.run(['', '', '', '', ''], 5, noProgress);

    expect(h.chunkCalled, isTrue);
    expect(h.verifiedPages, isEmpty);
    expect(result.indexPages, [2]);
    expect(result.chapter1StartPage, 4);
  });

  test('no TOC anywhere falls back to chunk scan', () async {
    final h = Harness();
    final result =
        await h.pipeline.run([cover, preface, chapter1Page], 3, noProgress);

    expect(h.chunkCalled, isTrue);
    expect(result.indexPages, isEmpty);
  });

  test('TOC without page numbers uses link destinations for chapter 1',
      () async {
    final h = Harness()
      ..verifyAnswers =
          ((page) => {'isContentsPage': page == 2, 'isChapter1Start': false})
      ..linkDestinations = [1, 4];
    final result = await h.pipeline
        .run([cover, tocWithoutNumbers, preface, chapter1Page], 4, noProgress);

    expect(h.linksCalled, isTrue);
    // Destination 1 is before the TOC and filtered out; 4 wins.
    expect(result.chapter1StartPage, 4);
    expect(result.indexPages, [2]);
    expect(h.chunkCalled, isFalse);
  });

  test('valid optimize result replaces the heuristic result', () async {
    final h = Harness()
      ..verifyAnswers = ((page) => {
            'isContentsPage': page == 3,
            'isChapter1Start': page == 5,
          })
      ..optimizeResult = {
        'indexPages': [2, 3],
        'chapter1StartPage': 5,
      };
    final result = await h.pipeline
        .run([cover, '', tocWithNumbers, preface, chapter1Page], 5, noProgress);

    expect(result.indexPages, [2, 3]);
    expect(result.chapter1StartPage, 5);
  });

  test('invalid optimize result (chapter 1 not after TOC) is discarded',
      () async {
    final h = Harness()
      ..verifyAnswers = ((page) => {
            'isContentsPage': page == 3,
            'isChapter1Start': page == 5,
          })
      ..optimizeResult = {
        'indexPages': [3],
        'chapter1StartPage': 2,
      };
    final result = await h.pipeline
        .run([cover, '', tocWithNumbers, preface, chapter1Page], 5, noProgress);

    expect(result.indexPages, [3]);
    expect(result.chapter1StartPage, 5);
  });

  test('TOC found but no chapter 1 -> chunk scan supplies chapter 1', () async {
    final h = Harness()
      ..verifyAnswers =
          ((page) => {'isContentsPage': page == 3, 'isChapter1Start': false})
      ..chunkResult = AutoIndexResult(indexPages: const [], chapter1StartPage: 5);
    final result = await h.pipeline
        .run([cover, '', tocWithNumbers, preface, chapter1Page], 5, noProgress);

    expect(h.chunkCalled, isTrue);
    expect(result.indexPages, [3]);
    expect(result.chapter1StartPage, 5);
  });
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `flutter test test/auto_index_pipeline_test.dart`
Expected: FAIL — package `duofy/services/auto_index_pipeline.dart` does not exist.

- [ ] **Step 3: Implement AutoIndexPipeline**

Create `lib/services/auto_index_pipeline.dart`:

```dart
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
/// text scan -> AI chunk-scan fallback -> AI optimization pass.
class AutoIndexPipeline {
  /// Lite-model page check; returns
  /// {'isContentsPage': bool, 'isChapter1Start': bool} or null.
  final Future<Map<String, dynamic>?> Function(String pageText, int pageNumber)
      verifyPage;

  /// Destination pages (1-based, sorted) of link annotations on the TOC
  /// pages plus document outline/bookmark entries.
  final Future<List<int>> Function(List<int> tocPages) extractLinkDestinations;

  /// Existing AI chunk scan over the raw PDF.
  final Future<AutoIndexResult> Function(ProgressCallback onProgress)
      chunkScanFallback;

  /// Lite-model cleanup pass; returns
  /// {'indexPages': List<int>, 'chapter1StartPage': int} or null.
  final Future<Map<String, dynamic>?> Function(
      String tocText, List<int> indexPages, int? chapter1StartPage) optimize;

  AutoIndexPipeline({
    required this.verifyPage,
    required this.extractLinkDestinations,
    required this.chunkScanFallback,
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
      onProgress('No embedded text found (scanned PDF?). Scanning with AI…', 0.3);
      return _finish(await chunkScanFallback(onProgress), pageTexts, pageCount);
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
      onProgress('No table of contents found. Scanning with AI…', 0.5);
      return _finish(await chunkScanFallback(onProgress), pageTexts, pageCount);
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
      // Stage 5: last automatic resort before the manual picker.
      onProgress('Could not locate Chapter 1. Scanning with AI…', 0.85);
      final fb = await chunkScanFallback(onProgress);
      if (fb.chapter1StartPage != null) {
        return _finish(
            AutoIndexResult(
                indexPages: tocPages, chapter1StartPage: fb.chapter1StartPage),
            pageTexts,
            pageCount);
      }
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
```

- [ ] **Step 4: Run tests to verify they pass**

Run: `flutter test test/auto_index_pipeline_test.dart`
Expected: PASS (all 8 tests).

- [ ] **Step 5: Run the TocMatcher tests too (regression)**

Run: `flutter test test/toc_matcher_test.dart test/auto_index_pipeline_test.dart`
Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add lib/services/auto_index_pipeline.dart test/auto_index_pipeline_test.dart
git commit -m "feat: add pure AutoIndexPipeline stage-chain orchestration"
```

---

### Task 3: AiService.optimizeIndexResult

**Files:**
- Modify: `lib/services/ai_service.dart` (insert directly after `verifyPageRole`, which ends at line 2641)

No unit test — this is a thin AI call following the exact pattern of `verifyPageRole` above it; correctness is covered by `flutter analyze` and the pipeline's sanity checks.

- [ ] **Step 1: Add the method**

In `lib/services/ai_service.dart`, immediately after the closing brace of `verifyPageRole` (line 2641), insert:

```dart
  /// Final cleanup pass over an auto-detected index result. Returns
  /// {'indexPages': List, 'chapter1StartPage': int} or null on failure.
  /// Callers must sanity-check the reply; a null return is non-fatal.
  Future<Map<String, dynamic>?> optimizeIndexResult(
      String tocText, List<int> indexPages, int? chapter1StartPage, int pageCount,
      {String? apiKey}) async {
    final keys = await _getKeys(forcedApiKey: apiKey);
    final modelsToTry = await _getLiteModels();

    final prompt = '''
A textbook PDF has $pageCount pages. Automatic analysis detected:
- Table of contents on absolute PDF pages: $indexPages
- Chapter 1 content starting on absolute PDF page: $chapter1StartPage

Below is the extracted text of the detected table-of-contents pages. Verify and, if needed, correct the detection:
- Remove pages that are clearly not part of the table of contents.
- chapter1StartPage must be AFTER the last table-of-contents page and within 1..$pageCount.

Respond strictly in JSON format:
{
  "indexPages": [list of ints],
  "chapter1StartPage": int
}

Table of contents text:
$tocText
''';

    for (var key in keys) {
      for (var modelName in modelsToTry) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: key,
            generationConfig: GenerationConfig(responseMimeType: 'application/json'),
          );
          final response = await _retryTransient(
            () => model.generateContent([Content.text(prompt)]).timeout(const Duration(seconds: 30)),
            onRetry: (a, e) => print('[AiService] optimizeIndexResult attempt $a: $e'),
          );
          if (response.text != null) {
            return _cleanAndDecodeJson(response.text!);
          }
        } catch (e) {
          print('[AiService] optimizeIndexResult error with $modelName: $e');
        }
      }
    }
    return null;
  }
```

- [ ] **Step 2: Analyze**

Run: `flutter analyze lib/services/ai_service.dart`
Expected: No new errors (pre-existing infos/warnings elsewhere are fine).

- [ ] **Step 3: Commit**

```bash
git add lib/services/ai_service.dart
git commit -m "feat: add AiService.optimizeIndexResult lite-model cleanup pass"
```

---

### Task 4: Rewrite AutoIndexService to wire the pipeline

**Files:**
- Modify: `lib/services/auto_index_service.dart` (full rewrite, 143 lines currently)

`AutoIndexResult` now lives in `auto_index_pipeline.dart`; the `export` keeps `auto_index_screen.dart` working unchanged.

- [ ] **Step 1: Replace the entire file content**

Replace `lib/services/auto_index_service.dart` with:

```dart
import 'dart:io';
import 'dart:async';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync_pdf;
import 'auto_index_pipeline.dart';
import 'pdf_service.dart';
import 'ai_service.dart';
import 'generation_manager.dart';

export 'auto_index_pipeline.dart' show AutoIndexResult;

/// Finds a book's table-of-contents pages and the absolute page where
/// Chapter 1 starts. Wires real I/O (Syncfusion text/link/bookmark
/// extraction, AiService, GenerationManager) into [AutoIndexPipeline].
class AutoIndexService {
  final AiService _aiService = AiService();
  final PdfService _pdfService = PdfService();

  static const int maxPagesToScan = 120;

  Future<AutoIndexResult> findIndexAndChapter1(
    File sourcePdf,
    void Function(String status, double progress) onProgress,
  ) async {
    final pageCount = await _pdfService.getPageCount(sourcePdf);
    final int scanLimit = pageCount.clamp(0, maxPagesToScan);

    onProgress('Extracting textbook text…', 0.05);
    final pageTexts = await _extractPageTexts(sourcePdf, scanLimit, onProgress);

    final pipeline = AutoIndexPipeline(
      verifyPage: (text, page) => _aiService.verifyPageRole(text, page),
      extractLinkDestinations: (tocPages) =>
          _extractLinkDestinations(sourcePdf, tocPages),
      chunkScanFallback: (progress) =>
          _chunkScan(sourcePdf, pageCount, scanLimit, progress),
      optimize: (tocText, pages, ch1) =>
          _aiService.optimizeIndexResult(tocText, pages, ch1, pageCount),
    );

    return pipeline.run(pageTexts, pageCount, onProgress);
  }

  /// Embedded-text extraction of the first [scanLimit] pages. Pages that
  /// fail to extract yield '' (a mostly-empty result means a scanned PDF,
  /// which the pipeline short-circuits to the AI chunk scan).
  Future<List<String>> _extractPageTexts(
      File sourcePdf, int scanLimit, ProgressCallback onProgress) async {
    final texts = List<String>.filled(scanLimit, '');
    sync_pdf.PdfDocument? doc;
    try {
      final bytes = await sourcePdf.readAsBytes();
      doc = sync_pdf.PdfDocument(inputBytes: bytes);
      final extractor = sync_pdf.PdfTextExtractor(doc);
      for (int i = 0; i < scanLimit; i++) {
        onProgress('Reading page ${i + 1} of $scanLimit…',
            0.05 + 0.2 * (i / scanLimit));
        try {
          texts[i] = extractor.extractText(startPageIndex: i, endPageIndex: i);
        } catch (_) {}
      }
    } catch (e) {
      print('[AutoIndexService] Text extraction failed: $e');
    } finally {
      doc?.dispose();
    }
    return texts;
  }

  /// Destination pages of internal link annotations on [tocPages] plus all
  /// document outline/bookmark entries. Empty result is fine — the pipeline
  /// falls back to text scanning.
  Future<List<int>> _extractLinkDestinations(
      File sourcePdf, List<int> tocPages) async {
    final dests = <int>{};
    sync_pdf.PdfDocument? doc;
    try {
      doc = sync_pdf.PdfDocument(inputBytes: await sourcePdf.readAsBytes());
      for (final pageNum in tocPages) {
        if (pageNum < 1 || pageNum > doc.pages.count) continue;
        final annotations = doc.pages[pageNum - 1].annotations;
        for (int i = 0; i < annotations.count; i++) {
          final a = annotations[i];
          if (a is sync_pdf.PdfDocumentLinkAnnotation) {
            final destPage = a.destination?.page;
            if (destPage != null) {
              final idx = doc.pages.indexOf(destPage);
              if (idx >= 0) dests.add(idx + 1);
            }
          }
        }
      }
      _collectBookmarks(doc, doc.bookmarks, dests);
    } catch (e) {
      print('[AutoIndexService] Link/bookmark extraction failed: $e');
    } finally {
      doc?.dispose();
    }
    return dests.toList()..sort();
  }

  void _collectBookmarks(
      sync_pdf.PdfDocument doc, sync_pdf.PdfBookmarkBase base, Set<int> dests) {
    for (int i = 0; i < base.count; i++) {
      final bm = base[i];
      final destPage = bm.destination?.page;
      if (destPage != null) {
        final idx = doc.pages.indexOf(destPage);
        if (idx >= 0) dests.add(idx + 1);
      }
      _collectBookmarks(doc, bm, dests);
    }
  }

  /// Pre-existing AI chunk scan: slice the PDF into 10-page mini-PDFs and
  /// ask the AI to locate the TOC and Chapter 1 in each.
  Future<AutoIndexResult> _chunkScan(File sourcePdf, int pageCount,
      int scanLimit, ProgressCallback onProgress) async {
    final found = <int>[];
    int? ch1;
    const chunkSize = 10;
    final chunks = (scanLimit / chunkSize).ceil();

    for (int i = 0; i < chunks; i++) {
      if (found.isNotEmpty && ch1 != null) break;

      final startPage = i * chunkSize + 1;
      int endPage = (i + 1) * chunkSize;
      if (endPage > pageCount) endPage = pageCount;
      if (startPage > pageCount) break;

      onProgress('Scanning pages $startPage to $endPage with AI…',
          (i + 1) / chunks);

      try {
        final chunkPages =
            List.generate(endPage - startPage + 1, (idx) => startPage + idx);
        final chunkPdf = await _pdfService.extractPages(sourcePdf, chunkPages);
        final jsonMap = await GenerationManager.instance
            .startIndexScanTask(chunkPdf, startPage, endPage);

        if (jsonMap != null) {
          if (jsonMap['indexPages'] is List) {
            for (var p in jsonMap['indexPages']) {
              if (p is int && p >= 1 && p <= pageCount) found.add(p);
            }
          }
          final v = jsonMap['chapter1StartPage'];
          if (v is int && v >= 1 && v <= pageCount) ch1 ??= v;
        }

        if (chunkPdf.existsSync()) {
          chunkPdf.deleteSync();
        }
      } catch (e) {
        print('[AutoIndexService] Error scanning chunk $i: $e');
      }
    }

    return AutoIndexResult(
      indexPages: found.toSet().toList()..sort(),
      chapter1StartPage: ch1,
    );
  }
}
```

Note: if `flutter analyze` reports that `PdfDocumentLinkAnnotation` is not the loaded-annotation type in this Syncfusion version, check the package source under `~/.pub-cache/hosted/pub.dev/syncfusion_flutter_pdf-*/lib/src/pdf/implementation/annotations/` for the loaded document-link annotation class name and adjust the `is` check. The bookmark path (`doc.bookmarks`) works regardless and is the primary signal.

- [ ] **Step 2: Analyze and run all new tests**

Run: `flutter analyze lib/services/auto_index_service.dart lib/services/auto_index_pipeline.dart && flutter test test/toc_matcher_test.dart test/auto_index_pipeline_test.dart`
Expected: analyze clean; tests PASS.

- [ ] **Step 3: Commit**

```bash
git add lib/services/auto_index_service.dart
git commit -m "feat: rewrite AutoIndexService as staged cheap-first pipeline"
```

---

### Task 5: AutoIndexScreen — route failures to the manual picker

**Files:**
- Modify: `lib/screens/auto_index_screen.dart`

Replaces the "go back and use Manual mode" dead-end with automatic navigation to `IndexPickerScreen`, pre-filled with any partial results. The `_hasError` state and error UI are removed entirely.

- [ ] **Step 1: Add the IndexMode import**

At the top of `lib/screens/auto_index_screen.dart`, after `import 'course_questionnaire_screen.dart';` add:

```dart
import 'generate_book_screen.dart' show IndexMode;
```

(`index_picker_screen.dart` is already imported.)

- [ ] **Step 2: Replace the result handling in `_startAutoIndex`**

Replace this block (lines 69-118, the `if (mounted) { if (result.indexPages.isEmpty || ...) ... }` block):

```dart
      if (mounted) {
        if (result.indexPages.isEmpty || result.chapter1StartPage == null) {
          setState(() {
            _hasError = true;
            _status = 'Could not automatically find the index or chapter 1. Please go back and use Manual mode.';
          });
        } else {
```

with:

```dart
      if (mounted) {
        if (result.indexPages.isEmpty || result.chapter1StartPage == null) {
          _fallbackToManual(
            initialIndexPages:
                result.indexPages.isNotEmpty ? result.indexPages : null,
            initialChapter1Page: result.chapter1StartPage,
          );
        } else {
```

(The `else` branch — collecting results and chaining to the next PDF or `CourseQuestionnaireScreen` — stays exactly as it is.)

- [ ] **Step 3: Replace the catch block**

Replace (lines 119-126):

```dart
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _status = 'Error: ${e.toString()}';
        });
      }
    }
```

with:

```dart
    } catch (e) {
      print('[AutoIndexScreen] Auto-index failed: $e');
      if (mounted) {
        _fallbackToManual();
      }
    }
```

- [ ] **Step 4: Add the `_fallbackToManual` method**

Add after `_startAutoIndex` (before `build`):

```dart
  /// Auto-detection failed for this PDF: hand over to the manual picker,
  /// pre-filled with any partial results. Subsequent PDFs in the chain
  /// still go through auto-detection first (isAutoMode stays true).
  void _fallbackToManual({List<int>? initialIndexPages, int? initialChapter1Page}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Auto-detect couldn\'t index "${widget.filename}". Please mark the index pages manually.'),
      duration: const Duration(seconds: 5),
    ));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => IndexPickerScreen(
        sourcePdf: widget.sourcePdf,
        filename: widget.filename,
        syllabusFiles: widget.syllabusFiles,
        isCourse: widget.isCourse,
        initialIndexPages: initialIndexPages,
        initialChapter1Page: initialChapter1Page,
        allSourcePdfs: widget.allSourcePdfs,
        currentPdfIndex: widget.currentPdfIndex,
        collectedIndexPages: widget.collectedIndexPages,
        collectedChapter1StartPages: widget.collectedChapter1StartPages,
        isAutoMode: true,
        isHandout: widget.isHandout,
        indexMode: IndexMode.manual,
        customIndexingPrompt: widget.customIndexingPrompt,
      ),
    ));
  }
```

- [ ] **Step 5: Remove the error state**

- Delete the field `bool _hasError = false;` (line 46).
- In `build`, replace the `children:` of the inner `Column` (the `if (!_hasError) ...[ ... ] else ...[ ... ]` block, lines 142-160) with the non-error branch only:

```dart
            children: [
              const CircularProgressIndicator(color: AppTheme.duoGreen),
              const SizedBox(height: 24),
              Text(_status, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              LinearProgressIndicator(value: _progress, backgroundColor: Colors.white12, color: AppTheme.duoGreen),
              const SizedBox(height: 24),
              const Text('AI is scanning the textbook to locate the table of contents and chapter starts. This saves you from scrolling!', style: TextStyle(color: Colors.white54, fontSize: 13), textAlign: TextAlign.center),
            ],
```

- Remove now-unused imports if the analyzer flags them (`AppTheme` is still used; `Icons.error_outline`/`AppTheme.duoRed` usages go away with the error branch).

- [ ] **Step 6: Analyze**

Run: `flutter analyze lib/screens/auto_index_screen.dart`
Expected: clean (no unused-field or undefined-symbol issues).

- [ ] **Step 7: Commit**

```bash
git add lib/screens/auto_index_screen.dart
git commit -m "feat: route auto-index failures to manual picker instead of dead-ending"
```

---

### Task 6: GenerateBookScreen — remove the indexing-method selector

**Files:**
- Modify: `lib/screens/generate_book_screen.dart`

The `IndexMode` enum declaration (line 23) STAYS — `index_picker_screen.dart` and `course_questionnaire_screen.dart` import it from this file.

- [ ] **Step 1: Remove the field and its assignments**

- Delete line 34: `IndexMode _indexMode = IndexMode.auto;`
- In `_buildModeTab`'s `onTap` (lines 860-871), delete the `_indexMode` reset:

```dart
            if (mode == GenerationMode.handout) {
              _indexMode = IndexMode.chapters;
            } else {
              _indexMode = IndexMode.auto;
            }
```

so the `setState` body becomes just:

```dart
          setState(() {
            _mode = mode;
            _selectedFiles.clear();
            _syllabusFiles.clear();
          });
```

- [ ] **Step 2: Simplify `_generate`**

In `_generate` (lines 756-791), replace the three-way branch:

```dart
        if (_mode == GenerationMode.handout) {
          _showHandoutPrompt(_selectedFiles, presetTitle ?? filename);
        } else if (_indexMode == IndexMode.manual || _indexMode == IndexMode.chapters) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => IndexPickerScreen(
              ...
            ),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AutoIndexScreen(
              ...
            ),
          ));
        }
```

with a two-way branch (handout unchanged, everything else goes to auto):

```dart
        if (_mode == GenerationMode.handout) {
          _showHandoutPrompt(_selectedFiles, presetTitle ?? filename);
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AutoIndexScreen(
              sourcePdf: firstPdf,
              filename: presetTitle ?? filename,
              syllabusFiles: finalSyllabusFiles,
              isCourse: _mode == GenerationMode.course,
              allSourcePdfs: _selectedFiles,
              currentPdfIndex: 0,
              collectedIndexPages: const [],
              collectedChapter1StartPages: const [],
              isAutoMode: true,
              isHandout: _mode == GenerationMode.handout,
              customIndexingPrompt: customPrompt.isNotEmpty ? customPrompt : null,
            ),
          ));
        }
```

- [ ] **Step 3: Remove the selector widget**

- Delete the whole `_buildIndexModeSelector()` method (lines 891-937).
- Delete its call site (line 1041): the line `_buildIndexModeSelector(),`. The `const SizedBox(height: 24),` after it stays.

- [ ] **Step 4: Clean up imports**

`IndexPickerScreen` is no longer referenced here — delete line 10 (`import 'index_picker_screen.dart';`) if the analyzer confirms it's unused.

- [ ] **Step 5: Analyze the whole app**

Run: `flutter analyze`
Expected: no errors anywhere (in particular no `_indexMode` references left, and `IndexMode` still resolves for `index_picker_screen.dart` / `course_questionnaire_screen.dart`).

- [ ] **Step 6: Commit**

```bash
git add lib/screens/generate_book_screen.dart
git commit -m "feat: remove manual indexing-method selector; auto-detect is the only path"
```

---

### Task 7: Final verification

**Files:** none new.

- [ ] **Step 1: Full test + analyze pass**

Run: `flutter analyze && flutter test test/toc_matcher_test.dart test/auto_index_pipeline_test.dart`
Expected: analyze clean, all tests PASS. (Do not run the whole `test/` directory blindly — `widget_test.dart` and `pdfx_test.dart` predate this work; if they were failing before, that's out of scope.)

- [ ] **Step 2: Manual smoke test (needs a device/desktop target)**

Run the app (`flutter run -d linux` or the platform available) and verify:
1. New Material screen no longer shows the "INDEXING METHOD" radio row.
2. Creating a Book from a digital PDF with a TOC lands on the questionnaire without any manual page picking.
3. Creating a Book from a PDF with no detectable TOC (or with AI keys removed) ends on the "Pick Index Pages" screen with the failure snackbar, and Continue proceeds normally.

If no device is available in the execution environment, note this for the user instead of skipping silently.

- [ ] **Step 3: Update the knowledge graph (project rule)**

Run: `graphify update .`
Expected: graph updated without errors.

- [ ] **Step 4: Commit any remaining changes**

```bash
git add -A
git commit -m "chore: update knowledge graph after auto-indexing pipeline"
```

(Skip if `git status` is clean.)
