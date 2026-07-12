import '../platform/io_shim.dart';
import 'dart:math' as math;

import '../models/app_models.dart';
import 'ai_service.dart';
import 'page_mapping.dart';
import 'pdf_service.dart';

/// What the deterministic verifier concluded about a skeleton's
/// contents→pages mapping.
class MappingReport {
  final int sampled;
  final int matched;
  final int mismatched;
  final int unreadable;

  /// A single global shift that would re-align the whole book, when the
  /// mismatched sections agree on one (e.g. every heading found 4 pages
  /// after where it was mapped → +4). Apply with
  /// [MappingVerifier.applyGlobalShift] and re-verify.
  final int? suggestedShift;
  final bool usedAiFallback;

  const MappingReport({
    required this.sampled,
    required this.matched,
    required this.mismatched,
    required this.unreadable,
    this.suggestedShift,
    this.usedAiFallback = false,
  });

  int get readable => matched + mismatched;

  /// Pass = nothing readable contradicts the mapping. A fully unreadable
  /// (scanned/image) book passes because text verification is impossible —
  /// the manual split preview remains available for those.
  bool get pass => readable == 0 || matched / readable >= 0.75;

  String describe() => pass
      ? 'Mapping verified ($matched/$readable sections matched)'
      : suggestedShift != null
          ? 'Pages look shifted by $suggestedShift'
          : 'Mapping mismatch ($matched/$readable sections matched)';
}

/// Deterministic contents→pages verification.
///
/// Samples sections SPREAD ACROSS the whole book (an offset error grows with
/// distance from chapter 1, so first-N sampling — what the old AI verifier
/// did — misses uniform drift), extracts the text at each mapped start page
/// and fuzzy-matches the section heading offline via
/// [PageMapping.titleMatchScore]. Blank pages count as *unreadable*, never as
/// matches. When nearly everything misses, a shift scan looks for one global
/// offset correction. The AI check ([AiService.verifySectionMapping]) runs
/// only as a last-resort backstop for readable-but-odd pages.
class MappingVerifier {
  MappingVerifier({PdfService? pdfService, AiService? aiService})
      : _pdfService = pdfService ?? PdfService(),
        _aiService = aiService ?? AiService();

  final PdfService _pdfService;
  final AiService _aiService;

  static const double _matchThreshold = 0.55;
  static const int _maxSamples = 8;

  /// Headings routinely land one page either side of the TOC's number
  /// (heading printed at the bottom of the previous page, chapter opener
  /// art, ...). Within this window a section still counts as matched —
  /// chunk boundaries tolerate it.
  static const int _matchWindow = 1;
  static const int _minShift = -6;
  static const int _maxShift = 30;

