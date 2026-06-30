import 'dart:convert';

String _str(dynamic val, [String def = '']) {
  if (val == null) return def;
  if (val is String) return val;
  if (val is Map || val is List) return jsonEncode(val);
  return val.toString();
}

String? _strOpt(dynamic val) {
  if (val == null) return null;
  if (val is String) return val;
  if (val is Map || val is List) return jsonEncode(val);
  return val.toString();
}

double? _dblOpt(dynamic val) {
  if (val == null) return null;
  if (val is num) return val.toDouble();
  if (val is String) return double.tryParse(val);
  return null;
}

bool _bool(dynamic val, [bool def = false]) {
  if (val == null) return def;
  if (val is bool) return val;
  if (val is String) return val.toLowerCase() == 'true';
  if (val is num) return val > 0;
  return def;
}

class SlideTemplate {
  final String type;
  final String condition;
  final String description;

  SlideTemplate({required this.type, required this.condition, required this.description});

  factory SlideTemplate.fromJson(Map<String, dynamic> json) {
    return SlideTemplate(
      type: _str(json['type']),
      condition: _str(json['condition'], 'Always'),
      description: _str(json['description']),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'condition': condition,
    'description': description,
  };

  static List<SlideTemplate> get defaultTemplate => [
    SlideTemplate(type: 'theory', condition: 'Always', description: 'The original factual theory and core concepts presented directly, with no storytelling, narrative framing, or example-based scenarios.'),
    SlideTemplate(type: 'concept_pieces', condition: 'Always', description: 'A conceptual breakdown showing a complex or long concept split into a series of short, connected, easy-to-read sentences or bullet-points.'),
    SlideTemplate(type: 'proof', condition: 'Only if a mathematical, physical, or logical proof is being taught.', description: 'Interactive step-by-step logic proof.'),
    SlideTemplate(type: 'fill_in_blank', condition: 'Always', description: 'Recall key terms with a fill-in-the-blank question.'),
    SlideTemplate(type: 'one_word', condition: 'Always', description: 'Recall a single key term by typing it as a one-word answer (no options shown).'),
    SlideTemplate(type: 'numerical', condition: 'Only if the topic involves a calculation or a quantitative value the learner can compute.', description: 'A problem whose answer is a number the learner types in.'),
    SlideTemplate(type: 'quiz', condition: 'Always', description: 'A multiple-choice question testing understanding.'),
    SlideTemplate(type: 'descriptive', condition: 'Always', description: 'A question requiring a paragraph explanation and optional photo upload, reviewed by AI.'),
    SlideTemplate(type: 'custom_html', condition: 'Only when custom interactive elements, custom simulators, or unique game/HTML mechanics are needed.', description: 'An interactive custom slide written in HTML and Javascript. Can contain buttons, text inputs, canvases, sliders, and logic. Calls DuoMessageChannel.postMessage("complete") when completed.'),
  ];
}

/// A named collection of [SlideTemplate]s used to generate one kind of
/// lesson (e.g. "Theory", "Worked Example", "Proof Walkthrough"). A book
/// owns multiple formats; each unit can be tagged with one so different
/// units in the same book are generated against different pedagogical
/// templates.
class LessonFormat {
  final String id;
  final String name;
  final String description;
  final List<SlideTemplate> slides;

  LessonFormat({
    required this.id,
    required this.name,
    required this.description,
    required this.slides,
  });

