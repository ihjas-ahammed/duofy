import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/database_service.dart';
import '../widgets/duo_button.dart';

class CourseSettingsScreen extends StatefulWidget {
  final Book book;

  const CourseSettingsScreen({super.key, required this.book});

  @override
  State<CourseSettingsScreen> createState() => _CourseSettingsScreenState();
}

class _CourseSettingsScreenState extends State<CourseSettingsScreen> {
  late List<SlideTemplate> _templates;

  @override
  void initState() {
    super.initState();
    _templates = List.from(widget.book.lessonTemplate ?? SlideTemplate.defaultTemplate);
  }

  Future<void> _saveConfig() async {
    final updatedBook = widget.book.copyWith(lessonTemplate: _templates);
    await DatabaseService().saveGeneratedBook(updatedBook);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Course Configuration Saved!')));
      Navigator.pop(context);
    }
  }

  void _addSlide() {
    setState(() {
      _templates.add(SlideTemplate(type: 'theory', condition: 'Always', description: 'New description...'));
    });
  }

  void _editSlide(int index) {
    final slide = _templates[index];
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
                _templates[index] = SlideTemplate(
                  type: typeCtrl.text, 
                  condition: conditionCtrl.text,
                  description: descCtrl.text
                );
              });
              Navigator.pop(ctx);
            },
            child: const Text('Save', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          )
        ],
      )
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'theory': return LucideIcons.bookOpen;
      case 'quiz': return LucideIcons.list;
      case 'fill_in_blank': return LucideIcons.minus;
      case 'numerical': return LucideIcons.calculator;
      case 'interactive_canvas': return LucideIcons.mousePointer2;
      case 'proof':
      case 'step_by_step': return LucideIcons.brainCircuit;
      default: return LucideIcons.file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Configuration', style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.refreshCcw, color: AppTheme.duoOrange),
            tooltip: 'Reset Defaults',
            onPressed: () => setState(() => _templates = List.from(SlideTemplate.defaultTemplate)),
          )
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text(
              'Define the sequence and explicit conditions for slides. The AI will strictly evaluate your conditions (e.g., "Only if math proof is required") before generating that type.',
              style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _templates.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = _templates.removeAt(oldIndex);
                  _templates.insert(newIndex, item);
                });
              },
              itemBuilder: (context, index) {
                final slide = _templates[index];
                return Container(
                  key: ValueKey('slide_$index'),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Icon(_getIconForType(slide.type), color: AppTheme.duoViolet),
                    title: Text(slide.type.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: AppTheme.duoViolet, letterSpacing: 1.0)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Condition: ${slide.condition}", style: const TextStyle(color: AppTheme.duoOrange, fontSize: 10, fontWeight: FontWeight.bold)),
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
                          onPressed: () => setState(() => _templates.removeAt(index)),
                        ),
                        const Icon(LucideIcons.gripVertical, color: Colors.white38),
                      ],
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
                    text: 'Save Sequence',
                    onPressed: _saveConfig,
                    color: AppTheme.duoBlue,
                    shadowColor: AppTheme.duoBlueDark,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}