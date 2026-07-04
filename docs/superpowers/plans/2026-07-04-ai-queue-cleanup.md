# AI Queue Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove the 10-page AI chunk scan and the Pause AI feature, toast every AI task failure, and add a "Run now" quick-run for scheduled tasks.

**Architecture:** Pure deletions in `AutoIndexPipeline`/`AutoIndexService`/`GenerationManager` for the chunk scan; a global `scaffoldMessengerKey` lets `GenerationManager` toast failures; Pause AI's pref, API, and UI are stripped with interrupted tasks now auto-resuming; quick-run mutates `AiTask.isScheduled` and re-kicks the queue.

**Tech Stack:** Flutter/Dart, `flutter_test`. Package `duofy`. Run from repo root. After the final task run `graphify update .` (project rule).

**Spec:** `docs/superpowers/specs/2026-07-04-ai-queue-cleanup-design.md`

**Note:** `_ResumeIconButton` in `unit_header.dart` has TWO usages; only the queued/`setPaused` one is Pause-AI related. The class and the interrupted-unit usage (calls `onGenerate`) stay. Internal `_pauseAllOtherTasks`/`_resumeAllPausedTasks`/`_pausedTasks` in GenerationManager are exclusive-task mechanics — do not touch.

---

### Task 1: Remove the AI chunk scan

**Files:**
- Modify: `test/auto_index_pipeline_test.dart`
- Modify: `lib/services/auto_index_pipeline.dart`
- Modify: `lib/services/auto_index_service.dart`
- Modify: `lib/services/generation_manager.dart` (delete `startIndexScanTask` ~line 691, `_runIndexScanForTask` ~line 818, `case 'index_scan':` ~line 491)
- Modify: `lib/screens/ai_queue_screen.dart:112` (icon case)
- Modify: `lib/models/ai_task.dart:11` (type comment)

- [ ] **Step 1: Update the pipeline tests (failing first)**

In `test/auto_index_pipeline_test.dart`:

Remove from `Harness`: the `chunkCalled` field, the `chunkResult` field, and the `chunkScanFallback:` constructor argument.

Replace the three chunk-dependent tests with:

```dart
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

  test('TOC found but no chapter 1 returns partial result', () async {
    final h = Harness()
      ..verifyAnswers =
          ((page) => {'isContentsPage': page == 3, 'isChapter1Start': false});
    final result = await h.pipeline
        .run([cover, '', tocWithNumbers, preface, chapter1Page], 5, noProgress);

    expect(result.indexPages, [3]);
    expect(result.chapter1StartPage, isNull);
  });
```

In the remaining tests delete every `expect(h.chunkCalled, ...)` line.

- [ ] **Step 2: Run tests to verify they fail**

Run: `flutter test test/auto_index_pipeline_test.dart`
Expected: FAIL to compile (`chunkScanFallback` still required by `AutoIndexPipeline`).

- [ ] **Step 3: Remove chunkScanFallback from the pipeline**

In `lib/services/auto_index_pipeline.dart`:
- Delete the `chunkScanFallback` field, its doc comment, and its constructor parameter.
- Stage 1 becomes:

```dart
    if (scanned == 0 || emptyCount / scanned >= 0.8) {
      onProgress('No embedded text found (scanned PDF?).', 0.3);
      return AutoIndexResult(indexPages: const [], chapter1StartPage: null);
    }
```

- The no-TOC branch becomes:

```dart
    if (tocPages.isEmpty) {
      onProgress('No table of contents found.', 0.5);
      return AutoIndexResult(indexPages: const [], chapter1StartPage: null);
    }
```

- The `ch1 == null` branch becomes:

```dart
    if (ch1 == null) {
      return AutoIndexResult(indexPages: tocPages, chapter1StartPage: null);
    }
```

- Update the class doc comment: drop the "AI chunk-scan fallback" stage mention.

- [ ] **Step 4: Remove _chunkScan from AutoIndexService**

In `lib/services/auto_index_service.dart`:
- Delete the whole `_chunkScan` method and the `chunkScanFallback:` argument in the `AutoIndexPipeline(...)` construction.
- Delete now-unused imports: `generation_manager.dart` (and `pdf_service.dart`/`_pdfService` only if `getPageCount` no longer needs it — it does need it, keep).

- [ ] **Step 5: Remove index_scan from GenerationManager and UI**

- `lib/services/generation_manager.dart`: delete the `startIndexScanTask` method, the `_runIndexScanForTask` method, and the two lines `case 'index_scan': await _runIndexScanForTask(task, apiKey); break;`.
- `lib/screens/ai_queue_screen.dart`: delete the two lines `case 'index_scan': return LucideIcons.search;`.
- `lib/models/ai_task.dart`: remove `'index_scan', ` from the type comment on line 11.