  factory LessonFormat.fromJson(Map<String, dynamic> json) {
    return LessonFormat(
      id: _str(json['id']),
      name: _str(json['name'], 'Format'),
      description: _str(json['description']),
      slides: (json['slides'] as List?)
              ?.map((s) => SlideTemplate.fromJson(s is Map ? Map<String, dynamic>.from(s) : {}))
              .toList() ??
          SlideTemplate.defaultTemplate,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'slides': slides.map((s) => s.toJson()).toList(),
      };

  LessonFormat copyWith({String? id, String? name, String? description, List<SlideTemplate>? slides}) =>
      LessonFormat(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        slides: slides ?? this.slides,
      );

  /// The starter pack a new book gets when the user hasn\'t configured
  /// anything yet. Three commonly-needed formats covering general theory,
  /// worked examples, and proofs. Settings can add/edit/remove freely.
  static List<LessonFormat> get defaultFormats => [
        LessonFormat(
          id: 'default',
          name: 'Theory',
          description: 'Standard theory lesson: definitions, explanation, recall checks, quiz.',
          slides: SlideTemplate.defaultTemplate,
        ),
        LessonFormat(
          id: 'worked-example',
          name: 'Worked Example',
          description: 'A single solved problem broken into interactive steps.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Restate the problem and the technique being used in 1-2 sentences.'),
            SlideTemplate(type: 'step_by_step', condition: 'Always', description: 'Solve the example as an interactive multi-step walkthrough where the learner picks the next step.'),
            SlideTemplate(type: 'numerical', condition: 'Only if the example produces a numeric result.', description: 'A follow-up problem where the learner computes and types the numeric answer.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'A multiple-choice follow-up applying the same technique to a near-identical problem.'),
          ],
        ),
        LessonFormat(
          id: 'proof-walkthrough',
          name: 'Proof Walkthrough',
          description: 'Step-by-step derivation of a theorem or formula.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'State the theorem/result and the intuition for why it holds in 1-2 sentences.'),
            SlideTemplate(type: 'proof', condition: 'Always', description: 'Full interactive step-by-step proof.'),
            SlideTemplate(type: 'fill_in_blank', condition: 'Always', description: 'Recall the key inequality, identity or definition that powered the proof.'),
          ],
        ),
        LessonFormat(
          id: 'interleaved-practice',
          name: 'Interleaved Practice',
          description: 'A mix of different problem types to avoid illusion of competence and force the brain to recognize patterns.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Brief introduction to the set of problems and why they are mixed.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'A question applying concept A.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'A question applying a completely different concept B.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Another question applying concept A or C.'),
          ],
        ),
        LessonFormat(
          id: 'active-retrieval',
          name: 'Active Retrieval',
          description: 'Testing purely from memory. No theory first. Forces the learner to recall information they should already know.',
          slides: [
            SlideTemplate(type: 'fill_in_blank', condition: 'Always', description: 'Recall a core definition or rule from memory.'),
            SlideTemplate(type: 'one_word', condition: 'Always', description: 'Recall a key term without hints.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'A deeper conceptual question testing understanding, not just memory.'),
          ],
        ),
        LessonFormat(
          id: 'elaboration',
          name: 'Elaboration',
          description: 'Explaining concepts in detail, connecting them to prior knowledge.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Present a complex concept and relate it to a simpler, known concept.'),
            SlideTemplate(type: 'concept_pieces', condition: 'Always', description: 'Break down the connections step-by-step.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Test if the learner understands the relationship between the new and old concepts.'),
          ],
        ),
        LessonFormat(
          id: 'chunking-focus',
          name: 'Chunking Focus',
          description: 'Breaking down a large, intimidating concept into tiny, digestible pieces (chunks) before assembling them.',
          slides: [
            SlideTemplate(type: 'concept_pieces', condition: 'Always', description: 'Introduce the pieces of the chunk individually.'),
            SlideTemplate(type: 'fill_in_blank', condition: 'Always', description: 'Test recall on one specific piece of the chunk.'),
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Show how the pieces connect together into the final "chunk".'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Test understanding of the fully assembled chunk.'),
          ],
        ),
        LessonFormat(
          id: 'spaced-review',
          name: 'Spaced Review',
          description: 'A format dedicated to reviewing past material while lightly introducing a new hook.',
          slides: [
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'A question from a previous topic.'),
            SlideTemplate(type: 'numerical', condition: 'If applicable', description: 'A calculation from a previous topic.'),
            SlideTemplate(type: 'theory', condition: 'Always', description: 'A brief introduction to today\'s new topic connecting it to the reviewed material.'),
          ],
        ),
        LessonFormat(
          id: 'concrete-examples',
          name: 'Concrete Examples',
          description: 'Real-world grounding of abstract, theoretical ideas.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'State the abstract rule or theorem.'),
            SlideTemplate(type: 'concept_pieces', condition: 'Always', description: 'Provide 2-3 specific, real-world concrete examples of the rule in action.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Ask the learner to identify whether a new real-world scenario fits the rule.'),
          ],
        ),
        LessonFormat(
          id: 'feynman-technique',
          name: 'Feynman Technique',
          description: 'Teaching a concept using extremely simple language, as if to a child, avoiding jargon.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Explain the core idea using zero technical jargon.'),
            SlideTemplate(type: 'concept_pieces', condition: 'Always', description: 'Break down why it works using an intuitive analogy.'),
            SlideTemplate(type: 'fill_in_blank', condition: 'Always', description: 'Check understanding of the simple analogy.'),
          ],
        ),
        LessonFormat(
          id: 'contrasting-cases',
          name: 'Contrasting Cases',
          description: 'Comparing two similar but distinct concepts to highlight their key differences.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Introduce Concept A and Concept B side-by-side.'),
            SlideTemplate(type: 'concept_pieces', condition: 'Always', description: 'Highlight exactly what makes them different (the boundary condition).'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Present a scenario and ask if it is Concept A or Concept B.'),
          ],
        ),
        LessonFormat(
          id: 'error-analysis',
          name: 'Error Analysis',
          description: 'Identifying mistakes in a flawed solution or misconception.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Present a common misconception or a flawed step-by-step solution.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Ask the learner to identify EXACTLY where the mistake happened.'),
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Explain the correct reasoning and why the mistake is common.'),
          ],
        ),
        LessonFormat(
          id: 'rule-abstraction',
          name: 'Rule Abstraction',
          description: 'Deriving a general rule from several specific examples (inductive learning).',
          slides: [
            SlideTemplate(type: 'concept_pieces', condition: 'Always', description: 'Show 3 different examples that all share a hidden underlying pattern.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Ask the learner to guess the underlying rule or pattern.'),
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Formally state the abstracted rule.'),
          ],
        ),
        LessonFormat(
          id: 'low-stakes-testing',
          name: 'Low-Stakes Testing',
          description: 'Rapid-fire easy questions to build fluency and confidence.',
          slides: [
            SlideTemplate(type: 'one_word', condition: 'Always', description: 'Fast recall question 1.'),
            SlideTemplate(type: 'one_word', condition: 'Always', description: 'Fast recall question 2.'),
            SlideTemplate(type: 'fill_in_blank', condition: 'Always', description: 'Fast recall question 3.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'A slightly harder conceptual question.'),
          ],
        ),
        LessonFormat(
          id: 'desirable-difficulty',
          name: 'Desirable Difficulty',
          description: 'A deliberately hard problem without immediate hints, forcing deep cognitive effort.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Set up a challenging problem that requires synthesizing multiple ideas.'),
            SlideTemplate(type: 'numerical', condition: 'If a number is expected', description: 'The hard problem itself.'),
            SlideTemplate(type: 'step_by_step', condition: 'Always', description: 'Break down the solution after they have attempted it.'),
          ],
        ),
        LessonFormat(
          id: 'generation-effect',
          name: 'Generation Effect',
          description: 'Attempting to solve or guess an answer before being taught the material.',
          slides: [
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Ask an intuitive question about a topic they haven\'t learned yet.'),
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Explain the actual theory, showing whether their intuition was right.'),
            SlideTemplate(type: 'concept_pieces', condition: 'Always', description: 'Formalize the new knowledge.'),
          ],
        ),
        LessonFormat(
          id: 'analogical-transfer',
          name: 'Analogical Transfer',
          description: 'Applying a solution from one context to a totally different, unfamiliar context.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Remind the learner of a known solution in Context X.'),
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Introduce a seemingly different problem in Context Y.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Ask them to apply the mechanism from X to solve Y.'),
          ],
        ),
        LessonFormat(
          id: 'metacognition-check',
          name: 'Metacognition Check',
          description: 'Evaluating one\'s own understanding and mental models.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Summarize a complex topic briefly.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'A highly tricky distractor question that tests deep understanding versus surface illusion of competence.'),
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Explain why the tricky distractor catches people off guard.'),
          ],
        ),
        LessonFormat(
          id: 'synthesis-challenge',
          name: 'Synthesis Challenge',
          description: 'Combining multiple previously learned concepts into one grand problem.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'State the grand challenge that requires 2+ concepts.'),
            SlideTemplate(type: 'step_by_step', condition: 'Always', description: 'Walk through the multi-stage synthesis.'),
            SlideTemplate(type: 'numerical', condition: 'If applicable', description: 'Final calculation of the synthesized problem.'),
          ],
        ),
        LessonFormat(
          id: 'priming-preview',
          name: 'Priming Preview',
          description: 'A brief, lightweight preview of advanced topics without expecting mastery yet.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Show a glimpse of a future, more advanced topic.'),
            SlideTemplate(type: 'concept_pieces', condition: 'Always', description: 'Point out what makes it interesting or useful.'),
            SlideTemplate(type: 'one_word', condition: 'Always', description: 'A very basic vocabulary check on the new concept name.'),
          ],
        ),
        LessonFormat(
          id: 'visual-dual-coding',
          name: 'Visual Dual-Coding',
          description: 'Relies heavily on visual or structural layout to pair with text.',
          slides: [
            SlideTemplate(type: 'custom_html', condition: 'Always', description: 'An interactive or highly visual representation of the concept.'),
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Textual explanation linking to what they just saw.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Test understanding of the visual relationship.'),
          ],
        ),
        LessonFormat(
          id: 'deliberate-practice',
          name: 'Deliberate Practice',
          description: 'Targeted practice on a specific sub-skill with immediate feedback.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Isolate the specific sub-skill being practiced.'),
            SlideTemplate(type: 'step_by_step', condition: 'Always', description: 'Walk through executing this single sub-skill.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'A rapid check to ensure the sub-skill is mastered.'),
          ],
        ),
        LessonFormat(
          id: 'first-principles',
          name: 'First Principles',
          description: 'Breaking a complex problem down to its most fundamental, undeniable truths.',
          slides: [
            SlideTemplate(type: 'theory', condition: 'Always', description: 'Strip away the complexity and state the absolute fundamental truth (first principle).'),
            SlideTemplate(type: 'concept_pieces', condition: 'Always', description: 'Build the complex idea back up logically from the first principle.'),
            SlideTemplate(type: 'quiz', condition: 'Always', description: 'Test if the logic connecting the principle to the conclusion holds.'),
          ],
        ),
      ];
}

