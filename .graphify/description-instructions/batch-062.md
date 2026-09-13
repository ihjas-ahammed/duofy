# Node Description Batch 63 of 68

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

- "widgets_ide_config_dialog_ideconfigdialogstate": "_IdeConfigDialogState" | kind=code-symbol | source=lib/widgets/ide_config_dialog.dart:L22 | neighbors=[ide_config_dialog.dart]
- "widgets_ide_config_dialog_initstate": "initState()" | kind=code-symbol | source=lib/widgets/ide_config_dialog.dart:L26 | neighbors=[ide_config_dialog.dart]
- "widgets_ide_config_dialog_show": "show()" | kind=code-symbol | source=lib/widgets/ide_config_dialog.dart:L9 | neighbors=[ide_config_dialog.dart]
- "widgets_ide_config_dialog_update": "_update()" | kind=code-symbol | source=lib/widgets/ide_config_dialog.dart:L31 | neighbors=[ide_config_dialog.dart]
- "widgets_lazy_indexed_stack_didupdatewidget": "didUpdateWidget()" | kind=code-symbol | source=lib/widgets/lazy_indexed_stack.dart:L38 | neighbors=[lazy_indexed_stack.dart]
- "widgets_lazy_indexed_stack_initstate": "initState()" | kind=code-symbol | source=lib/widgets/lazy_indexed_stack.dart:L29 | neighbors=[lazy_indexed_stack.dart]
- "widgets_lazy_indexed_stack_lazyindexedstack": "LazyIndexedStack" | kind=code-symbol | source=lib/widgets/lazy_indexed_stack.dart:L7 | neighbors=[lazy_indexed_stack.dart]
- "widgets_lazy_indexed_stack_lazyindexedstackstate": "_LazyIndexedStackState" | kind=code-symbol | source=lib/widgets/lazy_indexed_stack.dart:L25 | neighbors=[lazy_indexed_stack.dart]
- "widgets_learner_profile_card_function": "Function()" | kind=code-symbol | source=lib/widgets/learner_profile_card.dart:L47 | neighbors=[learner_profile_card.dart]
- "widgets_learner_profile_card_initstate": "initState()" | kind=code-symbol | source=lib/widgets/learner_profile_card.dart:L25 | neighbors=[learner_profile_card.dart]
- "widgets_learner_profile_card_learnerprofilecard": "LearnerProfileCard" | kind=code-symbol | source=lib/widgets/learner_profile_card.dart:L11 | neighbors=[learner_profile_card.dart]
- "widgets_learner_profile_card_learnerprofilecardstate": "_LearnerProfileCardState" | kind=code-symbol | source=lib/widgets/learner_profile_card.dart:L18 | neighbors=[learner_profile_card.dart]
- "widgets_learner_profile_card_load": "_load()" | kind=code-symbol | source=lib/widgets/learner_profile_card.dart:L30 | neighbors=[learner_profile_card.dart]
- "widgets_learner_profile_card_savebool": "_saveBool()" | kind=code-symbol | source=lib/widgets/learner_profile_card.dart:L109 | neighbors=[learner_profile_card.dart]
- "widgets_learner_profile_card_savestring": "_saveString()" | kind=code-symbol | source=lib/widgets/learner_profile_card.dart:L118 | neighbors=[learner_profile_card.dart]
- "widgets_lesson_accordion_findactiveunit": "_findActiveUnit()" | kind=code-symbol | source=lib/widgets/lesson_accordion.dart:L41 | neighbors=[lesson_accordion.dart]
- "widgets_lesson_accordion_initstate": "initState()" | kind=code-symbol | source=lib/widgets/lesson_accordion.dart:L36 | neighbors=[lesson_accordion.dart]
- "widgets_lesson_accordion_lessonaccordion": "LessonAccordion" | kind=code-symbol | source=lib/widgets/lesson_accordion.dart:L10 | neighbors=[lesson_accordion.dart]
- "widgets_lesson_accordion_lessonaccordionstate": "_LessonAccordionState" | kind=code-symbol | source=lib/widgets/lesson_accordion.dart:L32 | neighbors=[lesson_accordion.dart]
- "widgets_lesson_accordion_openlesson": "_openLesson()" | kind=code-symbol | source=lib/widgets/lesson_accordion.dart:L76 | neighbors=[lesson_accordion.dart]
- "widgets_lesson_assistant_chat_addsystemmessage": "_addSystemMessage()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L145 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_chatmessage": "ChatMessage" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L20 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_connectwebsocket": "_connectWebSocket()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L153 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_disconnectwebsocket": "_disconnectWebSocket()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L402 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_dispose": "dispose()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L104 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_handlewebsocketclosed": "_handleWebSocketClosed()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L390 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_handlewebsocketerror": "_handleWebSocketError()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L384 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_handlewebsocketmessage": "_handleWebSocketMessage()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L249 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_initstate": "initState()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L82 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_inittts": "_initTts()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L130 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_lessonassistantchat": "LessonAssistantChat" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L36 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_lessonassistantchatstate": "_LessonAssistantChatState" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L56 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_loadcustompromptandconnect": "_loadCustomPromptAndConnect()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L93 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_playrawpcm": "_playRawPcm()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L486 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_scrolltobottom": "_scrollToBottom()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L715 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_sendnormalmodelmessage": "_sendNormalModelMessage()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L617 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_sendtextmessage": "_sendTextMessage()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L589 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_sendvoicemessage": "_sendVoiceMessage()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L549 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_startrecording": "_startRecording()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L502 | neighbors=[lesson_assistant_chat.dart]
- "widgets_lesson_assistant_chat_stoprecording": "_stopRecording()" | kind=code-symbol | source=lib/widgets/lesson_assistant_chat.dart:L531 | neighbors=[lesson_assistant_chat.dart]

## Instructions

Write a single JSON object mapping each node id to a one-sentence description
to: /home/ihjas/Documents/GitHub/duofy/.graphify/description-instructions/batch-062.json

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
