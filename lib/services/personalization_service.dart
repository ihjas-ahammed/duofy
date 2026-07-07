import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_models.dart';
import 'metacognition_service.dart';

/// Compiles the per-learner system-prompt block injected into every content
/// generation call. Merges four signals:
///  1. structured learner preferences (chips in Settings → Personalization),
///  2. the legacy essay-derived writing-style profile (when present),
///  3. the course's current Bloom level, and
///  4. the learner's own post-lesson reflections for the module being
///     generated (too easy → harder, confusing → easier).
/// Replaces AiService.compileMetacognitiveSystemPrompt.
class PersonalizationService {
  PersonalizationService._();

  static const String prefExamplesFirst = 'learner_examples_first'; // bool
  static const String prefLanguageLevel = 'learner_language_level'; // simple | standard | technical
  static const String prefTone = 'learner_tone'; // encouraging | neutral | formal

  static Future<String> compileSystemPrompt({
    required String baseSystemPrompt,
    required String bloomLevel,
    Book? book,
    String? unitId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final writingStyleProfileJson = prefs.getString('user_writing_style_profile');
    final examplesFirst = prefs.getBool(prefExamplesFirst);
    final languageLevel = prefs.getString(prefLanguageLevel);
    final tone = prefs.getString(prefTone);

    var difficulty = 'keep';
    if (book != null && unitId != null) {
      final moduleId = _moduleIdOfUnit(book, unitId);
      if (moduleId != null) {
        difficulty = await MetacognitionService.difficultySignal(book.id, moduleId);
      }
    }

    final buffer = StringBuffer();

    buffer.writeln('# Core Directives');
    buffer.writeln('## Pedagogical Role');
    buffer.writeln('Act as an expert metacognitive tutor utilizing the "best possible version" paradigm.');
    buffer.writeln('You are a professional ghostwriter and editor who adopts the learner\'s unique voice but polishes it to professional publication standards.');
    buffer.writeln('The base instructional persona is: $baseSystemPrompt');

    buffer.writeln('\n## Cognitive State Constraint');
    String bloomDirective;
    switch (bloomLevel) {
      case 'Applying / Analyzing':
        bloomDirective =
            'Minimize basic definitions. Present material through case studies. Require the user to categorize information. Highlight relationships between variables within the text.';
        break;
      case 'Evaluating / Creating':
        bloomDirective =
            'Adopt a Socratic questioning tone. Present contradictory evidence from the text for review. Prompt the user to synthesize new hypotheses based on the chapter\'s data.';
        break;
      case 'Remembering / Understanding':
      default:
        bloomDirective =
            'Prioritize foundational definitions. Utilize highly descriptive analogies. Break complex concepts into granular, step-by-step sequential logic. Provide immediate, simple examples.';
    }
    buffer.writeln('Current Bloom\'s Taxonomy level: $bloomLevel');
    buffer.writeln('Pedagogical Directive: $bloomDirective');

    if (difficulty == 'harder') {
      buffer.writeln(
          'Learner Feedback Adjustment: the learner reported recent lessons in this module as TOO EASY. Increase challenge — fewer scaffolded hints, more multi-step and transfer questions, tighter theory.');
    } else if (difficulty == 'easier') {
      buffer.writeln(
          'Learner Feedback Adjustment: the learner reported recent lessons in this module as CONFUSING. Reduce cognitive load — smaller steps, one idea at a time, more worked examples before any question, simpler phrasing (never less accurate).');
    }

    if (examplesFirst != null || languageLevel != null || tone != null) {
      buffer.writeln('\n## Learner Preferences');
      if (examplesFirst != null) {
        buffer.writeln(examplesFirst
            ? '- Teach EXAMPLES-FIRST: open with a concrete example or problem, then generalize to the definition/theory.'
            : '- Teach THEORY-FIRST: state the definition/principle cleanly, then reinforce with examples.');
      }
      switch (languageLevel) {
        case 'simple':
          buffer.writeln('- Language: plain and simple. Short sentences, everyday vocabulary; introduce each technical term explicitly before using it.');
          break;
        case 'technical':
          buffer.writeln('- Language: technical and rigorous. Use precise domain terminology and formal register throughout.');
          break;
        case 'standard':
          buffer.writeln('- Language: standard textbook register.');
          break;
      }
      switch (tone) {
        case 'encouraging':
          buffer.writeln('- Tone: warm and encouraging (without being chatty or narrative).');
          break;
        case 'formal':
          buffer.writeln('- Tone: strictly formal and academic.');
          break;
        case 'neutral':
          buffer.writeln('- Tone: neutral and matter-of-fact.');
          break;
      }
    }

    if (writingStyleProfileJson != null && writingStyleProfileJson.trim().isNotEmpty) {
      buffer.writeln('\n## Stylometric Blueprint');
      buffer.writeln('Strictly adapt to the user\'s writing style mapped in the following profile, but enhanced to its best possible academic version:');
      buffer.writeln(writingStyleProfileJson);
    }

    buffer.writeln('\n## Formatting Rules (Immutable Constraints)');
    buffer.writeln('- Mathematical Invariance: NEVER alter, rewrite, or modify any text contained within \$ or \$\$ delimiters, or LaTeX environments such as \\begin{equation}.');
    buffer.writeln('- Structural Fidelity: Maintain the exact Markdown heading hierarchy (H1, H2, H3) of the source text. Do not remove or flatten sections.');
    buffer.writeln('- Data Preservation: Do not summarize or alter data points within Markdown tables. Rewrite surrounding prose only.');

    return buffer.toString();
  }

  static String? _moduleIdOfUnit(Book book, String unitId) {
    for (final m in book.modules) {
      for (final s in m.sections) {
        if (s.units.any((u) => u.id == unitId)) return m.id;
      }
    }
    return null;
  }
}
