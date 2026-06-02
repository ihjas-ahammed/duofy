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

  const CourseSettingsScreen({super.key, required this.book});

  @override
  State<CourseSettingsScreen> createState() => _CourseSettingsScreenState();
}

class _CourseSettingsScreenState extends State<CourseSettingsScreen> {
  late List<LessonFormat> _formats;
  late String _defaultFormatId;

  @override
  void initState() {
    super.initState();
    _formats = List.of(widget.book.lessonFormats);
    _defaultFormatId = widget.book.defaultFormatId;
    if (_formats.isEmpty) {
      _formats = List.of(LessonFormat.defaultFormats);
      _defaultFormatId = _formats.first.id;
    }
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
      MaterialPageRoute(builder: (_) => FormatEditorScreen(format: _formats[index])),
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
    });
  }

  Future<void> _save() async {
    final updated = widget.book.copyWith(
      lessonFormats: _formats,
      defaultFormatId: _defaultFormatId,
    );
    await DatabaseService().saveGeneratedBook(updated);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lesson formats saved.')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Formats', style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.refreshCcw, color: AppTheme.duoOrange),
            tooltip: 'Reset to defaults',
            onPressed: _resetDefaults,
          ),
        ],
      ),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.form,
        child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text(
              'Define multiple lesson formats — one per pedagogical pattern (theory, worked example, proof, etc.). The AI assigns one to each unit when it generates the unit list; you confirm or change the assignments afterwards.',
              style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _formats.length,
              itemBuilder: (context, i) {
                final f = _formats[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12, width: 1),
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
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 4),
                          Text(f.description,
                              style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(LucideIcons.list, size: 13, color: Colors.white38),
                              const SizedBox(width: 6),
                              Text('${f.slides.length} slides — ${f.slides.map((s) => s.type).join(", ")}',
                                  style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                tooltip: 'Edit',
                                icon: const Icon(LucideIcons.edit2, size: 18, color: Colors.white54),
                                onPressed: () => _openEditor(i),
                              ),
                              IconButton(
                                tooltip: 'Delete',
                                icon: const Icon(LucideIcons.trash2, size: 18, color: AppTheme.duoRed),
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
                    color: AppTheme.surface,
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
    setState(() => _slides.add(SlideTemplate(type: 'theory', condition: 'Always', description: 'New description...')));
  }

  void _editSlide(int index) {
    final slide = _slides[index];
    final typeCtrl = TextEditingController(text: slide.type);
    final conditionCtrl = TextEditingController(text: slide.condition);
    final descCtrl = TextEditingController(text: slide.description);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Edit Slide Template', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: typeCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Slide Type (Custom allowed)',
                  labelStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: conditionCtrl,
                maxLines: 2,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Condition / Priority',
                  hintText: 'e.g., Only if mathematical proof is needed',
                  labelStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descCtrl,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Instruction to AI',
                  labelStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () {
              setState(() {
                _slides[index] = SlideTemplate(type: typeCtrl.text, condition: conditionCtrl.text, description: descCtrl.text);
              });
              Navigator.pop(ctx);
            },
            child: const Text('Save', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'theory':
        return LucideIcons.bookOpen;
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
      default:
        return LucideIcons.file;
    }
  }

  void _save() {
    final name = _nameCtrl.text.trim().isEmpty ? widget.format.name : _nameCtrl.text.trim();
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
        title: const Text('Edit Format', style: TextStyle(fontWeight: FontWeight.w900)),
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
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Format name',
                    labelStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: AppTheme.surface,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descCtrl,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'When should the AI pick this format?',
                    labelStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: AppTheme.surface,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Slide sequence',
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900),
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
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: Icon(_getIconForType(slide.type), color: AppTheme.duoViolet),
                      title: Text(slide.type.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: AppTheme.duoViolet, letterSpacing: 1.0)),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Condition: ${slide.condition}",
                                style: const TextStyle(color: AppTheme.duoOrange, fontSize: 10, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(slide.description, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(LucideIcons.edit2, size: 18, color: Colors.white54),
                            onPressed: () => _editSlide(index),
                          ),
                          IconButton(
                            icon: const Icon(LucideIcons.trash2, size: 18, color: AppTheme.duoRed),
                            onPressed: () => setState(() => _slides.removeAt(index)),
                          ),
                          const Icon(LucideIcons.gripVertical, color: Colors.white38),
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
                    color: AppTheme.surface,
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
