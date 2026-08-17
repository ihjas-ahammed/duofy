# Node Description Batch 8 of 61

Graphify is running in assistant/skill mode (no API key). You are the host
assistant (Claude Code / Codex / Gemini CLI). Read the prompt below and write
your JSON answer to the answer file.

## Prompt

You are documenting nodes in a knowledge graph.
For each entry below, write ONE concise factual plain-language sentence
describing what it is or does. Use only the provided context.
For an entity node (any other kind — e.g. a person, place, event, object),
describe what the entity is and its role, grounded in its type, its
relations (neighbors) and the provided citations/evidence — e.g.
"Lady Carfax, a wealthy heiress who disappears en route to Lausanne.".
Ground entity descriptions in the citations/evidence when present; do not
speculate beyond the context, so a node with no supporting context may be
left out of the reply.
LANGUAGE: each entry has a `lang=` marker giving the language of its source.
Write that entry's description in EXACTLY that language. Do not translate to
a single common language — match each node's source language individually.
No marketing language.
Respond ONLY with a JSON object mapping each node id (as a string) to its
one-sentence description — no prose, no markdown fences.

- "commit:repo:github.com/ihjas-ahammed/duofy@01d6dd3f123e6eef98d41e26f7eddc8219fbd83b": "01d6dd3 Merge branch 'main' of https://github.com/ihjas-ahammed/duofy" | kind=Commit | source=git | neighbors=[main, 2ca4f58 chore: add Android builds v26.7…, 67c2b34 chore: add Android builds v26.7…, bccabe4 pyq_meta all set] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@0498e66e0b4e83c85ec72d12710d69766746a5b2": "0498e66 theme: migrate source_pdf_upload_screen" | kind=Commit | source=git | neighbors=[main, af53b52 theme: migrate pyq_tab_screen, source_pdf_upload_screen.dart, d1dbb62 theme: migrate course_edit_stru…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@07c746483e2a405e5d87118eca1225f7142f8709": "07c7464 theme: migrate lesson_path" | kind=Commit | source=git | neighbors=[main, ee65d46 theme: migrate lesson_accordion, lesson_path.dart, 61c1ed4 theme: migrate quick_review_she…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@1bb5af4533a34cc672b7051dffef56ea7be11728": "1bb5af4 theme: migrate theory_view" | kind=Commit | source=git | neighbors=[main, 0184924 theme: migrate analytics_view, theory_view.dart, 6a6426e theme: migrate module_selector,…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@20f459ca1c0ad98b72b272c9f55115b55bcebce7": "20f459c feat: rewrite AutoIndexService as staged cheap-first pipeline" | kind=Commit | source=git | neighbors=[main, 8cff8c9 feat: route auto-index failures…, auto_index_service.dart, 808f4f6 feat: add AiService.optimizeInd…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@274559dd609a1b10cc4cdd91c6f3631b748afdfc": "274559d Merge branch 'main' of https://github.com/ihjas-ahammed/duofy" | kind=Commit | source=git | neighbors=[07c4665 chore: add Android builds v26.7…, 1393ac9 6th, main, 05a15cd chore: add Android builds v26.7…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@2835dd9c75fc0eb4e525f9df6dfe37a745dce623": "2835dd9 Rewrite CodeRunnerView natively in pure Dart using PythonRunnerService" | kind=Commit | source=git | neighbors=[main, 4147f0b Fix Android ProcessEnvironment …, code_runner_view.dart, 81cf620 Fix Python IDE title bar overfl…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@317ac5d452e41609db1f148bff6f477daf88ea34": "317ac5d Merge branch 'main' of https://github.com/ihjas-ahammed/duofy" | kind=Commit | source=git | neighbors=[main, 061977c chore: add Android builds v26.7…, 4793d65 chore: add Android builds v26.7…, 4ac3990 new db] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@348ad55d039918c810f83a0e284ee3802c1346df": "348ad55 fx g" | kind=Commit | source=git | neighbors=[12bf472 feat(release): overhaul PYQ tab…, main, 329bdab ny, da201f8 chore: add Android builds v26.7…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@39500a41fbba09e5d628dd2f656c9f3a2b687d90": "39500a4 fix: correct deadline target count math in app_models" | kind=Commit | source=git | neighbors=[main, d1b8076 chore: add Android builds v26.7…, app_models.dart, 5d06f7a feat: implement Auto-Next lesso…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@3f4d09198b9fdf89fb410cfa24d34ffaf9c29181": "3f4d091 Merge branch 'main' of https://github.com/ihjas-ahammed/duofy" | kind=Commit | source=git | neighbors=[main, 65220a0 fix: WebAssembly check and wind…, ab7968d it ignored my command lets see …, c8874a6 chore: add Android builds v26.7…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@482623dfb997fbee2cc7b17d9a4a67d39c976417": "482623d feat: remove manual indexing-method selector; auto-detect is the only p…" | kind=Commit | source=git | neighbors=[main, c11bc98 chore: update knowledge graph a…, generate_book_screen.dart, 8cff8c9 feat: route auto-index failures…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@5e5211c5139d5be67f7d7fabf84a8cedd1934f74": "5e5211c Merge branch 'main' of https://github.com/ihjas-ahammed/duofy" | kind=Commit | source=git | neighbors=[46cb1a9 chore: release engineering for …, main, 64cd7e0 XA, 9fa942f chore: add Android and Windows …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@61c1ed40edb57420bcf48d89193f80c84ed3b165": "61c1ed4 theme: migrate quick_review_sheet" | kind=Commit | source=git | neighbors=[0184924 theme: migrate analytics_view, main, 07c7464 theme: migrate lesson_path, quick_review_sheet.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@64cd7e0896f88590cb76b46242a7c238ccc5e755": "64cd7e0 XA" | kind=Commit | source=git | neighbors=[5e5211c Merge branch 'main' of https://…, main, d277e55 chore: add Android builds v27.0…, pdfx_test.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@6ed78cc31f69688bec4adfcc671051d75b07682a": "6ed78cc theme: migrate pdf_split_preview_screen" | kind=Commit | source=git | neighbors=[main, 7976120 theme: migrate practice_screen, pdf_split_preview_screen.dart, f8116b9 theme: migrate summary_screen] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@6fe7291ac747d37c5ee70c23eacd4e0cb9983d19": "6fe7291 theme: migrate canvas_art_view placeholder card" | kind=Commit | source=git | neighbors=[1eb22ce theme: migrate generating_book_…, main, f23bb62 theme: migrate calibration/lear…, canvas_art_view.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@75e16eb9aa7dd5c92b4371717423fb97c0080403": "75e16eb ok" | kind=Commit | source=git | neighbors=[67b95db OK, main, d55a1ba chore: add Android builds v26.7…, lazy_indexed_stack.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@79761209226b06925295675a4464f2459345f8df": "7976120 theme: migrate practice_screen" | kind=Commit | source=git | neighbors=[6ed78cc theme: migrate pdf_split_previe…, main, d843901 theme: migrate ai_queue_screen, practice_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@7be050f9cf22087fc941fbc38b57322b551b8f2a": "7be050f Merge branch 'main' of https://github.com/ihjas-ahammed/duofy" | kind=Commit | source=git | neighbors=[329bdab ny, main, 2b1de87 chore: add Android builds v26.7…, da201f8 chore: add Android builds v26.7…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@808f4f67176f486b6648048a5aaa9b6371c90dd7": "808f4f6 feat: add AiService.optimizeIndexResult lite-model cleanup pass" | kind=Commit | source=git | neighbors=[main, 20f459c feat: rewrite AutoIndexService …, ai_service.dart, a316953 feat: add pure AutoIndexPipelin…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9280539df6853f6064bb8e0bca6af30129c03085": "9280539 theme: migrate lesson_assistant_chat" | kind=Commit | source=git | neighbors=[main, b6ffe85 theme: migrate lesson_node, syn…, lesson_assistant_chat.dart, ee65d46 theme: migrate lesson_accordion] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@a5bf9c1f30e6e0dbc1d451a2691317f6a7a99b77": "a5bf9c1 A" | kind=Commit | source=git | neighbors=[3a768f9 style: dart format the files to…, main, 4ea5161 Merge pull request #3 from ihja…, 7f9ff8e io] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@aaf383b72a2953f3375f8a42bbcaceae8aeb0f7a": "aaf383b fix: update free capacity limits (Gemma 1.5k, Gemini Flash 20, Gemini F…" | kind=Commit | source=git | neighbors=[2e3bece chore: add Android builds v26.7…, main, b59e77b fix: auto resolve sync conflict…, usage_limit_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@af53b529c38c30b8fcbf4d61ce1ddcbacdb4a702": "af53b52 theme: migrate pyq_tab_screen" | kind=Commit | source=git | neighbors=[0498e66 theme: migrate source_pdf_uploa…, main, e6b51ae theme: migrate course_settings_…, pyq_tab_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@b6ffe8529d69c67aaf4b931b1d583aa7d5f16471": "b6ffe85 theme: migrate lesson_node, sync_conflict_dialog" | kind=Commit | source=git | neighbors=[9280539 theme: migrate lesson_assistant…, main, 1eb22ce theme: migrate generating_book_…, lesson_node.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@be9dc1e7006f77ea4f7d9312fe55611fcea5f983": "be9dc1e ux: confetti burst and XP count-up on lesson complete" | kind=Commit | source=git | neighbors=[main, 06c30be theme: migrate lesson-complete …, lesson_complete_screen.dart, e02893d ux: answer feedback and interac…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@c04f5ba5819dd4dd73a91545cf41ca6bdf442e23": "c04f5ba fix: resolve static analyzer invalid_assignment error by casting dynami…" | kind=Commit | source=git | neighbors=[b5b2ecb fix: resolve incorrect deadline…, main, 00fdc1a chore: add Android builds v26.7…, deadline_service.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@c476ed9cb30ab4f001fb555f816aeb1db46745b5": "c476ed9 555555555555555555555555555upp" | kind=Commit | source=git | neighbors=[main, 994c7de chore: add Android and Windows …, summary_screen.dart, da7e93c Merge branch 'main' of https://…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d1dbb620dbce40b03d06851e297aca1990c8ab5c": "d1dbb62 theme: migrate course_edit_structure_screen" | kind=Commit | source=git | neighbors=[main, 0498e66 theme: migrate source_pdf_uploa…, course_edit_structure_screen.dart, d5c7c96 theme: migrate generate_book_sc…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d361f24f296c431b931dd3adb299c1c7d33c5c31": "d361f24 chore: add Android builds v26.7.10 [skip ci]" | kind=Commit | source=git | neighbors=[main, 7dbab59 Merge pull request #2 from ihja…, e9979c0 rebrand: rename app display nam…, d68d72b XZ] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d5b97ce691fdb039989ae583ba7af5a6164c7664": "d5b97ce theme: migrate book_dashboard_screen" | kind=Commit | source=git | neighbors=[9c0e7f3 theme: migrate safe_pdf_viewer,…, main, ef45a4f theme: migrate document_store_s…, book_dashboard_screen.dart] | lang=fr
- "commit:repo:github.com/ihjas-ahammed/duofy@d5c7c966ab702f553e9b3bdb7d5205e575094d17": "d5c7c96 theme: migrate generate_book_screen" | kind=Commit | source=git | neighbors=[main, d1dbb62 theme: migrate course_edit_stru…, generate_book_screen.dart, ef45a4f theme: migrate document_store_s…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d7af759a21ebef9e11067468f259b0f94110a258": "d7af759 feat(release & python): add release.txt, update builds/latest.json, add…" | kind=Commit | source=git | neighbors=[main, 137f329 chore: add Android builds v26.7…, python_runner_service.dart, df113f4 chore: add Android builds v26.7…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d843901af3fd62c2c959421cce8636085d2f2132": "d843901 theme: migrate ai_queue_screen" | kind=Commit | source=git | neighbors=[7976120 theme: migrate practice_screen, main, 2934308 theme: migrate metacognition_se…, ai_queue_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@e02893dec2071867e1e4822dd40d6920b69404ff": "e02893d ux: answer feedback and interaction polish in lessons" | kind=Commit | source=git | neighbors=[1322f3d ASZ, main, be9dc1e ux: confetti burst and XP count…, lesson_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@e6b51ae9239254930ffacdd7b02e3c85f08e72a7": "e6b51ae theme: migrate course_settings_screen" | kind=Commit | source=git | neighbors=[af53b52 theme: migrate pyq_tab_screen, main, f8116b9 theme: migrate summary_screen, course_settings_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@eb1723ae71839c568506848ec2b30b1f5d3a1539": "eb1723a fix: preserve Navigator result on LessonScreen replacement to support A…" | kind=Commit | source=git | neighbors=[6b3299a chore: add Android builds v26.7…, main, 4026742 chore: add Android builds v26.7…, lesson_screen.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ee65d46b13a584981788717ad0109bb688b007bb": "ee65d46 theme: migrate lesson_accordion" | kind=Commit | source=git | neighbors=[07c7464 theme: migrate lesson_path, main, 9280539 theme: migrate lesson_assistant…, lesson_accordion.dart] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ef45a4f6a790ee48f3a36eb40a9d3e71f3c31610": "ef45a4f theme: migrate document_store_screen" | kind=Commit | source=git | neighbors=[d5b97ce theme: migrate book_dashboard_s…, main, d5c7c96 theme: migrate generate_book_sc…, document_store_screen.dart] | lang=pt

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-007.json

Keep each description factual and concise (one sentence). No markdown, no prose
outside the JSON object. It is acceptable to omit a node if context is
insufficient — but include every node you can ground confidently.

Example answer format:
```json
{
  "node_id_1": "Resolves the configured ontology profile from graphify.yaml.",
  "node_id_2": "Colonel James Barclay, an antagonist in The Crooked Man."
}
```