- [ ] **Step 6: Verify**

Run: `flutter test test/auto_index_pipeline_test.dart test/toc_matcher_test.dart && flutter analyze lib/services/auto_index_pipeline.dart lib/services/auto_index_service.dart lib/services/generation_manager.dart`
Expected: tests PASS; no new analyzer errors.

- [ ] **Step 7: Commit**

```bash
git add -A && git commit -m "feat: remove AI 10-page chunk scan; auto-index failures go straight to manual picker"
```

---

### Task 2: Toast all AI task failures

**Files:**
- Modify: `lib/main.dart:17` (add key), `lib/main.dart:318` (MaterialApp param)
- Modify: `lib/services/generation_manager.dart`

- [ ] **Step 1: Add the global messenger key**

In `lib/main.dart`, below `final GlobalKey<NavigatorState> navigatorKey ...` (line 17) add:

```dart
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
```

In the `MaterialApp(` constructor (line 317) add, next to `navigatorKey: navigatorKey,`:

```dart
      scaffoldMessengerKey: scaffoldMessengerKey,
```

- [ ] **Step 2: Add the failure notifier to GenerationManager**

`generation_manager.dart` already imports nothing from main; add with the other relative imports:

```dart
import '../main.dart' show scaffoldMessengerKey;
```

(Precedent: `notification_service.dart` already imports `../main.dart`.)

Add this method near `_saveQueueToPrefs`:

```dart
  /// Surface a task failure as a toast. Must never throw — a missing
  /// messenger (e.g. during startup) is silently ignored.
  void _notifyTaskFailure(AiTask task) {
    try {
      final messenger = scaffoldMessengerKey.currentState;
      if (messenger == null) return;
      var reason = task.errorMessage ?? 'Unknown error';
      if (reason.length > 120) reason = '${reason.substring(0, 120)}…';
      messenger.showSnackBar(SnackBar(
        content: Text('AI task failed: ${task.title}\n$reason'),
        backgroundColor: const Color(0xFFB00020),
        duration: const Duration(seconds: 5),
      ));
    } catch (_) {}
  }
```

Call it at every `failed` transition:
1. In `_executeTask`'s catch block, after `task.completer.completeError(e);` add `_notifyTaskFailure(task);`
2. In the canvas-regen no-keys loop (`for (final t in canvasRegens) { ... completeError ... }`) add `_notifyTaskFailure(t);` after the `completeError` line.
3. Same in the `nextTasks` no-keys loop.

- [ ] **Step 3: Verify + commit**

Run: `flutter analyze lib/main.dart lib/services/generation_manager.dart`
Expected: no new errors.

```bash
git add lib/main.dart lib/services/generation_manager.dart && git commit -m "feat: toast all AI task failures via global scaffold messenger"
```

---

### Task 3: Remove the Pause AI feature

**Files:**
- Modify: `lib/services/generation_manager.dart`
- Modify: `lib/screens/settings_screen.dart` (lines 49, 93, 248+252, 690-724, 1324)
- Modify: `lib/screens/home_screen.dart` (`_checkInterruptedTasks` ~line 127 and its call site)
- Modify: `lib/widgets/unit_header.dart` (queued `_ResumeIconButton` block ~line 109)

- [ ] **Step 1: GenerationManager**

- Delete fields/members: `bool _isPaused = false;`, `bool _hasInterruptedTasks = false;`, `bool get isPaused ...`, `bool get hasInterruptedTasks ...`, `clearInterruptedTasksFlag()`, `setPaused(...)` (lines ~100-120).
- In `_loadQueueFromPrefs`: delete `_isPaused = prefs.getBool('generation_paused') ?? false;`; keep the running→queued conversion loop but delete the `hadInterruptedTasks` bookkeeping, `_hasInterruptedTasks = ...`, and the force-pause block; replace the trailing `if (!_isPaused) { _processQueue(); }` with an unconditional `_processQueue();`. Simplified loop:

```dart
        // Convert running to queued if interrupted; they auto-resume.
        for (final t in queue) {
          if (t.status == 'running') {
            t.status = 'queued';
            t.statusMessage = 'Queued (interrupted)';
          }
        }

        _syncActiveMapsWithQueue();
        notifyListeners();
        _processQueue();
```

- In `_processQueue`: delete the paused check (`final prefs = ...; final paused = ...; if (paused) { return; }` at the top). Note the method loads prefs again inside the try — that stays.

- [ ] **Step 2: Settings screen**

