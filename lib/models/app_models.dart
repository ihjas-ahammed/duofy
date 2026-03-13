class Book {
  final String id;
  final String title;
  final String description;
  final String icon;
  final List<Module> modules;

  Book({required this.id, required this.title, required this.description, required this.icon, required this.modules});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? 'Book',
      modules: (json['modules'] as List?)?.map((m) => Module.fromJson(Map<String, dynamic>.from(m))).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'icon': icon,
    'modules': modules.map((m) => m.toJson()).toList(),
  };
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
}

class Section {
  final String id;
  final String title;
  final String description;
  final String color;
  final List<Unit> units;

  Section({required this.id, required this.title, required this.description, required this.color, required this.units});

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
}

class Unit {
  final String id;
  final String title;
  final String description;
  final List<Lesson> lessons;

  Unit({required this.id, required this.title, required this.description, required this.lessons});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      lessons: (json['lessons'] as List?)?.map((l) => Lesson.fromJson(Map<String, dynamic>.from(l))).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'lessons': lessons.map((l) => l.toJson()).toList(),
  };
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

class Slide {
  final String id;
  final String type; // theory, quiz, fill_in_blank, numerical, interactive_canvas
  final String title;
  final String content;
  final String? interactiveCanvasHtml;
  final List<QuizOption>? options;
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