class Book {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String? systemPrompt;
  /// Free-text instructions the user supplies at book-creation time. Unlike
  /// [systemPrompt] (which the AI generates), this is verbatim user guidance
  /// (e.g. "focus on exam-style worked examples", "keep theory minimal").
  /// It is injected into every downstream generation prompt — skeleton,
  /// unit planner, and lesson generation — so the whole course honours it.
  final String? customInstructions;
  final int? updatedAt;
  final String? authorId;
  final String? authorName;
  final bool isGlobal;
  final List<Module> modules;
  final List<QuestionPaper> questionPapers;
  /// Named collections of slide templates. A book carries several so that
  /// different units (theory vs. example vs. proof) can be generated with
  /// different pedagogical structures. Always non-empty after parsing — an
  /// old book's single `lessonTemplate` is migrated into a "default"
  /// format on read, and books missing both fields fall back to
  /// [LessonFormat.defaultFormats].
  final List<LessonFormat> lessonFormats;
  /// Id of the format used when a unit has no explicit `formatId` assigned.
  /// Always points to a real entry in [lessonFormats] after migration.
  final String defaultFormatId;
  final String? syllabusPath;
  final List<String> plannerQuestions;
  final List<String> selectedQuestions;
  final String bloomLevel;

  static const List<String> defaultPlannerQuestions = [
    'Include core conceptual theory and definitions',
    'Include step-by-step worked examples',
    'Include mathematical proofs or derivations',
    'Include interactive code or pseudo-code snippets',
    'Include quiz or exercises for self-testing',
    'Include summary slides for quick review',
  ];

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.systemPrompt,
    this.customInstructions,
    this.updatedAt,
    this.authorId,
    this.authorName,
    this.isGlobal = false,
    required this.modules,
    this.questionPapers = const [],
    required this.lessonFormats,
    required this.defaultFormatId,
    this.syllabusPath,
    this.plannerQuestions = defaultPlannerQuestions,
    this.selectedQuestions = const [],
    this.bloomLevel = 'Remembering / Understanding',
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    // ---- Format-list migration --------------------------------------------
    // Three cases to handle, in order of preference:
    //   1. Modern: `lessonFormats` array + `defaultFormatId`.
    //   2. Legacy: a single `lessonTemplate` slide list — wrap into one
    //      "Default" format so existing books keep working unchanged.
    //   3. Brand-new book with neither: use the starter pack.
    List<LessonFormat> formats;
    String defaultId;
    final formatsJson = json['lessonFormats'] as List?;
    if (formatsJson != null && formatsJson.isNotEmpty) {
      formats = formatsJson
          .map((f) => LessonFormat.fromJson(f is Map ? Map<String, dynamic>.from(f) : {}))
          .toList();
      final claimedDefault = _strOpt(json['defaultFormatId']);
      defaultId = (claimedDefault != null && formats.any((f) => f.id == claimedDefault))
          ? claimedDefault
          : formats.first.id;
    } else if (json['lessonTemplate'] is List) {
      final slides = (json['lessonTemplate'] as List)
          .map((t) => SlideTemplate.fromJson(t is Map ? Map<String, dynamic>.from(t) : {}))
          .toList();
      formats = [LessonFormat(id: 'default', name: 'Default', description: 'Migrated from previous single-template setup.', slides: slides)];
      defaultId = 'default';
    } else {
      formats = LessonFormat.defaultFormats;
      defaultId = formats.first.id;
    }