  Future<MappingReport> verify(
    List<File> sourceFiles,
    Book book, {
    String? apiKey,
    void Function(String status)? onStatus,
  }) async {
    final all = <({Section section, String moduleTitle})>[];
    for (final m in book.modules) {
      for (final s in m.sections) {
        if (s.startPage != null && s.startPage! >= 1) {
          all.add((section: s, moduleTitle: m.title));
        }
      }
    }
    if (all.isEmpty) {
      return const MappingReport(sampled: 0, matched: 0, mismatched: 0, unreadable: 0);
    }
    final picked = _spread(all, _maxSamples);

    // Batch-extract every page each sample's match window needs, per file.
    onStatus?.call('Verifying page mapping (${picked.length} sections)…');
    final wanted = <int, Set<int>>{};
    for (final s in picked) {
      final fileIdx = s.section.bookIndex ?? 0;
      if (fileIdx < 0 || fileIdx >= sourceFiles.length) continue;
      final set = wanted.putIfAbsent(fileIdx, () => <int>{});
      for (var w = -_matchWindow; w <= _matchWindow; w++) {
        set.add(s.section.startPage! - 1 + w);
      }
    }
    final texts = <int, Map<int, String>>{};
    for (final entry in wanted.entries) {
      texts[entry.key] =
          await _pdfService.extractPagesText(sourceFiles[entry.key], entry.value);
    }

    var matched = 0, mismatched = 0, unreadable = 0;
    final misses = <({Section section, String moduleTitle, int fileIdx})>[];
    for (final s in picked) {
      final fileIdx = s.section.bookIndex ?? 0;
      if (fileIdx < 0 || fileIdx >= sourceFiles.length) {
        unreadable++;
        continue;
      }
      final pageTexts = texts[fileIdx] ?? const {};
      var sawText = false;
      var hit = false;
      for (var w = -_matchWindow; w <= _matchWindow && !hit; w++) {
        final text = pageTexts[s.section.startPage! - 1 + w] ?? '';
        if (text.trim().isEmpty) continue;
        sawText = true;
        hit = _matches(s.section, s.moduleTitle, text);
      }
      if (!sawText) {
        unreadable++;
      } else if (hit) {
        matched++;
      } else {
        mismatched++;
        misses.add((section: s.section, moduleTitle: s.moduleTitle, fileIdx: fileIdx));
      }
    }

    final base = MappingReport(
        sampled: picked.length,
        matched: matched,
        mismatched: mismatched,
        unreadable: unreadable);
    if (base.pass && base.readable > 0) return base;

    if (base.readable == 0) {
      // Every sampled page was blank: either a scanned book (unverifiable →
      // pass through) or a mapping that points at blank pages. Probe for the
      // headings elsewhere before waving it through.
      final probes = [
        for (final s in picked.take(3))
          if ((s.section.bookIndex ?? 0) >= 0 &&
              (s.section.bookIndex ?? 0) < sourceFiles.length)
            (
              section: s.section,
              moduleTitle: s.moduleTitle,
              fileIdx: s.section.bookIndex ?? 0
            )
      ];
      if (probes.length >= 2) {
        onStatus?.call('Mapped pages look blank — probing for shifted headings…');
        final shift = await _detectShift(probes, sourceFiles);
        if (shift != null) {
          return MappingReport(
              sampled: picked.length,
              matched: 0,
              mismatched: probes.length,
              unreadable: picked.length - probes.length,
              suggestedShift: shift);
        }
      }
      return base;
    }

    // Global-shift scan: only meaningful when essentially EVERYTHING misses
    // (a partial mismatch is a local error, not a uniform shift).
    if (matched <= (picked.length >= 6 ? 1 : 0) && misses.length >= 2) {
      onStatus?.call('Mapping looks off — scanning for a page shift…');
      final shift = await _detectShift(misses.take(3).toList(), sourceFiles);
      if (shift != null) {
        return MappingReport(
            sampled: picked.length,
            matched: matched,
            mismatched: mismatched,
            unreadable: unreadable,
            suggestedShift: shift);
      }
    }

    // AI backstop for readable pages whose extracted text confused the
    // offline matcher (dense figures, decorative openers, ...).
    onStatus?.call('Double-checking mismatches with AI…');
    var aiRescued = 0;
    for (final miss in misses.take(2)) {
      final text = texts[miss.fileIdx]?[miss.section.startPage! - 1] ?? '';
      if (text.trim().isEmpty) continue;
      try {
        final ok = await _aiService.verifySectionMapping(
          text,
          miss.section.startPage!,
          miss.section.title,
          miss.section.description,
          apiKey: apiKey,
        );
        if (ok) aiRescued++;
      } catch (_) {}
    }
    if (aiRescued > 0 && aiRescued == math.min(misses.length, 2)) {
      return MappingReport(
          sampled: picked.length,
          matched: matched + misses.length,
          mismatched: 0,
          unreadable: unreadable,
          usedAiFallback: true);
    }
    return base;
  }

  /// Shifts every mapped section (and old-flow unit) range by [shift] pages
  /// and records the change on [Book.pageOffset]. The caller should
  /// re-verify afterwards.
  static Book applyGlobalShift(Book book, int shift) {
    final modules = book.modules.map((m) {
      final sections = m.sections.map((s) {
        final units = s.units.map((u) {
          if (u.startPage == null && u.endPage == null) return u;
          return u.copyWith(
            startPage: u.startPage != null ? u.startPage! + shift : null,
            endPage: u.endPage != null ? u.endPage! + shift : null,
          );
        }).toList();
        if (s.startPage == null && s.endPage == null) {
          return s.copyWith(units: units);
        }
        return s.copyWith(
          units: units,
          startPage: s.startPage != null ? s.startPage! + shift : null,
          endPage: s.endPage != null ? s.endPage! + shift : null,
        );
      }).toList();
      return m.copyWith(sections: sections);
    }).toList();
    return book.copyWith(
      modules: modules,
      pageOffset: (book.pageOffset ?? 0) + shift,
    );
  }

