# Node Description Batch 17 of 61

Graphify is running in assistant/skill mode (no API key). You are the host
assistant (Claude Code / Codex / Gemini CLI). Read the prompt below and write
your JSON answer to the answer file.

## Prompt

You are documenting nodes in a knowledge graph.
For each entry below, write ONE concise factual plain-language sentence
describing what it is or does. Use only the provided context.
For a code symbol (kind=code-symbol — a function, class, or constant),
describe what the function/symbol does based on its name, source location
and neighbors — e.g. "Resolves the configured ontology profile from graphify.yaml.".
Write every description in English (en). Do not switch languages.
No marketing language.
Respond ONLY with a JSON object mapping each node id (as a string) to its
one-sentence description — no prose, no markdown fences.

- "fb_fb_core_initializeapp": "initializeApp()" | kind=code-symbol | source=lib/services/fb/fb_core.dart:L25 | neighbors=[fb_core.dart]
- "fb_fb_firestore_cfcollection": "_CfCollection" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L49 | neighbors=[fb_firestore.dart]
- "fb_fb_firestore_cfdoc": "_CfDoc" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L63 | neighbors=[fb_firestore.dart]
- "fb_fb_firestore_cffirestore": "_CfFirestore" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L43 | neighbors=[fb_firestore.dart]
- "fb_fb_firestore_delete": "delete()" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L24 | neighbors=[fb_firestore.dart]
- "fb_fb_firestore_fbcollectionref": "FbCollectionRef" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L28 | neighbors=[fb_firestore.dart]
- "fb_fb_firestore_fbdocref": "FbDocRef" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L20 | neighbors=[fb_firestore.dart]
- "fb_fb_firestore_fbdocsnapshot": "FbDocSnapshot" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L7 | neighbors=[fb_firestore.dart]
- "fb_fb_firestore_fbfirestore": "FbFirestore" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L33 | neighbors=[fb_firestore.dart]
- "fb_fb_firestore_fbquerysnapshot": "FbQuerySnapshot" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L15 | neighbors=[fb_firestore.dart]
- "fb_fb_firestore_get": "get()" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L23 | neighbors=[fb_firestore.dart]
- "fb_fb_firestore_set": "set()" | kind=code-symbol | source=lib/services/fb/fb_firestore.dart:L22 | neighbors=[fb_firestore.dart]
- "fb_fd_backend_createuserwithemailandpassword": "createUserWithEmailAndPassword()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L175 | neighbors=[fd_backend.dart]
- "fb_fd_backend_delete": "delete()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L78 | neighbors=[fd_backend.dart]
- "fb_fd_backend_extractfiredarterror": "_extractFiredartError()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L198 | neighbors=[fd_backend.dart]
- "fb_fd_backend_fdauthbackend": "FdAuthBackend" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L109 | neighbors=[fd_backend.dart]
- "fb_fd_backend_fdcollection": "_FdCollection" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L215 | neighbors=[fd_backend.dart]
- "fb_fd_backend_fddoc": "_FdDoc" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L233 | neighbors=[fd_backend.dart]
- "fb_fd_backend_fdfirestorebackend": "FdFirestoreBackend" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L209 | neighbors=[fd_backend.dart]
- "fb_fd_backend_fduser": "_FdUser" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L92 | neighbors=[fd_backend.dart]
- "fb_fd_backend_filetokenstore": "_FileTokenStore" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L37 | neighbors=[fd_backend.dart]
- "fb_fd_backend_get": "get()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L221 | neighbors=[fd_backend.dart]
- "fb_fd_backend_hydrate": "_hydrate()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L135 | neighbors=[fd_backend.dart]
- "fb_fd_backend_initializefiredart": "initializeFiredart()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L21 | neighbors=[fd_backend.dart]
- "fb_fd_backend_set": "set()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L239 | neighbors=[fd_backend.dart]
- "fb_fd_backend_signinwithemailandpassword": "signInWithEmailAndPassword()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L162 | neighbors=[fd_backend.dart]
- "fb_fd_backend_signout": "signOut()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L188 | neighbors=[fd_backend.dart]
- "fb_fd_backend_stub_fdauthbackend": "FdAuthBackend" | kind=code-symbol | source=lib/services/fb/fd_backend_stub.dart:L12 | neighbors=[fd_backend_stub.dart]
- "fb_fd_backend_stub_fdfirestorebackend": "FdFirestoreBackend" | kind=code-symbol | source=lib/services/fb/fd_backend_stub.dart:L21 | neighbors=[fd_backend_stub.dart]
- "fb_fd_backend_stub_initializefiredart": "initializeFiredart()" | kind=code-symbol | source=lib/services/fb/fd_backend_stub.dart:L8 | neighbors=[fd_backend_stub.dart]
- "fb_fd_backend_stub_nosuchmethod": "noSuchMethod()" | kind=code-symbol | source=lib/services/fb/fd_backend_stub.dart:L17 | neighbors=[fd_backend_stub.dart]
- "fb_fd_backend_updatedisplayname": "updateDisplayName()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L102 | neighbors=[fd_backend.dart]
- "fb_fd_backend_write": "write()" | kind=code-symbol | source=lib/services/fb/fd_backend.dart:L63 | neighbors=[fd_backend.dart]
- "flutter_generated_plugin_registrant_fl_register_plugins": "fl_register_plugins()" | kind=code-symbol | source=packages/webview_cef/example/linux/flutter/generated_plugin_registrant.cc:L11 | neighbors=[generated_plugin_registrant.h]
- "flutter_generated_plugin_registrant_registerplugins": "RegisterPlugins()" | kind=code-symbol | source=windows/flutter/generated_plugin_registrant.cc:L23 | neighbors=[generated_plugin_registrant.h]
- "ide_code_ide_screen_codeidescreen": "CodeIdeScreen" | kind=code-symbol | source=lib/screens/ide/code_ide_screen.dart:L10 | neighbors=[code_ide_screen.dart]
- "ide_code_ide_screen_codeidescreenstate": "_CodeIdeScreenState" | kind=code-symbol | source=lib/screens/ide/code_ide_screen.dart:L17 | neighbors=[code_ide_screen.dart]
- "ide_code_ide_screen_deleteproject": "_deleteProject()" | kind=code-symbol | source=lib/screens/ide/code_ide_screen.dart:L61 | neighbors=[code_ide_screen.dart]
- "ide_code_ide_screen_initstate": "initState()" | kind=code-symbol | source=lib/screens/ide/code_ide_screen.dart:L22 | neighbors=[code_ide_screen.dart]
- "ide_code_ide_screen_loadprojects": "_loadProjects()" | kind=code-symbol | source=lib/screens/ide/code_ide_screen.dart:L27 | neighbors=[code_ide_screen.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-016.json

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
