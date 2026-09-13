# Node Description Batch 11 of 68

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

- "commit:repo:github.com/ihjas-ahammed/duofy@797ed6059d2354ab0a3ab587afe2675b898e9782": "797ed60 chore: add Android builds v26.8.12 [skip ci]" | kind=Commit | source=git | neighbors=[41b78ce feat(docs): add keytoflow and 5…, main, bb39292 mw] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@7a4966f5b0452347b0f9f3c9271b55186c649ff6": "7a4966f chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, ec6f1f9 feat: unify restore PDF picker …, 9535e64 k] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@7cb1aa63deed2193c2be30c2afa7615e7fa6b28d": "7cb1aa6 RMY" | kind=Commit | source=git | neighbors=[13b10df chore: add Android builds v27.0…, main, d68d72b XZ] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@7e1307968ccb9ad3dc79874777e7c1eefb3e9753": "7e13079 docs: add AI queue cleanup design spec" | kind=Commit | source=git | neighbors=[main, ab5d5ed docs: add AI queue cleanup impl…, c11bc98 chore: update knowledge graph a…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@7e90faf6e262e838f763fa74b141918e31855e0b": "7e90faf chore: add Android builds v26.8.1 [skip ci]" | kind=Commit | source=git | neighbors=[main, c5f6e32 new, a15c42e feat(daily-goals): Add Gamified…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@819cacbfe63bfbb08f77a7ac7ddd3bc4123baf89": "819cacb chore: add Android builds v26.7.10 [skip ci]" | kind=Commit | source=git | neighbors=[4ea5161 Merge pull request #3 from ihja…, main, 0a59fe5 Merge pull request #4 from ihja…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@88176b7a901ce7060694cb3d29205ed6e69c81de": "88176b7 chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[1fa1705 OK, main, b99cbf3 OK] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@8cff8c99343db604640db802ac9d4b8212a72465": "8cff8c9 feat: route auto-index failures to manual picker instead of dead-ending" | kind=Commit | source=git | neighbors=[20f459c feat: rewrite AutoIndexService …, main, 482623d feat: remove manual indexing-me…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@916308a4f1b515ad095aca25841073adaa565466": "916308a docs: add auto-indexing pipeline implementation plan" | kind=Commit | source=git | neighbors=[main, 742f017 feat: add offline TocMatcher he…, ca30680 docs: add auto-indexing pipelin…] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@91f03f1d8235375ac3e0de21280c01cfe66d83ff": "91f03f1 chore: add docs/flow-research/ to .gitignore" | kind=Commit | source=git | neighbors=[main, 39851db chore: untrack docs/flow-resear…, a411ccb docs: Update flow-research agri…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@994c7de4db508a7c39c0d135745c7f1ac6ec9a80": "994c7de chore: add Android and Windows builds v26.6.5 [skip ci]" | kind=Commit | source=git | neighbors=[main, a055e9b PRE-RE, c476ed9 555555555555555555555555555upp] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9b43b6dee91d1d3471c913b064a3d2591b2589cb": "9b43b6d chore: add Android and Windows builds v26.6.25 [skip ci]" | kind=Commit | source=git | neighbors=[085e90d quick fix, main, 9981c72 z] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9d00f5b88b0c9caf9de965d1211ff8c228ce6c56": "9d00f5b chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[4ead8b6 z, main, 3b989f1 Bump version to 26.7.22+2026072…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9ecc455e4a9605a31e153db7886bf157c760d1a0": "9ecc455 chore: add Android and Windows builds v26.6.25 [skip ci]" | kind=Commit | source=git | neighbors=[675d2a1 EXPRESS, main, 085e90d quick fix] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9fa942f3c0f280debc86b53b44c15339b261b088": "9fa942f chore: add Android and Windows builds v26.7.4 [skip ci]" | kind=Commit | source=git | neighbors=[main, 5e5211c Merge branch 'main' of https://…, ed71b03 io] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@a411ccb42a1a323ad230d74e5a3a2deff836a1a2": "a411ccb docs: Update flow-research agriculture and environmental sciences study…" | kind=Commit | source=git | neighbors=[7b676e4 v26.8.12: Update latest.md, ver…, main, 91f03f1 chore: add docs/flow-research/ …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ab5d5ed09fb514dc26f802d19b5eba78d96c6ac8": "ab5d5ed docs: add AI queue cleanup implementation plan" | kind=Commit | source=git | neighbors=[7e13079 docs: add AI queue cleanup desi…, main, 4337110 feat: remove AI 10-page chunk s…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@abda98359acdcdafbbadd2700249b2c174a69508": "abda983 chore: add Android builds v26.8.8 [skip ci]" | kind=Commit | source=git | neighbors=[63ce973 Update app.zip and app.zip.hash…, main, 7b676e4 v26.8.12: Update latest.md, ver…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@bb392920f687318d2bd10aa284c85b39803ad0ca": "bb39292 mw" | kind=Commit | source=git | neighbors=[797ed60 chore: add Android builds v26.8…, main, e52e844 feat(release): v26.8.27 - LaTeX…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@be39e1cc7a438d3e0923d4772d2d10dc41f62f29": "be39e1c chore: add Android builds v26.8.31 [skip ci]" | kind=Commit | source=git | neighbors=[a292b18 feat: instant update check cach…, main, 0b36b76 feat(release): v26.9.1 - Multi-…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@bed7aca0fed19d8293cd22ed6b65a397303170cf": "bed7aca chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, c71d757 orgainze apis, c83829c deadine v2] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@c11bc981a14c40b3489db5a5a1f85ae20bbfbb7d": "c11bc98 chore: update knowledge graph after auto-indexing pipeline" | kind=Commit | source=git | neighbors=[482623d feat: remove manual indexing-me…, main, 7e13079 docs: add AI queue cleanup desi…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@c5f6e32833e5262e0846ed4daec2b5356e70579f": "c5f6e32 new" | kind=Commit | source=git | neighbors=[7e90faf chore: add Android builds v26.8…, main, 458dd1e chore: add Android builds v26.8…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@c8874a6ae8567c02efabc76a4982051ad042dddc": "c8874a6 chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, 3f4d091 Merge branch 'main' of https://…, ec6f1f9 feat: unify restore PDF picker …] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@ca30680c2b169ef4b6822deb0a620abb7a3234ad": "ca30680 docs: add auto-indexing pipeline design spec" | kind=Commit | source=git | neighbors=[693d260 GRAPHYFI FIX, main, 916308a docs: add auto-indexing pipelin…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d19afe4ff341f24ab75e54d3a38449c7ac276e6e": "d19afe4 Fix serious_python_linux copying root directory when SERIOUS_PYTHON_SIT…" | kind=Commit | source=git | neighbors=[5aeefed chore: add Android builds v26.7…, main, 0774610 Update graphify index for CMake…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d1b807670e70252e6e5d15786d2bae9c4619194b": "d1b8076 chore: add Android builds v26.7.12 [skip ci]" | kind=Commit | source=git | neighbors=[39500a4 fix: correct deadline target co…, main, 25fb4a6 fix: reset FlashcardView state …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d277e5543e8c9b5d05abafe8a4d115d03a60d9a8": "d277e55 chore: add Android builds v27.0.0 [skip ci]" | kind=Commit | source=git | neighbors=[64cd7e0 XA, main, a08a7bd FIX #1] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d55a1baed230e2aa39afafc80f430e8b3c2df8d8": "d55a1ba chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[75e16eb ok, main, 4ea21ab fix: loadPyodide loading timing…] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@da201f8317b5fde2537d01c53aa71d9b53ac2970": "da201f8 chore: add Android builds v26.7.25 [skip ci]" | kind=Commit | source=git | neighbors=[348ad55 fx g, main, 7be050f Merge branch 'main' of https://…] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@da7e93cd83c5a7600345c85efdc459e0dbaf915a": "da7e93c Merge branch 'main' of https://github.com/ihjas-ahammed/duofy" | kind=Commit | source=git | neighbors=[main, c476ed9 555555555555555555555555555upp, b807fe5 sd] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@dbdfb9514212c68f79e85aa32dfb3835e2aad53f": "dbdfb95 chore: add Android builds v26.8.27 [skip ci]" | kind=Commit | source=git | neighbors=[5fcf739 update: tactical sync, main, 1c58056 feat(release): v26.8.31 - Compl…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@de5fd9a195530b85efaacab53556b372ef448991": "de5fd9a chore: add Android builds v26.7.25 [skip ci]" | kind=Commit | source=git | neighbors=[a22f95b feat: complete celestial light …, main, 12bf472 feat(release): overhaul PYQ tab…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@df113f4d35a6ccb73fa77ec5bb61b83e20728e84": "df113f4 chore: add Android builds v26.7.22 [skip ci]" | kind=Commit | source=git | neighbors=[1dc8e69 fix(python & flashcard): fix An…, main, d7af759 feat(release & python): add rel…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@e0b1be47b07a82d0088505250166c1b5fb661d31": "e0b1be4 fix1" | kind=Commit | source=git | neighbors=[3fb655e chore: update knowledge graph a…, main, 5608612 chore: add Android and Windows …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@e0cfdd09f818f63230e09bba4f0808237c90bebe": "e0cfdd0 chore: add Android builds v26.8.7 [skip ci]" | kind=Commit | source=git | neighbors=[14e7263 feat: Quick Generate Module Not…, main, 5621c28 v26.8.8: Integrated SeriousPyth…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@e18a31ce3e95325fe0366f4813529f940607e0bd": "e18a31c chore: add Android builds v26.7.22 [skip ci]" | kind=Commit | source=git | neighbors=[2d60cdb feat: add AI provider model tes…, main, 8a51c13 fix(python & formats): disable …] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@f25268e8e53cbe86dd1dc477fab94d5d116df7be": "f25268e chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[b99cbf3 OK, main, 9d1d7bc NAA] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@f2b17bb161d4a4503e930a159f1a2c07221d2b72": "f2b17bb chore: add Android builds v26.7.10 [skip ci]" | kind=Commit | source=git | neighbors=[7dbab59 Merge pull request #2 from ihja…, main, 4ea5161 Merge pull request #3 from ihja…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@f916a64b1835597f159ce094cfa1a7d170713c2c": "f916a64 chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[4ea21ab fix: loadPyodide loading timing…, main, ea4994a Support program & try_yourself …] | lang=pt

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-010.json

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
