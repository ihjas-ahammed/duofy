# AI Queue Cleanup — Design

Date: 2026-07-04
Status: Approved

Four changes to the AI generation queue and indexing flow.

## 1. Remove the 10-page AI chunk scan

- Delete `GenerationManager.startIndexScanTask` and the `'index_scan'` case
  in `_executeTask`; drop the `'index_scan'` label case in
  `ai_queue_screen.dart` and the type from the comment in `ai_task.dart`.
- Delete `AutoIndexService._chunkScan` and the `chunkScanFallback`
  collaborator/stages from `AutoIndexPipeline`:
  - Scanned-PDF short-circuit returns an empty result (→ manual picker).
  - No confirmed TOC returns an empty result (→ manual picker).
  - TOC found but no chapter 1: return the TOC pages with null chapter 1
    (→ manual picker pre-filled with those pages).
  - The AI optimization pass stays, applied to complete results only.
- Update `test/auto_index_pipeline_test.dart`: remove the chunk-scan fakes
  and assertions; failures now assert empty/partial results.

## 2. Show all AI task failures as toasts

- Add `final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey` in
  `main.dart`, passed to `MaterialApp.scaffoldMessengerKey`.
- In `GenerationManager`, add `_notifyTaskFailure(AiTask task)` that shows
  a red SnackBar via that key: task title + first ~120 chars of the error.
  Call it everywhere a task transitions to `failed`: the `_executeTask`
  catch block and both "No API Keys configured" loops in `_processQueue`.

## 3. Remove the Pause AI feature

- `GenerationManager`: delete `_isPaused`, `isPaused`, `setPaused`, the
  `generation_paused` pref check in `_processQueue`, and the force-pause on
  interrupted tasks in `_loadQueueFromPrefs` (interrupted tasks re-queue
  and auto-resume). Delete `_hasInterruptedTasks`,
  `hasInterruptedTasks`, and `clearInterruptedTasksFlag`.
- `settings_screen.dart`: delete `_buildPauseGenerationCard()`, its call
  site, the `_generationPaused` field, and its prefs load/save lines.
- `home_screen.dart`: delete the "Resume Generation?" interrupted-tasks
  dialog and whatever triggers it.
- `unit_header.dart`: delete the `_ResumeIconButton` shown for queued
  tasks (and its class) — queued tasks now always run automatically.
- Internal `_pauseAllOtherTasks`/`_resumeAllPausedTasks` (exclusive-task
  mechanics) are NOT part of this feature and stay.

## 4. Quick-run for scheduled tasks

- `AiTask.isScheduled` becomes mutable (`bool` instead of `final bool`).
- `GenerationManager.runTaskNow(String taskId)`: find the queued task,
  set `isScheduled = false`, save queue, `notifyListeners`, kick
  `_processQueue`.
- `ai_queue_screen.dart`: for queued tasks with `isScheduled`, add a
  "Run now" button next to the "Waiting for auto-schedule hours…" row,
  calling `runTaskNow(task.id)`.

## Error handling / testing

- Toast helper must never throw (null messenger state → skip silently).
- `flutter analyze` clean of new errors; pipeline + matcher tests pass.
- Manual smoke: fail a task with no API keys → toast appears; scheduled
  task shows Run now and starts immediately when tapped.