    final plannerQuestionsJson = json['plannerQuestions'] as List?;
    final plannerQuestions = plannerQuestionsJson != null
        ? plannerQuestionsJson.map((q) => _str(q)).toList()
        : defaultPlannerQuestions;

    final selectedQuestionsJson = json['selectedQuestions'] as List?;
    final selectedQuestions = selectedQuestionsJson != null
        ? selectedQuestionsJson.map((q) => _str(q)).toList()
        : [defaultPlannerQuestions[0], defaultPlannerQuestions[1]];

    return Book(
      id: _str(json['id']),
      title: _str(json['title']),
      description: _str(json['description']),
      icon: _str(json['icon'], 'Book'),
      systemPrompt: _strOpt(json['systemPrompt']),
      customInstructions: _strOpt(json['customInstructions']),
      updatedAt: json['updatedAt'] is num ? (json['updatedAt'] as num).toInt() : int.tryParse(_str(json['updatedAt'])),
      authorId: _strOpt(json['authorId']),
      authorName: _strOpt(json['authorName']),
      isGlobal: _bool(json['isGlobal'], false),
      modules: (json['modules'] as List?)?.map((m) => Module.fromJson(m is Map ? Map<String, dynamic>.from(m) : {})).toList() ?? [],
      questionPapers: (json['questionPapers'] as List?)?.map((q) => QuestionPaper.fromJson(q is Map ? Map<String, dynamic>.from(q) : {})).toList() ?? [],
      lessonFormats: formats,
      defaultFormatId: defaultId,
      syllabusPath: _strOpt(json['syllabusPath']),
      plannerQuestions: plannerQuestions,
      selectedQuestions: selectedQuestions,
      bloomLevel: _str(json['bloomLevel'], 'Remembering / Understanding'),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'icon': icon,
    if (systemPrompt != null) 'systemPrompt': systemPrompt,
    if (customInstructions != null) 'customInstructions': customInstructions,
    if (updatedAt != null) 'updatedAt': updatedAt,
    if (authorId != null) 'authorId': authorId,
    if (authorName != null) 'authorName': authorName,
    'isGlobal': isGlobal,
    'modules': modules.map((m) => m.toJson()).toList(),
    'questionPapers': questionPapers.map((q) => q.toJson()).toList(),
    'lessonFormats': lessonFormats.map((f) => f.toJson()).toList(),
    'defaultFormatId': defaultFormatId,
    if (syllabusPath != null) 'syllabusPath': syllabusPath,
    'plannerQuestions': plannerQuestions,
    'selectedQuestions': selectedQuestions,
    'bloomLevel': bloomLevel,
  };

  List<LessonFormat> formatsForSection(Section section) {
    if (section.lessonFormats != null && section.lessonFormats!.isNotEmpty) {
      return section.lessonFormats!;
    }
    return lessonFormats;
  }

  /// Returns the format the AI should use for [lesson] — its explicit
  /// [Lesson.formatId] when valid, otherwise the book's default. Never null.
  LessonFormat formatForLesson(Lesson lesson, Section section) {
    final wanted = lesson.formatId;
    final formats = formatsForSection(section);
    if (wanted != null) {
      for (final f in formats) {
        if (f.id == wanted) return f;
      }
    }
    for (final f in formats) {
      if (f.id == defaultFormatId) return f;
    }
    return formats.first;
  }

