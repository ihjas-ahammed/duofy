import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flow/models/app_models.dart';
import 'package:flow/services/ai_service.dart';
import 'package:flow/services/mapping_verifier.dart';
import 'package:flow/services/pdf_service.dart';

/// Serves synthetic page text from a map of 0-based page index → text; every
/// other page is blank. No real file is ever opened.
class _FakePdfService extends PdfService {
  _FakePdfService(this.pages);
  final Map<int, String> pages;

  @override
  Future<Map<int, String>> extractPagesText(File pdfFile, Set<int> pageIndices) async {
    return {for (final i in pageIndices) i: pages[i] ?? ''};
  }
}

/// AI backstop that never rescues, so tests exercise the offline paths.
class _NoAi extends AiService {
  @override
  Future<bool> verifySectionMapping(String pageText, int pageNumber,
          String sectionTitle, String sectionDescription, {String? apiKey}) async =>
      false;
}

Book _book(List<(String, int, int)> secs) {
  return Book(
    id: 'b1',
    title: 'Test Book',
    description: '',
    icon: 'Book',
    modules: [
      Module(
        id: 'm1',
        title: 'Classical Mechanics',
        description: '',
        practiceQuestions: const [],
        sections: [
          for (final (title, start, end) in secs)
            Section(
              id: 's$start',
              title: title,
              description: '',
              color: 'duo-blue',
              units: const [],
              startPage: start,
              endPage: end,
            ),
        ],
      ),
    ],
    lessonFormats: LessonFormat.defaultFormats,
    defaultFormatId: LessonFormat.defaultFormats.first.id,
  );
}

/// Puts each heading's text on (1-based page + shift), as a chapter opener.
Map<int, String> _pagesWithHeadings(List<(String, int)> headings, {int shift = 0}) {
  return {
    for (final (title, page) in headings)
      page - 1 + shift: 'chapter opener\n$title\nbody paragraphs follow with details',
  };
}

void main() {
  final files = [File('nonexistent-fake.pdf')];

  const headings = [
    ('1.1 Newton Laws Dynamics', 10),
    ('1.2 Friction Surfaces', 22),
    ('2.1 Momentum Collisions', 34),
    ('2.2 Rotational Torque', 46),
  ];
  final book = _book([
    ('1.1 Newton Laws Dynamics', 10, 21),
    ('1.2 Friction Surfaces', 22, 33),
    ('2.1 Momentum Collisions', 34, 45),
    ('2.2 Rotational Torque', 46, 60),
  ]);

  test('aligned book passes with every sampled section matched', () async {
    final v = MappingVerifier(
        pdfService: _FakePdfService(_pagesWithHeadings(headings)), aiService: _NoAi());
    final r = await v.verify(files, book);
    expect(r.pass, isTrue);
    expect(r.matched, r.sampled);
    expect(r.suggestedShift, isNull);
  });

  test('blank pages count as unreadable, never as matches', () async {
    final v = MappingVerifier(pdfService: _FakePdfService(const {}), aiService: _NoAi());
    final r = await v.verify(files, book);
    expect(r.readable, 0);
    expect(r.unreadable, r.sampled);
    // A fully unreadable (scanned) book cannot be text-verified; it passes
    // through to the normal flow rather than being blocked forever.
    expect(r.pass, isTrue);
  });

  test('shift onto blank pages is probed, not waved through as unreadable', () async {
    // Headings sit 4 pages after the mapped positions; the mapped pages
    // themselves are blank. The verifier must not mistake this for a
    // scanned book.
    final v = MappingVerifier(
        pdfService: _FakePdfService(_pagesWithHeadings(headings, shift: 4)),
        aiService: _NoAi());
    final r = await v.verify(files, book);
    expect(r.pass, isFalse);
    expect(r.suggestedShift, 4);
  });

  test('shifted book with body text everywhere fails and suggests the shift', () async {
    final pages = _pagesWithHeadings(headings, shift: 4);
    for (var i = 0; i < 70; i++) {
      pages.putIfAbsent(i, () => 'generic physics prose continues on this page');
    }
    final v = MappingVerifier(pdfService: _FakePdfService(pages), aiService: _NoAi());
    final r = await v.verify(files, book);
    expect(r.pass, isFalse);
    expect(r.mismatched, greaterThanOrEqualTo(2));
    expect(r.suggestedShift, 4);
  });

  test('one local mismatch among many does not fail or suggest a shift', () async {
    final pages = _pagesWithHeadings(headings);
    pages[9] = 'entirely unrelated appendix material about typography'; // breaks 1.1 only
    final v = MappingVerifier(pdfService: _FakePdfService(pages), aiService: _NoAi());
    final r = await v.verify(files, book);
    expect(r.pass, isTrue); // 3/4 = 0.75
    expect(r.mismatched, 1);
    expect(r.suggestedShift, isNull);
  });

  test('applyGlobalShift moves sections, units, and pageOffset', () {
    final withUnits = book.copyWith(pageOffset: 12, modules: [
      book.modules.first.copyWith(sections: [
        book.modules.first.sections.first.copyWith(units: [
          Unit(
            id: 'u1',
            title: 'Unit 1',
            description: '',
            lessons: const [],
            isGenerated: false,
            startPage: 10,
            endPage: 12,
          ),
        ]),
        ...book.modules.first.sections.skip(1),
      ]),
    ]);
    final shifted = MappingVerifier.applyGlobalShift(withUnits, -4);
    final section = shifted.modules.first.sections.first;
    expect(section.startPage, 6);
    expect(section.endPage, 17);
    expect(section.units.first.startPage, 6);
    expect(section.units.first.endPage, 8);
    expect(shifted.pageOffset, 8);
  });
}