- Delete line 49 `bool _generationPaused = false;`
- Delete line 93 `_generationPaused = prefs.getBool('generation_paused') ?? false;`
- Delete line 248 `await prefs.setBool('generation_paused', _generationPaused);` and line 252 `await GenerationManager.instance.setPaused(_generationPaused);`
- Delete the whole `_buildPauseGenerationCard()` method and its call site pair at line 1324 (`_buildPauseGenerationCard(),` + following `const SizedBox(height: 16),`).

- [ ] **Step 3: Home screen**

- Delete the entire `_checkInterruptedTasks()` method (from `void _checkInterruptedTasks() {` through its closing brace — it contains the "Resume Generation?" AlertDialog).
- Delete its call site (grep `_checkInterruptedTasks` for the caller, likely in `initState`/listener).

- [ ] **Step 4: unit_header.dart**

Delete only this block (~lines 109-116):

```dart
                                  if (status == 'Queued' || status == 'queued') ...[
                                    const SizedBox(width: 12),
                                    _ResumeIconButton(
                                      onPressed: () {
                                        GenerationManager.instance.setPaused(false);
                                      },
                                    ),
                                  ],
```

Keep `_ResumeIconButton` class and its other usage. If `GenerationManager` import becomes unused, remove it.

- [ ] **Step 5: Verify + commit**

Run: `flutter analyze` — expect zero errors and zero remaining references to `setPaused`, `isPaused` (GenerationManager's), `hasInterruptedTasks`, `generation_paused`.

```bash
git add -A && git commit -m "feat: remove Pause AI feature; interrupted tasks auto-resume"
```

---

### Task 4: Quick-run for scheduled tasks

**Files:**
- Modify: `lib/models/ai_task.dart:13`
- Modify: `lib/services/generation_manager.dart`
- Modify: `lib/screens/ai_queue_screen.dart` (~line 278 "Waiting for auto-schedule hours..." block)

- [ ] **Step 1: Make isScheduled mutable**

In `lib/models/ai_task.dart` change `final bool isScheduled;` to `bool isScheduled;`.

- [ ] **Step 2: Add runTaskNow**

In `generation_manager.dart` next to `setPaused`'s old spot (near the queue helpers):

```dart
  /// Quick-run: promote a scheduled queued task to run immediately.
  void runTaskNow(String taskId) {
    final task = queue.where((t) => t.id == taskId && t.status == 'queued').firstOrNull;
    if (task == null || !task.isScheduled) return;
    task.isScheduled = false;
    task.statusMessage = 'Queued';
    _saveQueueToPrefs();
    notifyListeners();
    _processQueue();
  }
```

(`firstOrNull` needs `import 'package:collection/collection.dart';` — check if already imported; if not, use a manual loop instead:)

```dart
    AiTask? task;
    for (final t in queue) {
      if (t.id == taskId && t.status == 'queued') { task = t; break; }
    }
```

- [ ] **Step 3: Add the Run now button**

In `ai_queue_screen.dart`, replace:

```dart
              if (isQueued && task.isScheduled) ...[
                const SizedBox(height: 8),
                const Text(
                  'Waiting for auto-schedule hours...',
                  style: TextStyle(color: Colors.white38, fontSize: 10, fontStyle: FontStyle.italic),
                ),
              ],
```

with:

```dart
              if (isQueued && task.isScheduled) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Waiting for auto-schedule hours...',
                        style: TextStyle(color: Colors.white38, fontSize: 10, fontStyle: FontStyle.italic),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => GenerationManager.instance.runTaskNow(task.id),
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.duoGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: const Icon(LucideIcons.play, size: 12),
                      label: const Text('Run now',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
              ],
```

(`GenerationManager` and `LucideIcons` are already imported in this screen; verify `AppTheme` too.)

- [ ] **Step 4: Verify + commit**

Run: `flutter analyze lib/models/ai_task.dart lib/services/generation_manager.dart lib/screens/ai_queue_screen.dart`
Expected: no new errors.

```bash
git add -A && git commit -m "feat: add Run now quick-run for scheduled AI tasks"
```

---

### Task 5: Final verification

- [ ] **Step 1:** `flutter analyze && flutter test test/toc_matcher_test.dart test/auto_index_pipeline_test.dart` — analyze error-free, tests PASS.
- [ ] **Step 2:** `graphify update .`
- [ ] **Step 3:** `git add -A && git commit -m "chore: update knowledge graph after AI queue cleanup"` (skip if clean).
- [ ] **Step 4:** Manual smoke (needs device + keys — note for user if unavailable): failure toast appears; scheduled task runs on "Run now"; Settings has no Pause card.
