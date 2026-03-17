import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/string_list_manager.dart';
import 'pdf_browser_screen.dart';
import 'advanced_prompts_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _keys = [];
  List<String> _models = [];
  bool _isFetchingModels = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    List<String> keys = prefs.getStringList('gemini_api_keys_list') ?? [];
    if (keys.isEmpty) {
       final keysString = prefs.getString('gemini_api_keys') ?? '';
       keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    
    List<String> models = prefs.getStringList('gemini_models_list') ?? [];
    if (models.isEmpty) {
       final oldModel = prefs.getString('gemini_model') ?? 'gemini-1.5-flash';
       models = [oldModel];
    }
    
    _keys = List.from(keys);
    _models = List.from(models);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('gemini_api_keys_list', _keys);
    await prefs.setStringList('gemini_models_list', _models);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings Saved Successfully')));
      Navigator.pop(context);
    }
  }

  Future<void> _fetchModels() async {
    if (_keys.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please add an API key first.')));
      return;
    }

    setState(() => _isFetchingModels = true);
    try {
      final response = await http.get(Uri.parse('https://generativelanguage.googleapis.com/v1beta/models?key=${_keys.first}'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List fetched = data['models'] ?? [];
        List<String> fetchedModels = [];
        
        for (var m in fetched) {
          String name = m['name'];
          if (name.startsWith('models/')) name = name.substring(7);
          if (name.contains('gemini')) fetchedModels.add(name);
        }

        if (fetchedModels.isNotEmpty && mounted) {
           showModalBottomSheet(
             context: context,
             backgroundColor: AppTheme.surface,
             shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
             builder: (ctx) => Padding(
               padding: const EdgeInsets.all(16.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text('Available Models', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white)),
                   const SizedBox(height: 16),
                   Expanded(
                     child: ListView.builder(
                       itemCount: fetchedModels.length,
                       itemBuilder: (c, i) => ListTile(
                         leading: const Icon(LucideIcons.bot, color: AppTheme.duoBlue),
                         title: Text(fetchedModels[i], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                         onTap: () {
                            setState(() {
                              if (!_models.contains(fetchedModels[i]) && _models.length < 5) {
                                _models.add(fetchedModels[i]);
                              }
                            });
                            Navigator.pop(ctx);
                         },
                       )
                     ),
                   ),
                 ],
               ),
             )
           );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch: ${response.statusCode}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isFetchingModels = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppTheme.duoBlue)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w900))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Row(
              children: [
                Expanded(
                  child: DuoButton(
                    text: 'PDF Browser',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const PdfBrowserScreen()));
                    },
                    color: AppTheme.duoViolet,
                    shadowColor: AppTheme.duoVioletDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DuoButton(
                    text: 'Advanced',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AdvancedPromptsScreen()));
                    },
                    color: AppTheme.duoOrange,
                    shadowColor: AppTheme.duoOrangeDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            const Text('API Keys', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Add multiple keys to fall back automatically if rate-limited.', style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 16),
            StringListManager(
              initialItems: _keys,
              hintText: 'Enter Gemini API Key',
              itemIcon: LucideIcons.key,
              onChanged: (newKeys) => setState(() => _keys = newKeys),
            ),
            const SizedBox(height: 32),

            const Text('AI Models Sequence', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Add up to 5 models. Top models will be prioritized.', style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 16),
            
            if (_models.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _models.map((m) => Chip(
                  label: Text(m, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  deleteIcon: const Icon(LucideIcons.x, size: 16, color: Colors.white54),
                  backgroundColor: Colors.white.withOpacity(0.1),
                  side: const BorderSide(color: Colors.white24),
                  onDeleted: () => setState(() => _models.remove(m)),
                )).toList(),
              ),
              
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: DuoButton(
                text: _isFetchingModels ? 'Fetching...' : 'Browse Available Models',
                onPressed: _isFetchingModels ? () {} : _fetchModels,
                color: AppTheme.duoBlue,
                shadowColor: AppTheme.duoBlueDark,
                isOutline: true,
              ),
            ),
            
            const SizedBox(height: 48),
            DuoButton(
              text: 'Save Settings',
              onPressed: _saveSettings,
              color: AppTheme.duoGreen,
              shadowColor: AppTheme.duoGreenDark,
            )
          ],
        ),
      ),
    );
  }
}