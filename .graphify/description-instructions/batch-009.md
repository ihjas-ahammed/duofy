# Node Description Batch 10 of 61

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

- "commit:repo:github.com/ihjas-ahammed/duofy@2b1de87d2e62bb4e07daedf31873ae094553fe8b": "2b1de87 chore: add Android builds v26.7.25 [skip ci]" | kind=Commit | source=git | neighbors=[main, 859f766 new, 7be050f Merge branch 'main' of https://…] | lang=nl
- "commit:repo:github.com/ihjas-ahammed/duofy@2ca4f58c513d9520009bd86c3f6e27fe0b60d525": "2ca4f58 chore: add Android builds v26.7.26 [skip ci]" | kind=Commit | source=git | neighbors=[01d6dd3 Merge branch 'main' of https://…, main, 845dfcb feat: fast offline-speed initia…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@2e3bece67d668d47048f8580a227a6e6dfb969d3": "2e3bece chore: add Android builds v26.7.12 [skip ci]" | kind=Commit | source=git | neighbors=[main, aaf383b fix: update free capacity limit…, f782455 feat: implement target section …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@358ddb361d3817a90c18e4fa13f4d1541e99afcf": "358ddb3 chore: add Android builds v26.7.22 [skip ci]" | kind=Commit | source=git | neighbors=[main, 1dc8e69 fix(python & flashcard): fix An…, 8a51c13 fix(python & formats): disable …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@3fb655e0e9ca2e4acf442f6f58864a2af998f6e3": "3fb655e chore: update knowledge graph after AI queue cleanup" | kind=Commit | source=git | neighbors=[main, e0b1be4 fix1, d6812c1 feat: add Run now quick-run for…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@40267425bc4f6e929d069e2a47acb18e516373d2": "4026742 chore: add Android builds v26.7.12 [skip ci]" | kind=Commit | source=git | neighbors=[main, c83829c deadine v2, eb1723a fix: preserve Navigator result …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@4344098c7af75428ef038daf5714b022bb7b025f": "4344098 chore: add Android builds v26.7.22 [skip ci]" | kind=Commit | source=git | neighbors=[4147f0b Fix Android ProcessEnvironment …, main, 2d60cdb feat: add AI provider model tes…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@458dd1e8ee1bf866b8e406a18b953acbb9bc1bbf": "458dd1e chore: add Android builds v26.8.1 [skip ci]" | kind=Commit | source=git | neighbors=[main, e53d2de Share PDF, c5f6e32 new] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@46cb1a95694ffefc3a0f6b3c92f64d55119ca1eb": "46cb1a9 chore: release engineering for v27.0.0 (Phase 6)" | kind=Commit | source=git | neighbors=[main, 5e5211c Merge branch 'main' of https://…, 8554e22 feat: the web build compiles an…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@4793d65596f1204373dabd43c226411257165494": "4793d65 chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, 317ac5d Merge branch 'main' of https://…, 65220a0 fix: WebAssembly check and wind…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@56086120bc963f2800c34a180ecb225588748b88": "5608612 chore: add Android and Windows builds v26.7.4 [skip ci]" | kind=Commit | source=git | neighbors=[main, ed71b03 io, e0b1be4 fix1] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@573536b3597f359d763af86a3e2ccef1fa32db52": "573536b rebrand: new Sirius black-hole app icon" | kind=Commit | source=git | neighbors=[main, f2613a9 theme: celestial palette with l…, e9979c0 rebrand: rename app display nam…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@589f5de5aeb01ca5bcb56ed5b9e8b549987b642d": "589f5de feat: deterministic contents-to-pages mapping (Phase 1)" | kind=Commit | source=git | neighbors=[main, 0270948 feat: move shared secrets to au…, ed71b03 io] | lang=nl
- "commit:repo:github.com/ihjas-ahammed/duofy@5aeefed260953053572959694af3c96e68000ec7": "5aeefed chore: add Android builds v26.7.22 [skip ci]" | kind=Commit | source=git | neighbors=[main, d19afe4 Fix serious_python_linux copyin…, eb38f80 Fix Linux quit handling, Linux …] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@5f9d253a0512f3ee459099bd54896f96abb2c2de": "5f9d253 chore: add Android builds v26.7.10 [skip ci]" | kind=Commit | source=git | neighbors=[3cff7f6 REALLY!, main, 8938325 feat: layout-based course progr…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@67c2b34d5d0662ccb2420e10fd9e5adb319a0af1": "67c2b34 chore: add Android builds v26.7.26 [skip ci]" | kind=Commit | source=git | neighbors=[main, 01d6dd3 Merge branch 'main' of https://…, 859f766 new] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@693d260112318e10a899c062d00fc92be4ed2195": "693d260 GRAPHYFI FIX" | kind=Commit | source=git | neighbors=[010c32d chore: add Android and Windows …, main, ca30680 docs: add auto-indexing pipelin…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@6b3299a86a4cfc2c8986954add8fce2198d25bd8": "6b3299a chore: add Android builds v26.7.12 [skip ci]" | kind=Commit | source=git | neighbors=[25fb4a6 fix: reset FlashcardView state …, main, eb1723a fix: preserve Navigator result …] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@74cc3a635c0839457217429cc8237f0d85dce38e": "74cc3a6 chore: add Android and Windows builds v26.6.24 [skip ci]" | kind=Commit | source=git | neighbors=[main, 675d2a1 EXPRESS, a055e9b PRE-RE] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@7a4966f5b0452347b0f9f3c9271b55186c649ff6": "7a4966f chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, ec6f1f9 feat: unify restore PDF picker …, 9535e64 k] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@7cb1aa63deed2193c2be30c2afa7615e7fa6b28d": "7cb1aa6 RMY" | kind=Commit | source=git | neighbors=[13b10df chore: add Android builds v27.0…, main, d68d72b XZ] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@7e1307968ccb9ad3dc79874777e7c1eefb3e9753": "7e13079 docs: add AI queue cleanup design spec" | kind=Commit | source=git | neighbors=[main, ab5d5ed docs: add AI queue cleanup impl…, c11bc98 chore: update knowledge graph a…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@7e90faf6e262e838f763fa74b141918e31855e0b": "7e90faf chore: add Android builds v26.8.1 [skip ci]" | kind=Commit | source=git | neighbors=[main, c5f6e32 new, a15c42e feat(daily-goals): Add Gamified…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@819cacbfe63bfbb08f77a7ac7ddd3bc4123baf89": "819cacb chore: add Android builds v26.7.10 [skip ci]" | kind=Commit | source=git | neighbors=[4ea5161 Merge pull request #3 from ihja…, main, 0a59fe5 Merge pull request #4 from ihja…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@88176b7a901ce7060694cb3d29205ed6e69c81de": "88176b7 chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[1fa1705 OK, main, b99cbf3 OK] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@8cff8c99343db604640db802ac9d4b8212a72465": "8cff8c9 feat: route auto-index failures to manual picker instead of dead-ending" | kind=Commit | source=git | neighbors=[20f459c feat: rewrite AutoIndexService …, main, 482623d feat: remove manual indexing-me…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@916308a4f1b515ad095aca25841073adaa565466": "916308a docs: add auto-indexing pipeline implementation plan" | kind=Commit | source=git | neighbors=[main, 742f017 feat: add offline TocMatcher he…, ca30680 docs: add auto-indexing pipelin…] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@994c7de4db508a7c39c0d135745c7f1ac6ec9a80": "994c7de chore: add Android and Windows builds v26.6.5 [skip ci]" | kind=Commit | source=git | neighbors=[main, a055e9b PRE-RE, c476ed9 555555555555555555555555555upp] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9b43b6dee91d1d3471c913b064a3d2591b2589cb": "9b43b6d chore: add Android and Windows builds v26.6.25 [skip ci]" | kind=Commit | source=git | neighbors=[085e90d quick fix, main, 9981c72 z] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9d00f5b88b0c9caf9de965d1211ff8c228ce6c56": "9d00f5b chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[4ead8b6 z, main, 3b989f1 Bump version to 26.7.22+2026072…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9ecc455e4a9605a31e153db7886bf157c760d1a0": "9ecc455 chore: add Android and Windows builds v26.6.25 [skip ci]" | kind=Commit | source=git | neighbors=[675d2a1 EXPRESS, main, 085e90d quick fix] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@9fa942f3c0f280debc86b53b44c15339b261b088": "9fa942f chore: add Android and Windows builds v26.7.4 [skip ci]" | kind=Commit | source=git | neighbors=[main, 5e5211c Merge branch 'main' of https://…, ed71b03 io] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@ab5d5ed09fb514dc26f802d19b5eba78d96c6ac8": "ab5d5ed docs: add AI queue cleanup implementation plan" | kind=Commit | source=git | neighbors=[7e13079 docs: add AI queue cleanup desi…, main, 4337110 feat: remove AI 10-page chunk s…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@bed7aca0fed19d8293cd22ed6b65a397303170cf": "bed7aca chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, c71d757 orgainze apis, c83829c deadine v2] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@c11bc981a14c40b3489db5a5a1f85ae20bbfbb7d": "c11bc98 chore: update knowledge graph after auto-indexing pipeline" | kind=Commit | source=git | neighbors=[482623d feat: remove manual indexing-me…, main, 7e13079 docs: add AI queue cleanup desi…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@c5f6e32833e5262e0846ed4daec2b5356e70579f": "c5f6e32 new" | kind=Commit | source=git | neighbors=[7e90faf chore: add Android builds v26.8…, main, 458dd1e chore: add Android builds v26.8…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@c8874a6ae8567c02efabc76a4982051ad042dddc": "c8874a6 chore: add Android builds v26.7.15 [skip ci]" | kind=Commit | source=git | neighbors=[main, 3f4d091 Merge branch 'main' of https://…, ec6f1f9 feat: unify restore PDF picker …] | lang=pt
- "commit:repo:github.com/ihjas-ahammed/duofy@ca30680c2b169ef4b6822deb0a620abb7a3234ad": "ca30680 docs: add auto-indexing pipeline design spec" | kind=Commit | source=git | neighbors=[693d260 GRAPHYFI FIX, main, 916308a docs: add auto-indexing pipelin…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d19afe4ff341f24ab75e54d3a38449c7ac276e6e": "d19afe4 Fix serious_python_linux copying root directory when SERIOUS_PYTHON_SIT…" | kind=Commit | source=git | neighbors=[5aeefed chore: add Android builds v26.7…, main, 0774610 Update graphify index for CMake…] | lang=en
- "commit:repo:github.com/ihjas-ahammed/duofy@d1b807670e70252e6e5d15786d2bae9c4619194b": "d1b8076 chore: add Android builds v26.7.12 [skip ci]" | kind=Commit | source=git | neighbors=[39500a4 fix: correct deadline target co…, main, 25fb4a6 fix: reset FlashcardView state …] | lang=en

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-009.json

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