  Book copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    String? systemPrompt,
    String? customInstructions,
    int? updatedAt,
    String? authorId,
    String? authorName,
    bool? isGlobal,
    List<Module>? modules,
    List<QuestionPaper>? questionPapers,
    List<LessonFormat>? lessonFormats,
    String? defaultFormatId,
    String? syllabusPath,
    List<String>? plannerQuestions,
    List<String>? selectedQuestions,
    String? bloomLevel,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      systemPrompt: systemPrompt ?? this.systemPrompt,
      customInstructions: customInstructions ?? this.customInstructions,
      updatedAt: updatedAt ?? this.updatedAt,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      isGlobal: isGlobal ?? this.isGlobal,
      modules: modules ?? this.modules,
      questionPapers: questionPapers ?? this.questionPapers,
      lessonFormats: lessonFormats ?? this.lessonFormats,
      defaultFormatId: defaultFormatId ?? this.defaultFormatId,
      syllabusPath: syllabusPath ?? this.syllabusPath,
      plannerQuestions: plannerQuestions ?? this.plannerQuestions,
      selectedQuestions: selectedQuestions ?? this.selectedQuestions,
      bloomLevel: bloomLevel ?? this.bloomLevel,
    );
  }

  Book scopeBookIds(String newBookId) {
    final oldBookId = id;
    
    String updateId(String oldId) {
      if (oldId.startsWith('${newBookId}_')) return oldId;
      if (oldId.startsWith('${oldBookId}_')) {
        return oldId.replaceFirst('${oldBookId}_', '${newBookId}_');
      }
      return '${newBookId}_$oldId';
    }

    return copyWith(
      id: newBookId,
      modules: modules.map((m) {
        return m.copyWith(
          id: updateId(m.id),
          practiceQuestions: m.practiceQuestions.map((q) => q.copyWith(id: updateId(q.id))).toList(),
          sections: m.sections.map((s) {
            return s.copyWith(
              id: updateId(s.id),
              pyqQuestions: s.pyqQuestions.map((q) => q.copyWith(id: updateId(q.id))).toList(),
              units: s.units.map((u) {
                return u.copyWith(
                  id: updateId(u.id),
                  lessons: u.lessons.map((l) {
                    return l.copyWith(
                      id: updateId(l.id),
                      slides: l.slides.map((sl) => sl.copyWith(id: updateId(sl.id))).toList(),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }).toList(),
        );
      }).toList(),
      questionPapers: questionPapers.map((qp) {
        return qp.copyWith(
          id: updateId(qp.id),
          sections: qp.sections.map((qs) {
            return qs.copyWith(
              questions: qs.questions.map((q) => q.copyWith(id: updateId(q.id))).toList(),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

class QpQuestion {
  final String id;
  final String questionText;
  final String solutionText;

  QpQuestion({
    required this.id,
    required this.questionText,
    required this.solutionText,
  });

  factory QpQuestion.fromJson(Map<String, dynamic> json) {
    return QpQuestion(
      id: _str(json['id']),
      questionText: _str(json['questionText']),
      solutionText: _str(json['solutionText']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'questionText': questionText,
    'solutionText': solutionText,
  };

  QpQuestion copyWith({
    String? id,
    String? questionText,
    String? solutionText,
  }) {
    return QpQuestion(
      id: id ?? this.id,
      questionText: questionText ?? this.questionText,
      solutionText: solutionText ?? this.solutionText,
    );
  }
}

class QpSection {
  final String title;
  final List<QpQuestion> questions;

  QpSection({
    required this.title,
    required this.questions,
  });

  factory QpSection.fromJson(Map<String, dynamic> json) {
    return QpSection(
      title: _str(json['title'], 'Section'),
      questions: (json['questions'] as List?)?.map((q) => QpQuestion.fromJson(q is Map ? Map<String, dynamic>.from(q) : {})).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'questions': questions.map((q) => q.toJson()).toList(),
  };

  QpSection copyWith({
    String? title,
    List<QpQuestion>? questions,
  }) {
    return QpSection(
      title: title ?? this.title,
      questions: questions ?? this.questions,
    );
  }
}

class QuestionPaper {
  final String id;
  final String title;
  final List<QpSection> sections;

  QuestionPaper({
    required this.id, 
    required this.title, 
    required this.sections,
  });

  factory QuestionPaper.fromJson(Map<String, dynamic> json) {
    List<QpSection> parsedSections = [];
    if (json['sections'] != null) {
      parsedSections = (json['sections'] as List).map((s) => QpSection.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList();
    } else if (json['slides'] != null) {
      // Fallback parser for old Slide-based QPs
      List<QpQuestion> fallbackQs = (json['slides'] as List).map((s) {
        final sm = s is Map ? Map<String, dynamic>.from(s) : <String, dynamic>{};
        return QpQuestion(
          id: _str(sm['id']),
          questionText: '${_str(sm['title'])}\n\n${_str(sm['content'])}',
          solutionText: "Solution data is in old interactive format. Please regenerate.",
        );
      }).toList();
      parsedSections = [QpSection(title: "General Questions", questions: fallbackQs)];
    }

    return QuestionPaper(
      id: _str(json['id']),
      title: _str(json['title'], 'Past Paper'),
      sections: parsedSections,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'sections': sections.map((s) => s.toJson()).toList(),
  };

  QuestionPaper copyWith({
    String? id,
    String? title,
    List<QpSection>? sections,
  }) {
    return QuestionPaper(
      id: id ?? this.id,
      title: title ?? this.title,
      sections: sections ?? this.sections,
    );
  }
}

class QuickReviewItem {
  final String statement;
  final String relatedLessonTitle;

  QuickReviewItem({
    required this.statement,
    required this.relatedLessonTitle,
  });

  factory QuickReviewItem.fromJson(Map<String, dynamic> json) {
    return QuickReviewItem(
      statement: _str(json['statement']),
      relatedLessonTitle: _str(json['relatedLessonTitle'] ?? json['relatedLesson'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
    'statement': statement,
    'relatedLessonTitle': relatedLessonTitle,
  };
}

class Module {
  final String id;
  final String title;
  final String description;
  final List<Section> sections;
  final List<Slide> practiceQuestions;
  final List<QuickReviewItem>? quickReview;

  Module({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.sections,
    required this.practiceQuestions,
    this.quickReview,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: _str(json['id']),
      title: _str(json['title']),
      description: _str(json['description']),
      sections: (json['sections'] as List?)?.map((s) => Section.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList() ?? [],
      practiceQuestions: (json['practiceQuestions'] as List?)?.map((s) => Slide.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList() ?? [],
      quickReview: (json['quickReview'] as List?)?.map((r) => QuickReviewItem.fromJson(r is Map ? Map<String, dynamic>.from(r) : {})).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'sections': sections.map((s) => s.toJson()).toList(),
    'practiceQuestions': practiceQuestions.map((s) => s.toJson()).toList(),
    if (quickReview != null) 'quickReview': quickReview!.map((r) => r.toJson()).toList(),
  };

  Module copyWith({
    String? id,
    String? title,
    String? description,
    List<Section>? sections,
    List<Slide>? practiceQuestions,
    List<QuickReviewItem>? quickReview,
  }) {
    return Module(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      sections: sections ?? this.sections,
      practiceQuestions: practiceQuestions ?? this.practiceQuestions,
      quickReview: quickReview ?? this.quickReview,
    );
  }
}

class Section {
  final String id;
  final String title;
  final String description;
  final String color;
  final List<Unit> units;
  // New-flow fields: when a section is generated from a TOC-only skeleton,
  // the section itself owns the PDF chunk and page range, and `units` starts
  // empty until a lazy unit-manifest call fills it. Old books leave these
  // null and continue to use per-unit pdfPath.
  final int? startPage;
  final int? endPage;
  final String? pdfPath;
  final bool unitsGenerated;
  /// Set to true once the user has reviewed the AI's per-unit format
  /// suggestions (or accepted them as-is). Lessons stay gated behind a
  /// confirmation panel until this flips true.
  final bool unitFormatsConfirmed;
  /// Per-section planner instructions, captured on the "Plan units" panel.
  /// Pre-filled from the book's [Book.customInstructions] but editable so a
  /// section can be planned with a tweaked focus. Persisted so a manifest
  /// retry reuses the same guidance.
  final String? customInstructions;
  final List<Slide> pyqQuestions;
  final int? bookIndex;
  final List<String>? selectedQuestions;
  final List<LessonFormat>? lessonFormats;

  Section({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.units,
    this.startPage,
    this.endPage,
    this.pdfPath,
    this.unitsGenerated = false,
    this.unitFormatsConfirmed = false,
    this.customInstructions,
    this.pyqQuestions = const [],
    this.bookIndex,
    this.selectedQuestions,
    this.lessonFormats,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: _str(json['id']),
      title: _str(json['title']),
      description: _str(json['description']),
      color: _str(json['color'], 'duo-blue'),
      units: (json['units'] as List?)?.map((u) => Unit.fromJson(u is Map ? Map<String, dynamic>.from(u) : {})).toList() ?? [],
      startPage: json['startPage'] is num ? (json['startPage'] as num).toInt() : int.tryParse(_str(json['startPage'])),
      endPage: json['endPage'] is num ? (json['endPage'] as num).toInt() : int.tryParse(_str(json['endPage'])),
      pdfPath: _strOpt(json['pdfPath']),
      unitsGenerated: _bool(json['unitsGenerated'], false),
      unitFormatsConfirmed: _bool(json['unitFormatsConfirmed'], false),
      customInstructions: _strOpt(json['customInstructions']),
      pyqQuestions: (json['pyqQuestions'] as List?)?.map((s) => Slide.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList() ?? [],
      bookIndex: json['bookIndex'] is num ? (json['bookIndex'] as num).toInt() : int.tryParse(_str(json['bookIndex'])),
      selectedQuestions: (json['selectedQuestions'] as List?)?.map((q) => _str(q)).toList(),
      lessonFormats: (json['lessonFormats'] as List?)
          ?.map((f) => LessonFormat.fromJson(f is Map ? Map<String, dynamic>.from(f) : {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'color': color,
    'units': units.map((u) => u.toJson()).toList(),
    if (startPage != null) 'startPage': startPage,
    if (endPage != null) 'endPage': endPage,
    if (pdfPath != null) 'pdfPath': pdfPath,
    if (unitsGenerated) 'unitsGenerated': unitsGenerated,
    if (unitFormatsConfirmed) 'unitFormatsConfirmed': unitFormatsConfirmed,
    if (customInstructions != null) 'customInstructions': customInstructions,
    'pyqQuestions': pyqQuestions.map((s) => s.toJson()).toList(),
    if (bookIndex != null) 'bookIndex': bookIndex,
    if (selectedQuestions != null) 'selectedQuestions': selectedQuestions,
    if (lessonFormats != null) 'lessonFormats': lessonFormats!.map((f) => f.toJson()).toList(),
  };

  /// True for skeletons that carry their own page-range and PDF chunk and
  /// expect a lazy unit-manifest pass before lessons can be generated.
  bool get isLazySection => pdfPath != null || startPage != null;

  /// Whether the unit list still needs to be produced by the AI. Old-flow
  /// books always return false here because their units are baked in at
  /// skeleton time.
  bool get needsUnitManifest => isLazySection && !unitsGenerated;

  /// True when the units are present but the user hasn't signed off on
  /// the AI's per-unit format assignments yet.
  bool get needsFormatConfirmation =>
      isLazySection && unitsGenerated && units.isNotEmpty && !unitFormatsConfirmed;

  Section copyWith({
    String? id,
    String? title,
    String? description,
    String? color,
    List<Unit>? units,
    int? startPage,
    int? endPage,
    String? pdfPath,
    bool? unitsGenerated,
    bool? unitFormatsConfirmed,
    String? customInstructions,
    List<Slide>? pyqQuestions,
    int? bookIndex,
    List<String>? selectedQuestions,
    List<LessonFormat>? lessonFormats,
  }) {
    return Section(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      units: units ?? this.units,
      startPage: startPage ?? this.startPage,
      endPage: endPage ?? this.endPage,
      pdfPath: pdfPath ?? this.pdfPath,
      unitsGenerated: unitsGenerated ?? this.unitsGenerated,
      unitFormatsConfirmed: unitFormatsConfirmed ?? this.unitFormatsConfirmed,
      customInstructions: customInstructions ?? this.customInstructions,
      pyqQuestions: pyqQuestions ?? this.pyqQuestions,
      bookIndex: bookIndex ?? this.bookIndex,
      selectedQuestions: selectedQuestions ?? this.selectedQuestions,
      lessonFormats: lessonFormats ?? this.lessonFormats,
    );
  }
}

class Unit {
  final String id;
  final String title;
  final String description;
  final int? startPage;
  final int? endPage;
  final bool isGenerated;
  final String? pdfPath;
  final List<Lesson> lessons;
  final int? bookIndex;

  Unit({
    required this.id,
    required this.title,
    required this.description,
    this.startPage,
    this.endPage,
    required this.isGenerated,
    this.pdfPath,
    required this.lessons,
    this.bookIndex,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: _str(json['id']),
      title: _str(json['title']),
      description: _str(json['description']),
      startPage: json['startPage'] is num ? (json['startPage'] as num).toInt() : int.tryParse(_str(json['startPage'])),
      endPage: json['endPage'] is num ? (json['endPage'] as num).toInt() : int.tryParse(_str(json['endPage'])),
      isGenerated: _bool(json['isGenerated'], true),
      pdfPath: _strOpt(json['pdfPath']),
      lessons: (json['lessons'] as List?)?.map((l) => Lesson.fromJson(l is Map ? Map<String, dynamic>.from(l) : {})).toList() ?? [],
      bookIndex: json['bookIndex'] is num ? (json['bookIndex'] as num).toInt() : int.tryParse(_str(json['bookIndex'])),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    if (startPage != null) 'startPage': startPage,
    if (endPage != null) 'endPage': endPage,
    'isGenerated': isGenerated,
    if (pdfPath != null) 'pdfPath': pdfPath,
    'lessons': lessons.map((l) => l.toJson()).toList(),
    if (bookIndex != null) 'bookIndex': bookIndex,
  };

  Unit copyWith({
    String? id,
    String? title,
    String? description,
    int? startPage,
    int? endPage,
    bool? isGenerated,
    String? pdfPath,
    List<Lesson>? lessons,
    int? bookIndex,
  }) {
    return Unit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startPage: startPage ?? this.startPage,
      endPage: endPage ?? this.endPage,
      isGenerated: isGenerated ?? this.isGenerated,
      pdfPath: pdfPath ?? this.pdfPath,
      lessons: lessons ?? this.lessons,
      bookIndex: bookIndex ?? this.bookIndex,
    );
  }
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final String icon;
  final List<Slide> slides;
  /// Id of the [LessonFormat] this specific lesson follows. Different
  /// lessons in the same unit may pick different formats (e.g. a unit on
  /// "Newton\'s laws" can contain a theory lesson, a worked-example lesson
  /// and a proof lesson). The AI picks one per lesson during generation;
  /// null falls back to the book\'s default format.
  final String? formatId;
  /// Natural-language description of the diagram that best illustrates
  /// this lesson. The text AI emits it during lesson generation; the
  /// graphics AI later turns it into [canvasSvg]. Null only on lessons
  /// generated before canvas-art support existed.
  final String? canvasPrompt;
  /// The rendered diagram source. Newer art is a JavaScript `draw(ctx, W, H)`
  /// function executed inside a reusable HTML5 `<canvas>` host; legacy art is
  /// raw `<svg>` markup. The renderer ([CanvasArtView]) auto-detects which by
  /// looking for an `<svg` tag. Lives separately from [canvasPrompt] so the
  /// user can regenerate the art without losing the prompt.
  final String? canvasSvg;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.slides,
    this.formatId,
    this.canvasPrompt,
    this.canvasSvg,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    final lessonId = _str(json['id']);
    final rawSlides = (json['slides'] as List?)?.map((s) => Slide.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList() ?? [];
    
    final Set<String> seenIds = {};
    int slideIdx = 1;
    final slides = rawSlides.map((s) {
      var sId = s.id.trim();
      if (sId.isEmpty || sId == '%slide_id%' || sId == 'null' || seenIds.contains(sId)) {
        sId = 's${slideIdx++}';
        var candidate = '$lessonId-$sId';
        while (seenIds.contains(candidate)) {
          sId = 's${slideIdx++}';
          candidate = '$lessonId-$sId';
        }
        sId = candidate;
      }
      seenIds.add(sId);
      return s.copyWith(id: sId);
    }).toList();

    return Lesson(
      id: lessonId,
      title: _str(json['title']),
      description: _str(json['description']),
      icon: _str(json['icon'], 'BookOpen'),
      slides: slides,
      formatId: _strOpt(json['formatId']),
      canvasPrompt: _strOpt(json['canvasPrompt']),
      canvasSvg: _strOpt(json['canvasSvg']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'icon': icon,
    'slides': slides.map((s) => s.toJson()).toList(),
    if (formatId != null) 'formatId': formatId,
    if (canvasPrompt != null) 'canvasPrompt': canvasPrompt,
    if (canvasSvg != null) 'canvasSvg': canvasSvg,
  };

  Lesson copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    List<Slide>? slides,
    String? formatId,
    String? canvasPrompt,
    String? canvasSvg,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      slides: slides ?? this.slides,
      formatId: formatId ?? this.formatId,
      canvasPrompt: canvasPrompt ?? this.canvasPrompt,
      canvasSvg: canvasSvg ?? this.canvasSvg,
    );
  }
}

class InteractiveStep {
  final String? prompt;
  final String? stepText;
  final List<QuizOption>? options;

  InteractiveStep({this.prompt, this.stepText, this.options});

  factory InteractiveStep.fromJson(Map<String, dynamic> json) {
    return InteractiveStep(
      prompt: _strOpt(json['prompt']),
      stepText: _strOpt(json['stepText']),
      options: (json['options'] as List?)?.map((o) {
        if (o is String) {
          return QuizOption(
            id: o.trim().hashCode.toString(),
            text: o.trim(),
            isCorrect: false,
            explanation: '',
          );
        } else if (o is Map) {
          return QuizOption.fromJson(Map<String, dynamic>.from(o));
        } else {
          return QuizOption(id: 'opt', text: 'Option', isCorrect: false, explanation: '');
        }
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    if (prompt != null) 'prompt': prompt,
    if (stepText != null) 'stepText': stepText,
    if (options != null) 'options': options!.map((o) => o.toJson()).toList(),
  };

  InteractiveStep copyWith({String? prompt, String? stepText, List<QuizOption>? options}) =>
      InteractiveStep(
        prompt: prompt ?? this.prompt,
        stepText: stepText ?? this.stepText,
        options: options ?? this.options,
      );
}

class Slide {
  final String id;
  final String type;
  final String title;
  String content;
  final String? interactiveCanvasHtml;
  final List<QuizOption>? options;
  final List<InteractiveStep>? interactiveSteps;
  final List<String>? proofSteps;
  final String? blankAnswer;
  final List<String>? blankDistractors;
  final double? numericAnswer;
  final double? numericTolerance;
  /// Optional per-slide diagram (only used today by proof/step_by_step
  /// slides). When the slide\'s content actually demands a visual the AI
  /// emits a [canvasPrompt]; otherwise this stays null and no diagram is
  /// shown. Mirror of [Lesson.canvasPrompt]/[Lesson.canvasSvg]. Like the
  /// lesson field, [canvasSvg] holds either a JS `draw(ctx, W, H)` function
  /// (new) or raw `<svg>` markup (legacy).
  final String? canvasPrompt;
  final String? canvasSvg;

  /// Provenance of this question, used for PYQ/practice questions:
  /// `'extracted'` (lifted from an uploaded paper) vs `'generated'`
  /// (produced by the AI). Null on lessons slides and legacy data.
  final String? source;

  Slide({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    this.interactiveCanvasHtml,
    this.options,
    this.interactiveSteps,
    this.proofSteps,
    this.blankAnswer,
    this.blankDistractors,
    this.numericAnswer,
    this.numericTolerance,
    this.canvasPrompt,
    this.canvasSvg,
    this.source,
  });

  factory Slide.fromJson(Map<String, dynamic> json) {
    final type = _str(json['type'], 'theory');
    List<QuizOption>? parsedOptions;
    
    if (json['options'] != null) {
      parsedOptions = (json['options'] as List).map((o) {
        if (o is String) {
          return QuizOption(
            id: o.trim().hashCode.toString(),
            text: o.trim(),
            isCorrect: false,
            explanation: '',
          );
        } else if (o is Map) {
          return QuizOption.fromJson(Map<String, dynamic>.from(o));
        } else {
          return QuizOption(id: 'opt', text: 'Option', isCorrect: false, explanation: '');
        }
      }).toList();
      if (type == 'quiz' && parsedOptions.isNotEmpty) {
        int correctCount = parsedOptions.where((o) => o.isCorrect).length;
        if (correctCount != 1) {
          bool firstTrue = false;
          parsedOptions = parsedOptions.map((o) {
            if (correctCount == 0 && !firstTrue) {
              firstTrue = true;
              return QuizOption(id: o.id, text: o.text, isCorrect: true, explanation: o.explanation);
            }
            if (o.isCorrect) {
              if (!firstTrue) {
                firstTrue = true;
                return o;
              }
              return QuizOption(id: o.id, text: o.text, isCorrect: false, explanation: o.explanation);
            }
            return o;
          }).toList();
        }
      }
    }

    return Slide(
      id: _str(json['id']),
      type: type,
      title: _str(json['title']),
      content: _str(json['content']),
      interactiveCanvasHtml: _strOpt(json['interactiveCanvasHtml']),
      options: parsedOptions,
      interactiveSteps: (json['interactiveSteps'] as List?)?.map((s) => InteractiveStep.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList(),
      proofSteps: (json['proofSteps'] as List?)?.map((s) => _str(s)).toList(),
      blankAnswer: _strOpt(json['blankAnswer']),
      blankDistractors: (json['blankDistractors'] as List?)?.map((s) => _str(s)).toList(),
      numericAnswer: _dblOpt(json['numericAnswer']),
      numericTolerance: _dblOpt(json['numericTolerance']) ?? 0.01,
      canvasPrompt: _strOpt(json['canvasPrompt']),
      canvasSvg: _strOpt(json['canvasSvg']),
      source: _strOpt(json['source']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'title': title,
    'content': content,
    if (interactiveCanvasHtml != null) 'interactiveCanvasHtml': interactiveCanvasHtml,
    if (options != null) 'options': options!.map((o) => o.toJson()).toList(),
    if (interactiveSteps != null) 'interactiveSteps': interactiveSteps!.map((s) => s.toJson()).toList(),
    if (proofSteps != null) 'proofSteps': proofSteps,
    if (blankAnswer != null) 'blankAnswer': blankAnswer,
    if (blankDistractors != null) 'blankDistractors': blankDistractors,
    if (numericAnswer != null) 'numericAnswer': numericAnswer,
    if (numericTolerance != null) 'numericTolerance': numericTolerance,
    if (canvasPrompt != null) 'canvasPrompt': canvasPrompt,
    if (canvasSvg != null) 'canvasSvg': canvasSvg,
    if (source != null) 'source': source,
  };

  Slide copyWith({
    String? id,
    String? type,
    String? title,
    String? content,
    String? interactiveCanvasHtml,
    List<QuizOption>? options,
    List<InteractiveStep>? interactiveSteps,
    List<String>? proofSteps,
    String? blankAnswer,
    List<String>? blankDistractors,
    double? numericAnswer,
    double? numericTolerance,
    String? canvasPrompt,
    String? canvasSvg,
    String? source,
  }) {
    return Slide(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      interactiveCanvasHtml: interactiveCanvasHtml ?? this.interactiveCanvasHtml,
      options: options ?? this.options,
      interactiveSteps: interactiveSteps ?? this.interactiveSteps,
      proofSteps: proofSteps ?? this.proofSteps,
      blankAnswer: blankAnswer ?? this.blankAnswer,
      blankDistractors: blankDistractors ?? this.blankDistractors,
      numericAnswer: numericAnswer ?? this.numericAnswer,
      numericTolerance: numericTolerance ?? this.numericTolerance,
      canvasPrompt: canvasPrompt ?? this.canvasPrompt,
      canvasSvg: canvasSvg ?? this.canvasSvg,
      source: source ?? this.source,
    );
  }
}

class QuizOption {
  final String id;
  final String text;
  final bool isCorrect;
  final String explanation;

  QuizOption({required this.id, required this.text, required this.isCorrect, required this.explanation});

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    final rawId = _strOpt(json['id']);
    
    String optionText = '';
    if (json['text'] != null) {
      optionText = _str(json['text']);
    } else if (json['option'] != null) {
      optionText = _str(json['option']);
    } else if (json['answer'] != null) {
      optionText = _str(json['answer']);
    } else if (json['content'] != null) {
      optionText = _str(json['content']);
    } else {
      optionText = 'Option';
    }

    final parsedText = optionText.trim().isNotEmpty ? optionText.trim() : 'Option';
    final effectiveId = (rawId != null && rawId.isNotEmpty) ? rawId.trim() : parsedText.hashCode.toString();

    return QuizOption(
      id: effectiveId,
      text: parsedText,
      isCorrect: _bool(json['isCorrect']),
      explanation: _str(json['explanation']).trim(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'isCorrect': isCorrect,
    'explanation': explanation,
  };

  QuizOption copyWith({String? id, String? text, bool? isCorrect, String? explanation}) =>
      QuizOption(
        id: id ?? this.id,
        text: text ?? this.text,
        isCorrect: isCorrect ?? this.isCorrect,
        explanation: explanation ?? this.explanation,
      );
}

class CourseFolder {
  final String id;
  final String name;
  final List<String> bookIds;

  CourseFolder({
    required this.id,
    required this.name,
    required this.bookIds,
  });

  factory CourseFolder.fromJson(Map<String, dynamic> json) {
    return CourseFolder(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      bookIds: List<String>.from(json['bookIds'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'bookIds': bookIds,
  };

  CourseFolder copyWith({
    String? id,
    String? name,
    List<String>? bookIds,
  }) {
    return CourseFolder(
      id: id ?? this.id,
      name: name ?? this.name,
      bookIds: bookIds ?? this.bookIds,
    );
  }
}