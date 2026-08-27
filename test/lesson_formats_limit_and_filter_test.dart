import 'package:flutter_test/flutter_test.dart';
import 'package:flow/models/app_models.dart';

void main() {
  group('Lesson Formats 10-Limit and Programming Filtering', () {
    test('LessonFormat.defaultFormats has at most 10 formats', () {
      final defaults = LessonFormat.defaultFormats;
      expect(defaults.length, lessThanOrEqualTo(10));
      expect(defaults.isNotEmpty, isTrue);

      // Verify none of the default formats have programming slides
      for (final f in defaults) {
        expect(Book.hasProgrammingSlidesOrName(f), isFalse,
            reason: 'Default format ${f.name} should not contain programming slides');
      }
    });

    test('LessonFormat.defaultProgrammingFormats has at most 10 formats', () {
      final progDefaults = LessonFormat.defaultProgrammingFormats('Python 101', 'Intro to Python');
      expect(progDefaults.length, lessThanOrEqualTo(10));
      expect(progDefaults.isNotEmpty, isTrue);
    });

    test('Book.isProgrammingCourse correctly discriminates programming vs non-programming subjects', () {
      // Non-programming courses
      final nonProgCourses = [
        'Discrete Mathematics',
        'Organic Chemistry II',
        'Modern World History',
        'Linear Algebra and Matrix Theory',
        'Calculus & Real Analysis',
        'Principles of Macroeconomics',
        'Classical Mechanics and Quantum Physics',
        'Cell and Molecular Biology',
        'Philosophy of Mind',
        'English Literature: 19th Century Poetry',
      ];

      for (final title in nonProgCourses) {
        expect(Book.isProgrammingCourse(title), isFalse,
            reason: '$title should NOT be classified as a programming course');
      }

      // Explicit non-programming directive
      expect(
        Book.isProgrammingCourse('Advanced Algorithms [Non-Programming Subject]'),
        isFalse,
      );

      // Programming courses
      final progCourses = [
        'Introduction to Python Programming',
        'JavaScript and Web Development',
        'Programming in C++',
        'Mastering Dart and Flutter',
        'SQL Database Management',
        'HTML & CSS Design Fundamentals',
        'Systems Programming with Rust',
        'Building Web APIs with Go',
        'Modern Java Applications',
      ];

      for (final title in progCourses) {
        expect(Book.isProgrammingCourse(title), isTrue,
            reason: '$title should BE classified as a programming course');
      }

      // Explicit programming directive
      expect(
        Book.isProgrammingCourse('Linear Algebra [Programming Course: Python]'),
        isTrue,
      );
    });

    test('Book.hasProgrammingSlidesOrName detects programming slides and formats', () {
      final progFormat1 = LessonFormat(
        id: 'code-sandbox',
        name: 'Coding Sandbox',
        description: 'Interactive coding format',
        slides: [
          SlideTemplate(type: 'theory', condition: 'Always', description: 'Intro'),
          SlideTemplate(type: 'try_yourself', condition: 'Always', description: 'Run code'),
        ],
      );
      expect(Book.hasProgrammingSlidesOrName(progFormat1), isTrue);

      final progFormat2 = LessonFormat(
        id: 'custom-format-1',
        name: 'Program Fill-in',
        description: 'Complete the code blank',
        slides: [
          SlideTemplate(type: 'program', condition: 'Always', description: 'Fill blank'),
        ],
      );
      expect(Book.hasProgrammingSlidesOrName(progFormat2), isTrue);

      final nonProgFormat = LessonFormat(
        id: 'worked-example',
        name: 'Worked Example',
        description: 'Step-by-step math problem',
        slides: [
          SlideTemplate(type: 'theory', condition: 'Always', description: 'Problem statement'),
          SlideTemplate(type: 'step_by_step', condition: 'Always', description: 'Steps'),
          SlideTemplate(type: 'numerical', condition: 'Always', description: 'Calculation'),
        ],
      );
      expect(Book.hasProgrammingSlidesOrName(nonProgFormat), isFalse);
    });

    test('Book.formatsForSection enforces max 10 formats and filters coding slides for non-coding courses', () {
      final nonProgBook = Book(
        id: 'math-book-1',
        title: 'Real Analysis',
        description: 'Rigorous mathematics and proofs',
        icon: 'book',
        modules: [],
        lessonFormats: [
          ...LessonFormat.defaultFormats,
          ...LessonFormat.defaultProgrammingFormats('Math', 'Math'),
        ],
        defaultFormatId: 'default',
      );

      final section = Section(
        id: 'sec-1',
        title: 'Limits of Sequences',
        description: 'Epsilon-N proofs and monotonic sequences',
        color: 'blue',
        units: [],
      );

      final formats = nonProgBook.formatsForSection(section);
      expect(formats.length, lessThanOrEqualTo(10));
      for (final f in formats) {
        expect(Book.hasProgrammingSlidesOrName(f), isFalse,
            reason: 'Section in non-programming course must not have programming formats');
      }
    });

    test('Book.formatsForSection retains programming formats for coding courses and caps at 10', () {
      final progBook = Book(
        id: 'python-book-1',
        title: 'Python for Data Science',
        description: 'Learn Python programming syntax and packages',
        icon: 'code',
        modules: [],
        lessonFormats: [
          ...LessonFormat.defaultProgrammingFormats('Python', 'Data Science'),
          ...LessonFormat.defaultFormats,
        ],
        defaultFormatId: 'coding-theory',
      );

      final section = Section(
        id: 'sec-1',
        title: 'Lists and Dictionaries',
        description: 'Working with Python collection types and loops',
        color: 'green',
        units: [],
      );

      final formats = progBook.formatsForSection(section);
      expect(formats.length, lessThanOrEqualTo(10));
      expect(formats.any((f) => Book.hasProgrammingSlidesOrName(f)), isTrue);
    });
  });
}