  bool _matches(Section section, String moduleTitle, String text) {
    final score = math.max(
      PageMapping.titleMatchScore(section.title, text),
      PageMapping.titleMatchScore(moduleTitle, text),
    );
    return score >= _matchThreshold;
  }

  /// Scans candidate shifts for up to three mismatched sections and returns
  /// the shift the majority agree on (ties → smallest movement), or null.
  Future<int?> _detectShift(
    List<({Section section, String moduleTitle, int fileIdx})> misses,
    List<File> sourceFiles,
  ) async {
    final wanted = <int, Set<int>>{};
    for (final miss in misses) {
      final set = wanted.putIfAbsent(miss.fileIdx, () => <int>{});
      for (var shift = _minShift; shift <= _maxShift; shift++) {
        if (shift.abs() <= _matchWindow) continue; // window already checked
        set.add(miss.section.startPage! - 1 + shift);
      }
    }
    final texts = <int, Map<int, String>>{};
    for (final entry in wanted.entries) {
      texts[entry.key] =
          await _pdfService.extractPagesText(sourceFiles[entry.key], entry.value);
    }

    final votes = <int, int>{};
    for (final miss in misses) {
      final pageTexts = texts[miss.fileIdx] ?? const {};
      for (var shift = _minShift; shift <= _maxShift; shift++) {
        if (shift.abs() <= _matchWindow) continue;
        final text = pageTexts[miss.section.startPage! - 1 + shift] ?? '';
        if (text.trim().isEmpty) continue;
        if (_matches(miss.section, miss.moduleTitle, text)) {
          votes[shift] = (votes[shift] ?? 0) + 1;
        }
      }
    }
    if (votes.isEmpty) return null;
    final needed = math.max(2, (misses.length * 0.6).ceil());
    int? best;
    for (final entry in votes.entries) {
      if (entry.value < needed) continue;
      if (best == null ||
          votes[best]! < entry.value ||
          (votes[best] == entry.value && entry.key.abs() < best.abs())) {
        best = entry.key;
      }
    }
    return best;
  }

  Future<bool> verifyPostCreateFirstChunk(
    List<File> sourceFiles,
    Book book, {
    String? apiKey,
  }) async {
    Section? firstSec;
    for (final m in book.modules) {
      for (final s in m.sections) {
        if (s.startPage != null && s.startPage! >= 1) {
          firstSec = s;
          break;
        }
      }
      if (firstSec != null) break;
    }
    if (firstSec == null || sourceFiles.isEmpty) return true;
    final fileIdx = firstSec.bookIndex ?? 0;
    if (fileIdx < 0 || fileIdx >= sourceFiles.length) return true;

    final start = firstSec.startPage!;
    final end = firstSec.endPage ?? start;
    final pagesToExtract = <int>{};
    for (int p = start; p <= math.min(start + 2, end); p++) {
      pagesToExtract.add(p - 1);
    }

    try {
      final pageTexts = await _pdfService.extractPagesText(sourceFiles[fileIdx], pagesToExtract);
      final text = pageTexts.values.join('\n');
      if (text.trim().isEmpty) return true; // Can't verify empty text

      return await _aiService.verifyFirstChunkMatch(
        text,
        firstSec.title,
        firstSec.description,
        apiKey: apiKey,
      );
    } catch (e) {
      print('[MappingVerifier] Post-create verification error: $e');
      return false;
    }
  }

  /// Picks up to [count] samples evenly spread across [items] (first, last,
  /// and evenly spaced between), preserving order.
  static List<T> _spread<T>(List<T> items, int count) {
    if (items.length <= count) return List.of(items);
    final picked = <T>[];
    final seen = <int>{};
    for (var i = 0; i < count; i++) {
      final idx = (i * (items.length - 1) / (count - 1)).round();
      if (seen.add(idx)) picked.add(items[idx]);
    }
    return picked;
  }
}
