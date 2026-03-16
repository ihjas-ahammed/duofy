class Book {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String? systemPrompt;
  final List<Module> modules;

  Book({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.icon, 
    this.systemPrompt,
    required this.modules
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? 'Book',
      systemPrompt: json['systemPrompt'],
      modules: (json['modules'] as List?)?.map((m) => Module.fromJson(Map<String, dynamic>.from(m))).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'icon': icon,
    if (systemPrompt != null) 'systemPrompt': systemPrompt,
    'modules': modules.map((m) => m.toJson()).toList(),
  };

  Book copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    String? systemPrompt,
    List<Module>? modules,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      systemPrompt: systemPrompt ?? this.systemPrompt,
      modules: modules ?? this.modules,
    );
  }
}

class Module {
  final String id;
  final String title;
  final String description;
  final List<Section> sections;
  final List<Slide> practiceQuestions;
  final List<Slide> examQuestions;

  Module({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.sections,
    required this.practiceQuestions,
    required this.examQuestions,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      sections: (json['sections'] as List?)?.map((s) => Section.fromJson(Map<String, dynamic>.from(s))).toList() ?? [],
      practiceQuestions: (json['practiceQuestions'] as List?)?.map((s) => Slide.fromJson(Map<String, dynamic>.from(s))).toList() ?? [],
      examQuestions: (json['examQuestions'] as List?)?.map((s) => Slide.fromJson(Map<String, dynamic>.from(s))).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'sections': sections.map((s) => s.toJson()).toList(),
    'practiceQuestions': practiceQuestions.map((s) => s.toJson()).toList(),
    'examQuestions': examQuestions.map((s) => s.toJson()).toList(),
  };

  Module copyWith({
    String? id,
    String? title,
    String? description,
    List<Section>? sections,
    List<Slide>? practiceQuestions,
    List<Slide>? examQuestions,
  }) {
    return Module(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      sections: sections ?? this.sections,
      practiceQuestions: practiceQuestions ?? this.practiceQuestions,
      examQuestions: examQuestions ?? this.examQuestions,
    );
  }
}

class Section {
  final String id;
  final String title;
  final String description;
  final String color;
  final List<Unit> units;

  Section({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.color, 
    required this.units
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      color: json['color'] ?? 'duo-blue',
      units: (json['units'] as List?)?.map((u) => Unit.fromJson(Map<String, dynamic>.from(u))).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'color': color,
    'units': units.map((u) => u.toJson()).toList(),
  };

  Section copyWith({
    String? id,
    String? title,
    String? description,
    String? color,
    List<Unit>? units,
  }) {
    return Section(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      units: units ?? this.units,
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

  Unit({
    required this.id, 
    required this.title, 
    required this.description, 
    this.startPage,
    this.endPage,
    required this.isGenerated,
    this.pdfPath,
    required this.lessons
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startPage: json['startPage'],
      endPage: json['endPage'],
      isGenerated: json['isGenerated'] ?? true, // Default true to support legacy mocks easily
      pdfPath: json['pdfPath'],
      lessons: (json['lessons'] as List?)?.map((l) => Lesson.fromJson(Map<String, dynamic>.from(l))).toList() ?? [],
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
    );
  }
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final String icon;
  final List<Slide> slides;

  Lesson({required this.id, required this.title, required this.description, required this.icon, required this.slides});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? 'BookOpen',
      slides: (json['slides'] as List?)?.map((s) => Slide.fromJson(Map<String, dynamic>.from(s))).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'icon': icon,
    'slides': slides.map((s) => s.toJson()).toList(),
  };
}

class InteractiveStep {
  final String? prompt;
  final String? stepText;
  final List<QuizOption>? options;

  InteractiveStep({this.prompt, this.stepText, this.options});

  factory InteractiveStep.fromJson(Map<String, dynamic> json) {
    return InteractiveStep(
      prompt: json['prompt'],
      stepText: json['stepText'],
      options: (json['options'] as List?)?.map((o) => QuizOption.fromJson(Map<String, dynamic>.from(o))).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    if (prompt != null) 'prompt': prompt,
    if (stepText != null) 'stepText': stepText,
    if (options != null) 'options': options!.map((o) => o.toJson()).toList(),
  };
}

class Slide {
  final String id;
  final String type; // theory, quiz, fill_in_blank, numerical, interactive_canvas, proof, step_by_step
  final String title;
  final String content;
  final String? interactiveCanvasHtml;
  final List<QuizOption>? options;
  final List<InteractiveStep>? interactiveSteps;
  final List<String>? proofSteps;
  final String? blankAnswer;
  final double? numericAnswer;
  final double? numericTolerance;

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
    this.numericAnswer,
    this.numericTolerance,
  });

  factory Slide.fromJson(Map<String, dynamic> json) {
    return Slide(
      id: json['id'] ?? '',
      type: json['type'] ?? 'theory',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      interactiveCanvasHtml: json['interactiveCanvasHtml'],
      options: (json['options'] as List?)?.map((o) => QuizOption.fromJson(Map<String, dynamic>.from(o))).toList(),
      interactiveSteps: (json['interactiveSteps'] as List?)?.map((s) => InteractiveStep.fromJson(Map<String, dynamic>.from(s))).toList(),
      proofSteps: (json['proofSteps'] as List?)?.map((s) => s.toString()).toList(),
      blankAnswer: json['blankAnswer'],
      numericAnswer: json['numericAnswer']?.toDouble(),
      numericTolerance: json['numericTolerance']?.toDouble() ?? 0.01,
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
    if (numericAnswer != null) 'numericAnswer': numericAnswer,
    if (numericTolerance != null) 'numericTolerance': numericTolerance,
  };
}

class QuizOption {
  final String id;
  final String text;
  final bool isCorrect;
  final String explanation;

  QuizOption({required this.id, required this.text, required this.isCorrect, required this.explanation});

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      isCorrect: json['isCorrect'] ?? false,
      explanation: json['explanation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'isCorrect': isCorrect,
    'explanation': explanation,
  };
}