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
  final List<int> verifiedPages = [];

  Map<String, dynamic>? Function(int page)? verifyAnswers;
  List<int> linkDestinations = const [];
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

  test('scanned PDF (mostly empty text) returns empty result', () async {
    final h = Harness();
    final result = await h.pipeline.run(['', '', '', '', ''], 5, noProgress);

    expect(h.verifiedPages, isEmpty);
    expect(result.indexPages, isEmpty);
    expect(result.chapter1StartPage, isNull);
  });

  test('no TOC anywhere returns empty result', () async {
    final h = Harness();
    final result =
        await h.pipeline.run([cover, preface, chapter1Page], 3, noProgress);

    expect(result.indexPages, isEmpty);
    expect(result.chapter1StartPage, isNull);
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

  test('TOC found but no chapter 1 returns partial result', () async {
    final h = Harness()
      ..verifyAnswers =
          ((page) => {'isContentsPage': page == 3, 'isChapter1Start': false});
    final result = await h.pipeline
        .run([cover, '', tocWithNumbers, preface, chapter1Page], 5, noProgress);

    expect(result.indexPages, [3]);
    expect(result.chapter1StartPage, isNull);
  });
}
