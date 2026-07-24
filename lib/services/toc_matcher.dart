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
    'structure of the book', 'organization of the book',
    'organisation of the book',
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