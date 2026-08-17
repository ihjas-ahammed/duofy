# Node Description Batch 57 of 61

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

- "widgets_lesson_assistant_chat_addsystemmessage": "_addSystemMessage()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L139 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_chatmessage": "ChatMessage" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L20 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_connectwebsocket": "_connectWebSocket()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L147 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_disconnectwebsocket": "_disconnectWebSocket()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L394 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L103 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_handlewebsocketclosed": "_handleWebSocketClosed()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L383 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_handlewebsocketerror": "_handleWebSocketError()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L378 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_handlewebsocketmessage": "_handleWebSocketMessage()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L243 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_initstate": "initState()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L81 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_inittts": "_initTts()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L124 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_lessonassistantchat": "LessonAssistantChat" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L36 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_lessonassistantchatstate": "_LessonAssistantChatState" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L56 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_loadcustompromptandconnect": "_loadCustomPromptAndConnect()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L92 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_playrawpcm": "_playRawPcm()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L472 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_scrolltobottom": "_scrollToBottom()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L701 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_sendnormalmodelmessage": "_sendNormalModelMessage()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L603 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_sendtextmessage": "_sendTextMessage()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L575 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_sendvoicemessage": "_sendVoiceMessage()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L535 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_startrecording": "_startRecording()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L488 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_stoprecording": "_stopRecording()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L517 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_node_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L278 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L289 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_initstate": "initState()" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L268 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_lessonnodewidget": "LessonNodeWidget" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L328 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_lessonnodewidgetstate": "_LessonNodeWidgetState" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L363 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_nextnodepop": "NextNodePop" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L254 | neighbors=[lesson_node.dart]
- "widgets_lesson_node_nextnodepopstate": "_NextNodePopState" | kind=code-symbol | source=lib/widgets/lesson_node.dart:L263 | neighbors=[lesson_node.dart]
- "widgets_lesson_path_activegeneratingnodewrapper": "_ActiveGeneratingNodeWrapper" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L1344 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_activegeneratingnodewrapperstate": "_ActiveGeneratingNodeWrapperState" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L1362 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_confirm": "_confirm()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L1135 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L106 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L122 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_element": "_Element" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L695 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_function": "Function()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L37 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_initstate": "initState()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L100 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_launchnextlesson": "_launchNextLesson()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L185 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_lessonpath": "LessonPath" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L21 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_lessonpathstate": "_LessonPathState" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L93 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_loadlastlesson": "_loadLastLesson()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L127 | neighbors=[lesson_path.dart]
- "widgets_lesson_path_paint": "paint()" | kind=code-symbol | source=lib/widgets/lesson_path.dart:L787 | neighbors=[lesson_path.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-056.json

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
