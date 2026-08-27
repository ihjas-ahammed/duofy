import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/database_service.dart';
import '../widgets/duo_button.dart';
import '../widgets/responsive_center.dart';

/// Lets the user manage the list of named [LessonFormat]s a book ships with
/// (e.g. "Theory", "Worked Example", "Proof Walkthrough"). Each format is a
/// separate slide-template pipeline. There is no "default" format — the AI
/// picks the format that fits each lesson's concept during generation.
class CourseSettingsScreen extends StatefulWidget {
  final Book book;
  final Section? section;
  final int? modIdx;
  final int? secIdx;

  const CourseSettingsScreen({
    super.key,
    required this.book,
    this.section,
    this.modIdx,
    this.secIdx,
  });

  @override
  State<CourseSettingsScreen> createState() => _CourseSettingsScreenState();
}

class _CourseSettingsScreenState extends State<CourseSettingsScreen> {
  late List<LessonFormat> _formats;
  late String _defaultFormatId;
  late List<String> _plannerQuestions;

  @override
  void initState() {
    super.initState();
    final formatsSource =
        (widget.section?.lessonFormats != null &&
            widget.section!.lessonFormats!.isNotEmpty)
        ? widget.section!.lessonFormats!
        : widget.book.lessonFormats;
    _formats = List.of(formatsSource);
    _defaultFormatId = widget.book.defaultFormatId;
    if (_formats.isEmpty) {
      _formats = List.of(LessonFormat.defaultFormats);
      _defaultFormatId = _formats.first.id;
    }
    _plannerQuestions = List.of(widget.book.plannerQuestions);
  }

  String _genFormatId() {
    final used = _formats.map((f) => f.id).toSet();
    int n = _formats.length + 1;
    while (used.contains('format-$n')) {
      n++;
    }
    return 'format-$n';
  }

