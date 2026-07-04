# Automatic Book Indexing Pipeline — Design

Date: 2026-07-04
Status: Approved

## Problem

During book/course creation the user must choose an indexing method
(Auto-Detect / Manual / Chapters). Auto-detect is weak: it matches only four
keywords, calls the AI per candidate page, and when it fails it dead-ends with
"go back and use Manual mode". There is no handling for table-of-contents
pages without printed page numbers, no use of PDF link annotations or
outlines, and no automatic chapter-start scanning.

## Goals

- Remove the manual indexing choice from the UI. Auto-detection is the only
  path; the manual picker survives solely as a last-resort fallback.
- Detect index/TOC pages offline first (embedded-text extraction, no AI),
  using a robust pattern + structure matcher.
- Confirm candidates with a lite AI model, keeping AI calls minimal.
- Handle books whose TOC has no printed page numbers via PDF link
  annotations and document outline/bookmarks, then via chapter-start
  scanning of extracted text.
- Always finish with an AI optimization pass over the collected result.
- Never dead-end: every failure falls through to the next strategy, ending
  at the manual picker.

## Non-goals

- Real OCR for scanned/image-only PDFs. Decision: embedded-text extraction
  only (Syncfusion, already a dependency, works on Android + Windows).
  Scanned PDFs skip directly to the existing AI chunk-scan fallback.
- Changing the handout flow (it bypasses indexing entirely).
- Changing what happens after indexing (CourseQuestionnaireScreen,
  GenerationManager.startBookGeneration are untouched).

## UI changes

### `lib/screens/generate_book_screen.dart`
- Delete `_buildIndexModeSelector()` and the `_indexMode` field/branching.
- `_generate()` for Book and Course modes always navigates to
  `AutoIndexScreen`.
- The `IndexMode` enum stays (the fallback picker still uses it), but it is
  no longer user-selectable.

### `lib/screens/auto_index_screen.dart`
- Replace the error dead-end ("use Manual mode") with automatic navigation
  to `IndexPickerScreen` for the current PDF, preserving all chained
  multi-PDF parameters (`allSourcePdfs`, `currentPdfIndex`,
  `collectedIndexPages`, `collectedChapter1StartPages`, `isHandout`,
  `customIndexingPrompt`) and showing a brief notice that auto-detection
  failed for this file.
- After manual selection of that PDF, the chain continues as today
  (next PDF goes through AutoIndexScreen again).

### `lib/screens/index_picker_screen.dart`
- Unchanged except it is now reached only as a fallback. Its `Continue`
  flow, chaining, and `IndexMode.manual` behavior stay as-is.

## New component: `lib/services/toc_matcher.dart`

Pure Dart, offline, no dependencies beyond core libraries.

- `static double tocScore(String pageText)` — combines:
  - **Heading match**: a saved table of ~100 TOC-heading variants
    ("contents", "table of contents", "detailed contents", "brief
    contents", "index", "syllabus", "course outline", "course contents",
    "units", "list of chapters", "contents at a glance", "what's inside",
    etc.), matched case-insensitively and whitespace-tolerantly, weighted
    higher when found in the first few lines of the page.
  - **Structural signals**: fraction of lines ending in a number,
    dot-leader lines (`....`), density of lines starting with
    `Chapter/Unit/Lesson/Module/Part <number>` or `<n>.<n>` numbering.
- `static bool isChapterStart(String pageText, {int chapterNumber = 1})` —
  chapter-start patterns ("Chapter 1", "Chapter I", "Unit 1",
  "1. <Title>", "Introduction" as first heading, etc.).
- `static bool hasPrintedPageNumbers(String tocText)` — true when a
  meaningful fraction of TOC lines end in a number.

The "hundred examples" live here as a const pattern table plus unit-test
fixtures of real TOC and non-TOC page texts.

## Rewritten `lib/services/auto_index_service.dart`

`findIndexAndChapter1(File sourcePdf, onProgress)` becomes an ordered,
cheap-first stage chain. Every stage is wrapped in try/catch; a failure
logs and falls through to the next stage.

1. **Extract once.** Syncfusion `PdfTextExtractor` over the first
   `min(pageCount, 120)` pages into `List<String> pageTexts`. If ≥80% of
   scanned pages are empty, treat as scanned PDF → go to stage 5.
2. **Match.** `TocMatcher.tocScore` per page → candidates above threshold,
   ranked by score.
3. **Confirm + expand.** Lite model (`AiService.verifyPageRole`, existing)
   confirms the top candidate. On confirmation, expand forward/backward to
   adjacent pages while their structural score stays high, so multi-page
   TOCs are captured with at most a couple of extra AI calls. Result: the
   full set of TOC pages. If the top few candidates are all rejected →
   stage 5.
4. **Chapter-1 resolution**, first success wins:
   a. TOC has printed page numbers (`hasPrintedPageNumbers`): scan
      `pageTexts` after the TOC for `TocMatcher.isChapterStart`, lite-model
      confirm the first hit → `chapter1StartPage`.
   b. No printed page numbers: read PDF link annotations on the TOC pages
      and the document outline/bookmarks (Syncfusion
      `PdfDocumentLinkAnnotation` destinations, `PdfBookmarkBase`); the
      first destination page is `chapter1StartPage` (destinations also
      validate ordering).
   c. Neither: chapter-start scan over all `pageTexts`, lite-confirm.
5. **AI chunk-scan fallback.** The existing 10-page mini-PDF scan via
   `GenerationManager.startIndexScanTask`, unchanged.
6. **Failure signal.** If index pages or chapter-1 page are still missing,
   return an empty result; `AutoIndexScreen` routes to the manual picker.

**AI optimization pass (always, before returning a successful result):**
a new lite-model call `AiService.optimizeIndexResult(tocText, indexPages,
chapter1StartPage, pageCount)` returns a corrected
`{indexPages, chapter1StartPage}`. The reply is sanity-checked (pages in
`1..pageCount`, sorted, chapter-1 after the TOC); on any failure the
heuristic result stands. This step must never block or fail the flow.

## Error handling

- No stage may throw out of the service; all errors log and fall through.
- Multi-PDF chaining semantics are unchanged: per-PDF results accumulate in
  `collectedIndexPages` / `collectedChapter1StartPages`.
- The manual picker is the terminal fallback for a PDF; there is no
  error-and-go-back state left in the flow.

## Testing

- Unit tests for `TocMatcher`: fixture texts of real TOC pages (with and
  without page numbers), chapter-start pages, and ordinary content pages;
  assert scores/classification.
- Unit test for `hasPrintedPageNumbers` boundary cases.
- Pipeline stage-ordering test with the AI and PDF layers stubbed
  (extract → match → confirm path, scanned-PDF short-circuit, fallback
  cascade).
- Manual verification: run the app, create a book from (1) a digital PDF
  with a normal TOC, (2) a PDF whose TOC lacks page numbers but has links,
  (3) a scanned PDF.
