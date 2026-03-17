import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';
import '../services/prompt_service.dart';
import '../widgets/duo_button.dart';

class AdvancedPromptsScreen extends StatefulWidget {
  const AdvancedPromptsScreen({super.key});

  @override
  State<AdvancedPromptsScreen> createState() => _AdvancedPromptsScreenState();
}

class _AdvancedPromptsScreenState extends State<AdvancedPromptsScreen> {
  final _skeletonCtrl = TextEditingController();
  final _planCtrl = TextEditingController();
  final _jsonCtrl = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrompts();
  }

  Future<void> _loadPrompts() async {
    _skeletonCtrl.text = await PromptService.getSkeletonPrompt();
    _planCtrl.text = await PromptService.getPlanPrompt();
    _jsonCtrl.text = await PromptService.getJsonPrompt();
    setState(() => _isLoading = false);
  }

  Future<void> _savePrompts() async {
    await PromptService.saveSkeletonPrompt(_skeletonCtrl.text);
    await PromptService.savePlanPrompt(_planCtrl.text);
    await PromptService.saveJsonPrompt(_jsonCtrl.text);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Custom prompts saved!')));
      Navigator.pop(context);
    }
  }

  Future<void> _resetToDefaults() async {
    await PromptService.resetToDefaults();
    await _loadPrompts();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Restored defaults.')));
    }
  }

  Widget _buildEditor(String title, String description, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: AppTheme.glassDecoration,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppTheme.duoOrange,
          collapsedIconColor: Colors.white54,
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white)),
          subtitle: Text(description, style: const TextStyle(fontSize: 12, color: Colors.white54)),
          childrenPadding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: controller,
              maxLines: 12,
              style: const TextStyle(fontSize: 12, color: Colors.white70, fontFamily: 'monospace'),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black45,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppTheme.duoOrange)));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Prompts', style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.refreshCcw, color: AppTheme.duoRed),
            onPressed: _resetToDefaults,
            tooltip: 'Reset Defaults',
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 24, left: 8, right: 8),
              child: Text(
                'Edit the exact instructions sent to the AI. Use variables like %filename%, %unit_title% to inject dynamic data.',
                style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
              ),
            ),
            
            _buildEditor(
              'Stage 1: Book Skeleton', 
              'Generates the TOC mapping. Variables: %filename%', 
              _skeletonCtrl
            ),
            _buildEditor(
              'Stage 2.1: Lesson Plan', 
              'Generates pedagogical layout. Variables: %unit_title%', 
              _planCtrl
            ),
            _buildEditor(
              'Stage 2.2: JSON Extraction', 
              'Enforces strict schema. Variables: %unit_title%, %system_prompt%, %lesson_plan%', 
              _jsonCtrl
            ),
            
            const SizedBox(height: 16),
            DuoButton(
              text: 'Save Prompts',
              color: AppTheme.duoOrange,
              shadowColor: AppTheme.duoOrangeDark,
              onPressed: _savePrompts,
            ),
            const SizedBox(height: 40), // Safe area
          ],
        ),
      ),
    );
  }
}