  void _addFormat() {
    if (_formats.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum limit of 10 lesson formats reached.')),
      );
      return;
    }
    final id = _genFormatId();
    final newFormat = LessonFormat(
      id: id,
      name: 'New Format',
      description: 'Describe when the AI should pick this format for a unit.',
      slides: SlideTemplate.defaultTemplate,
    );
    setState(() => _formats.add(newFormat));
    _openEditor(_formats.length - 1);
  }

  Future<void> _openEditor(int index) async {
    final edited = await Navigator.of(context).push<LessonFormat>(
      MaterialPageRoute(
        builder: (_) => FormatEditorScreen(format: _formats[index]),
      ),
    );
    if (edited != null) {
      setState(() => _formats[index] = edited);
    }
  }

  void _deleteFormat(int index) {
    if (_formats.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('At least one format is required.')),
      );
      return;
    }
    final removed = _formats[index];
    setState(() {
      _formats.removeAt(index);
      if (_defaultFormatId == removed.id) {
        _defaultFormatId = _formats.first.id;
      }
    });
  }

  void _resetDefaults() {
    setState(() {
      _formats = List.of(LessonFormat.defaultFormats);
      _defaultFormatId = _formats.first.id;
      _plannerQuestions = [
        "Include core conceptual theory and definitions",
        "Include step-by-step worked examples",
        "Include mathematical proofs or derivations",
        "Include interactive code or pseudo-code snippets",
        "Include quiz or exercises for self-testing",
        "Include summary slides for quick review",
      ];
    });
  }

  Future<void> _save() async {
    Book updated;
    if (widget.section != null &&
        widget.modIdx != null &&
        widget.secIdx != null) {
      final modules = List<Module>.from(widget.book.modules);
      final sections = List<Section>.from(modules[widget.modIdx!].sections);
      sections[widget.secIdx!] = sections[widget.secIdx!].copyWith(
        lessonFormats: _formats,
      );
      modules[widget.modIdx!] = modules[widget.modIdx!].copyWith(
        sections: sections,
      );
      updated = widget.book.copyWith(
        modules: modules,
        plannerQuestions: _plannerQuestions,
      );
    } else {
      updated = widget.book.copyWith(
        lessonFormats: _formats,
        defaultFormatId: _defaultFormatId,
        plannerQuestions: _plannerQuestions,
      );
    }
    await DatabaseService().saveGeneratedBook(updated);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Course settings saved.')));
      Navigator.pop(context);
    }
  }

  Widget _buildFormatsTab(BuildContext context) {
    return ResponsiveCenter(
      maxWidth: ResponsiveMaxWidth.form,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text(
              widget.section != null
                  ? 'Define multiple lesson formats for this section. The AI assigns one of these formats to each unit in this section.'
                  : 'Define multiple lesson formats — one per pedagogical pattern (theory, worked example, proof, etc.). The AI assigns one to each unit when it generates the unit list; you confirm or change the assignments afterwards.',
              style: TextStyle(
                color: context.colors.textFaint,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _formats.length,
              itemBuilder: (context, i) {
                final f = _formats[i];
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.colors.outline, width: 1),
                  ),
                  child: InkWell(
                    onTap: () => _openEditor(i),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            f.name,
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            f.description,
                            style: TextStyle(
                              color: context.colors.textSecondary,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                LucideIcons.list,
                                size: 13,
                                color: context.colors.textFaint,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '${f.slides.length} slides — ${f.slides.map((s) => s.type).join(", ")}',
                                style: TextStyle(
                                  color: context.colors.textFaint,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                tooltip: 'Edit',
                                icon: Icon(
                                  LucideIcons.edit2,
                                  size: 18,
                                  color: context.colors.textFaint,
                                ),
                                onPressed: () => _openEditor(i),
                              ),
                              IconButton(
                                tooltip: 'Delete',
                                icon: const Icon(
                                  LucideIcons.trash2,
                                  size: 18,
                                  color: AppTheme.duoRed,
                                ),
                                onPressed: () => _deleteFormat(i),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  child: DuoButton(
                    text: 'Add Format',
                    onPressed: _addFormat,
                    color: context.colors.surface,
                    shadowColor: Colors.black,
                    isOutline: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DuoButton(
                    text: 'Save',
                    onPressed: _save,
                    color: AppTheme.duoBlue,
                    shadowColor: AppTheme.duoBlueDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromptChoicesTab(BuildContext context) {
    return ResponsiveCenter(
      maxWidth: ResponsiveMaxWidth.form,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text(
              'Edit the objective options that appear as selection chips when planning section units. Users can toggle these choices to guide the AI.',
              style: TextStyle(
                color: context.colors.textFaint,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _plannerQuestions.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.colors.outline, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _plannerQuestions[i],
                          style: TextStyle(
                            color: context.colors.textPrimary,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                'e.g. Include interactive coding exercises',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: context.colors.textFaint,
                            ),
                          ),
                          onChanged: (val) {
                            _plannerQuestions[i] = val.trim();
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          LucideIcons.trash2,
                          color: AppTheme.duoRed,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _plannerQuestions.removeAt(i);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  child: DuoButton(
                    text: 'Add Choice',
                    onPressed: () {
                      setState(() {
                        _plannerQuestions.add('');
                      });
                    },
                    color: context.colors.surface,
                    shadowColor: Colors.black,
                    isOutline: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DuoButton(
                    text: 'Save',
                    onPressed: _save,
                    color: AppTheme.duoBlue,
                    shadowColor: AppTheme.duoBlueDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.section != null
                ? 'Section Formats: ${widget.section!.title}'
                : 'Course Settings',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Lesson Formats'),
              Tab(text: 'Prompt Choices'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                LucideIcons.refreshCcw,
                color: AppTheme.duoOrange,
              ),
              tooltip: 'Reset to defaults',
              onPressed: _resetDefaults,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildFormatsTab(context),
            _buildPromptChoicesTab(context),
          ],
        ),
      ),
    );
  }
}

/// Per-format editor: name + description + reorderable slide list (the
/// classic single-format UI). Returns the edited [LessonFormat] when the
/// user taps "Save"; null on cancel.
class FormatEditorScreen extends StatefulWidget {
  final LessonFormat format;

  const FormatEditorScreen({super.key, required this.format});

  @override
  State<FormatEditorScreen> createState() => _FormatEditorScreenState();
}

class _FormatEditorScreenState extends State<FormatEditorScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _descCtrl;
  late List<SlideTemplate> _slides;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.format.name);
    _descCtrl = TextEditingController(text: widget.format.description);
    _slides = List.of(widget.format.slides);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _addSlide() {
    setState(
      () => _slides.add(
        SlideTemplate(
          type: 'theory',
          condition: 'Always',
          description: 'New description...',
        ),
      ),
    );
  }

  void _editSlide(int index) {
    final slide = _slides[index];

    const Map<String, String> slideTypes = {
      'theory': 'Theory (factual & core concepts)',
      'concept_pieces': 'Concept Pieces (short connected sentences)',
      'program': 'Coding Blank (runnable fill-in code)',
      'try_yourself': 'Coding Sandbox (runnable playground)',
      'proof': 'Step-by-step Proof (interactive proof logic)',
      'quiz': 'Quiz (multiple choice question)',
      'fill_in_blank': 'Fill in the Blank (text recall)',
      'one_word': 'One Word (recall typing game)',
      'numerical': 'Numerical (math equation solver)',
      'matching': 'Matching (drag connection pairs)',
      'ordering': 'Ordering (sequence/step sorting)',
      'flashcard': 'Flashcard (recall self-graded flip card)',
      'descriptive': 'Descriptive (paragraph + optional photo review)',
      'custom_html': 'Custom HTML/JS (canvas/interactive iframe)',
      'custom': 'Custom (type your own type)',
    };

    const Map<String, String> defaultDescriptions = {
      'theory': 'The original factual theory and core concepts presented directly, with no storytelling, narrative framing, or example-based scenarios.',
      'concept_pieces': 'A conceptual breakdown showing a complex or long concept split into a series of short, connected, easy-to-read sentences or bullet-points.',
      'program': 'A code snippet featuring a blank `___` in a key part of the script. The learner must complete the blank to make the code run and pass verification.',
      'try_yourself': 'An interactive editable playground preloaded with starter code. The learner can run and edit the script, outputting results directly in the console.',
      'proof': 'Interactive step-by-step logic proof.',
      'quiz': 'A multiple-choice question testing understanding.',
      'fill_in_blank': 'Recall key terms with a fill-in-the-blank question.',
      'one_word': 'Recall a single key term by typing it as a one-word answer (no options shown).',
      'numerical': 'A problem whose answer is a number the learner types in.',
      'matching': 'Match items in the left column to their partners on the right.',
      'ordering': 'Drag shuffled steps into the correct sequence.',
      'flashcard': 'Recall-then-flip card with honest self-grading; misses enter spaced review.',
      'descriptive': 'A question requiring a paragraph explanation and optional photo upload, reviewed by AI.',
      'custom_html': 'An interactive custom slide written in HTML and Javascript. Can contain buttons, text inputs, canvases, sliders, and logic. Calls DuoMessageChannel.postMessage("complete") when completed.',
    };

    String initialSelectedType = slideTypes.containsKey(slide.type) ? slide.type : 'custom';

    final typeCtrl = TextEditingController(text: slide.type);
    final conditionCtrl = TextEditingController(text: slide.condition);
    final descCtrl = TextEditingController(text: slide.description);

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setStateDialog) {
            return AlertDialog(
              backgroundColor: context.colors.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(
                'Edit Slide Template',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      value: initialSelectedType,
                      dropdownColor: context.colors.surface,
                      style: TextStyle(color: context.colors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Slide Type Preset',
                        labelStyle: TextStyle(color: context.colors.textFaint),
                        filled: true,
                        fillColor: context.colors.surfaceAlt,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: slideTypes.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        if (newVal == null) return;
                        setStateDialog(() {
                          initialSelectedType = newVal;
                          if (newVal != 'custom') {
                            typeCtrl.text = newVal;
                            if (descCtrl.text.isEmpty ||
                                defaultDescriptions.values.contains(descCtrl.text) ||
                                descCtrl.text == 'New description...') {
                              descCtrl.text = defaultDescriptions[newVal] ?? '';
                            }
                          } else {
                            typeCtrl.text = '';
                          }
                        });
                      },
                    ),
                    if (initialSelectedType == 'custom') ...[
                      SizedBox(height: 16),
                      TextField(
                        controller: typeCtrl,
                        style: TextStyle(color: context.colors.textPrimary),
                        decoration: InputDecoration(
                          labelText: 'Custom Slide Type',
                          hintText: 'e.g., custom_game',
                          labelStyle: TextStyle(color: context.colors.textFaint),
                          filled: true,
                          fillColor: context.colors.surfaceAlt,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 16),
                    TextField(
                      controller: conditionCtrl,
                      maxLines: 2,
                      style: TextStyle(color: context.colors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Condition / Priority',
                        hintText: 'e.g., Always, or Only if programming course',
                        labelStyle: TextStyle(color: context.colors.textFaint),
                        filled: true,
                        fillColor: context.colors.surfaceAlt,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: descCtrl,
                      maxLines: 4,
                      style: TextStyle(color: context.colors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Instruction to AI',
                        labelStyle: TextStyle(color: context.colors.textFaint),
                        filled: true,
                        fillColor: context.colors.surfaceAlt,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: context.colors.textFaint),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final finalType = typeCtrl.text.trim();
                    if (finalType.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Slide type cannot be empty')),
                      );
                      return;
                    }
                    setState(() {
                      _slides[index] = SlideTemplate(
                        type: finalType,
                        condition: conditionCtrl.text,
                        description: descCtrl.text,
                      );
                    });
                    Navigator.pop(ctx);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: AppTheme.duoBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'theory':
        return LucideIcons.bookOpen;
      case 'concept_pieces':
        return LucideIcons.gitCommit;
      case 'descriptive':
        return LucideIcons.text;
      case 'quiz':
        return LucideIcons.list;
      case 'fill_in_blank':
        return LucideIcons.minus;
      case 'one_word':
        return LucideIcons.pencil;
      case 'numerical':
        return LucideIcons.calculator;
      case 'proof':
      case 'step_by_step':
        return LucideIcons.brainCircuit;
      case 'program':
      case 'try_yourself':
        return LucideIcons.code;
      default:
        return LucideIcons.file;
    }
  }

  void _save() {
    final name = _nameCtrl.text.trim().isEmpty
        ? widget.format.name
        : _nameCtrl.text.trim();
    Navigator.pop(
      context,
      widget.format.copyWith(
        name: name,
        description: _descCtrl.text.trim(),
        slides: _slides,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Format',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.form,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _nameCtrl,
                    style: TextStyle(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Format name',
                      labelStyle: TextStyle(color: context.colors.textFaint),
                      filled: true,
                      fillColor: context.colors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _descCtrl,
                    maxLines: 2,
                    style: TextStyle(color: context.colors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'When should the AI pick this format?',
                      labelStyle: TextStyle(color: context.colors.textFaint),
                      filled: true,
                      fillColor: context.colors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Slide sequence',
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ReorderableListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _slides.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final item = _slides.removeAt(oldIndex);
                    _slides.insert(newIndex, item);
                  });
                },
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Container(
                    key: ValueKey('slide_$index'),
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.colors.outline),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Icon(
                          _getIconForType(slide.type),
                          color: AppTheme.duoViolet,
                        ),
                        title: Text(
                          slide.type.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            color: AppTheme.duoViolet,
                            letterSpacing: 1.0,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Condition: ${slide.condition}",
                                style: const TextStyle(
                                  color: AppTheme.duoOrange,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                slide.description,
                                style: TextStyle(
                                  color: context.colors.textPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                LucideIcons.edit2,
                                size: 18,
                                color: context.colors.textFaint,
                              ),
                              onPressed: () => _editSlide(index),
                            ),
                            IconButton(
                              icon: Icon(
                                LucideIcons.trash2,
                                size: 18,
                                color: AppTheme.duoRed,
                              ),
                              onPressed: () =>
                                  setState(() => _slides.removeAt(index)),
                            ),
                            Icon(
                              LucideIcons.gripVertical,
                              color: context.colors.textFaint,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: DuoButton(
                      text: 'Add Slide',
                      onPressed: _addSlide,
                      color: context.colors.surface,
                      shadowColor: Colors.black,
                      isOutline: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DuoButton(
                      text: 'Save Format',
                      onPressed: _save,
                      color: AppTheme.duoBlue,
                      shadowColor: AppTheme.duoBlueDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}