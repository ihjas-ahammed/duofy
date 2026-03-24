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

class Book {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String? systemPrompt;
  final int? updatedAt;
  final String? authorId;
  final String? authorName;
  final bool isGlobal;
  final List<Module> modules;
  final List<QuestionPaper> questionPapers;

  Book({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.icon, 
    this.systemPrompt,
    this.updatedAt,
    this.authorId,
    this.authorName,
    this.isGlobal = false,
    required this.modules,
    this.questionPapers = const [],
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: _str(json['id']),
      title: _str(json['title']),
      description: _str(json['description']),
      icon: _str(json['icon'], 'Book'),
      systemPrompt: _strOpt(json['systemPrompt']),
      updatedAt: json['updatedAt'] is num ? (json['updatedAt'] as num).toInt() : int.tryParse(_str(json['updatedAt'])),
      authorId: _strOpt(json['authorId']),
      authorName: _strOpt(json['authorName']),
      isGlobal: _bool(json['isGlobal'], false),
      modules: (json['modules'] as List?)?.map((m) => Module.fromJson(m is Map ? Map<String, dynamic>.from(m) : {})).toList() ?? [],
      questionPapers: (json['questionPapers'] as List?)?.map((q) => QuestionPaper.fromJson(q is Map ? Map<String, dynamic>.from(q) : {})).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'icon': icon,
    if (systemPrompt != null) 'systemPrompt': systemPrompt,
    if (updatedAt != null) 'updatedAt': updatedAt,
    if (authorId != null) 'authorId': authorId,
    if (authorName != null) 'authorName': authorName,
    'isGlobal': isGlobal,
    'modules': modules.map((m) => m.toJson()).toList(),
    'questionPapers': questionPapers.map((q) => q.toJson()).toList(),
  };

  Book copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    String? systemPrompt,
    int? updatedAt,
    String? authorId,
    String? authorName,
    bool? isGlobal,
    List<Module>? modules,
    List<QuestionPaper>? questionPapers,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      systemPrompt: systemPrompt ?? this.systemPrompt,
      updatedAt: updatedAt ?? this.updatedAt,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      isGlobal: isGlobal ?? this.isGlobal,
      modules: modules ?? this.modules,
      questionPapers: questionPapers ?? this.questionPapers,
    );
  }
}

class QuestionPaper {
  final String id;
  final String title;
  final List<Slide> slides;

  QuestionPaper({
    required this.id, 
    required this.title, 
    required this.slides,
  });

  factory QuestionPaper.fromJson(Map<String, dynamic> json) {
    return QuestionPaper(
      id: _str(json['id']),
      title: _str(json['title'], 'Past Paper'),
      slides: (json['slides'] as List?)?.map((s) => Slide.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slides': slides.map((s) => s.toJson()).toList(),
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
      id: _str(json['id']),
      title: _str(json['title']),
      description: _str(json['description']),
      sections: (json['sections'] as List?)?.map((s) => Section.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList() ?? [],
      practiceQuestions: (json['practiceQuestions'] as List?)?.map((s) => Slide.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList() ?? [],
      examQuestions: (json['examQuestions'] as List?)?.map((s) => Slide.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList() ?? [],
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
      id: _str(json['id']),
      title: _str(json['title']),
      description: _str(json['description']),
      color: _str(json['color'], 'duo-blue'),
      units: (json['units'] as List?)?.map((u) => Unit.fromJson(u is Map ? Map<String, dynamic>.from(u) : {})).toList() ?? [],
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
      id: _str(json['id']),
      title: _str(json['title']),
      description: _str(json['description']),
      startPage: json['startPage'] is num ? (json['startPage'] as num).toInt() : int.tryParse(_str(json['startPage'])),
      endPage: json['endPage'] is num ? (json['endPage'] as num).toInt() : int.tryParse(_str(json['endPage'])),
      isGenerated: _bool(json['isGenerated'], true),
      pdfPath: _strOpt(json['pdfPath']),
      lessons: (json['lessons'] as List?)?.map((l) => Lesson.fromJson(l is Map ? Map<String, dynamic>.from(l) : {})).toList() ?? [],
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
      id: _str(json['id']),
      title: _str(json['title']),
      description: _str(json['description']),
      icon: _str(json['icon'], 'BookOpen'),
      slides: (json['slides'] as List?)?.map((s) => Slide.fromJson(s is Map ? Map<String, dynamic>.from(s) : {})).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'icon': icon,
    'slides': slides.map((s) => s.toJson()).toList(),
  };

  Lesson copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    List<Slide>? slides,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      slides: slides ?? this.slides,
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
      options: (json['options'] as List?)?.map((o) => QuizOption.fromJson(o is Map ? Map<String, dynamic>.from(o) : {})).toList(),
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
  final String type; 
  final String title;
  final String content;
  final String? interactiveCanvasHtml;
  final List<QuizOption>? options;
  final List<InteractiveStep>? interactiveSteps;
  final List<String>? proofSteps;
  final String? blankAnswer;
  final List<String>? blankDistractors;
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
    this.blankDistractors,
    this.numericAnswer,
    this.numericTolerance,
  });

  factory Slide.fromJson(Map<String, dynamic> json) {
    final type = _str(json['type'], 'theory');
    List<QuizOption>? parsedOptions;
    
    if (json['options'] != null) {
      parsedOptions = (json['options'] as List).map((o) => QuizOption.fromJson(o is Map ? Map<String, dynamic>.from(o) : {})).toList();
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
    final parsedText = _str(json['text'], 'Option');
    final effectiveId = (rawId != null && rawId.isNotEmpty) ? rawId.trim() : parsedText.trim().hashCode.toString();

    return QuizOption(
      id: effectiveId,
      text: parsedText.trim(),
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
}