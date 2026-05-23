import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/string_list_manager.dart';
import 'pdf_browser_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _keys = [];
  List<String> _models = [];
  String _modelPrimaryText = 'gemma4';
  String _modelPrimaryGraphics = 'gemini-3.5-flash';
  String _modelLite = 'gemini-flash-lite-latest';
  bool _isFetchingModels = false;
  bool _isLoading = true;
  final GlobalKey<StringListManagerState> _keysManagerKey = GlobalKey<StringListManagerState>();
  final DatabaseService _db = DatabaseService();

  final user = FirebaseAuth.instance.currentUser;

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

    String modelPrimaryText = prefs.getString('model_primary_text') ?? 'gemma4';
    String modelPrimaryGraphics = prefs.getString('model_primary_graphics') ?? 'gemini-3.5-flash';
    String modelLite = prefs.getString('model_lite') ?? 'gemini-flash-lite-latest';

    // Hydrate from Firestore if local is empty.
    if (keys.isEmpty || models.isEmpty) {
      final remote = await _db.fetchUserSettings();
      if (remote != null) {
        if (keys.isEmpty && remote['apiKeys'] != null && (remote['apiKeys'] as List).isNotEmpty) {
          keys = List<String>.from(remote['apiKeys']!);
          await prefs.setStringList('gemini_api_keys_list', keys);
        }
        if (models.isEmpty && remote['models'] != null && (remote['models'] as List).isNotEmpty) {
          models = List<String>.from(remote['models']!);
          await prefs.setStringList('gemini_models_list', models);
        }
        if (remote['modelPrimaryText'] != null) {
          modelPrimaryText = remote['modelPrimaryText'];
          await prefs.setString('model_primary_text', modelPrimaryText);
        }
        if (remote['modelPrimaryGraphics'] != null) {
          modelPrimaryGraphics = remote['modelPrimaryGraphics'];
          await prefs.setString('model_primary_graphics', modelPrimaryGraphics);
        }
        if (remote['modelLite'] != null) {
          modelLite = remote['modelLite'];
          await prefs.setString('model_lite', modelLite);
        }
      }
    }

    _keys = List.from(keys);
    _models = List.from(models);
    _modelPrimaryText = modelPrimaryText;
    _modelPrimaryGraphics = modelPrimaryGraphics;
    _modelLite = modelLite;

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    // Commit any pending text in the API-key input field before reading the list.
    _keysManagerKey.currentState?.commitPending();

    final prefs = await SharedPreferences.getInstance();
    final keysSaved = await prefs.setStringList('gemini_api_keys_list', _keys);
    final modelsSaved = await prefs.setStringList('gemini_models_list', _models);
    final pTextSaved = await prefs.setString('model_primary_text', _modelPrimaryText);
    final pGraphicsSaved = await prefs.setString('model_primary_graphics', _modelPrimaryGraphics);
    final liteSaved = await prefs.setString('model_lite', _modelLite);

    if (!keysSaved || !modelsSaved || !pTextSaved || !pGraphicsSaved || !liteSaved) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Local save failed — syncing to cloud only.')));
      }
    }

    await _db.saveUserSettings(
      apiKeys: _keys,
      models: _models,
      modelPrimaryText: _modelPrimaryText,
      modelPrimaryGraphics: _modelPrimaryGraphics,
      modelLite: _modelLite,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved ${_keys.length} key(s) and assigned models.')));
      Navigator.pop(context);
    }
  }

  Future<void> _showModelPicker(String slotName) async {
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
          if (name.contains('gemini') || name.contains('gemma')) fetchedModels.add(name);
        }

        // Add custom Gemma 4 names if not present
        for (final id in const ['gemma4', 'gemini-3.5-flash', 'gemini-flash-lite-latest', 'gemma-4-31b-it', 'gemma-4-26b-a4b-it']) {
          if (!fetchedModels.contains(id)) fetchedModels.add(id);
        }

        fetchedModels.sort((a, b) {
          int rank(String n) {
            if (n.startsWith('gemma-4') || n == 'gemma4') return 0;
            if (n.startsWith('gemini-2')) return 1;
            if (n.startsWith('gemini')) return 2;
            if (n.startsWith('gemma')) return 3;
            return 4;
          }
          final r = rank(a).compareTo(rank(b));
          return r != 0 ? r : a.compareTo(b);
        });

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
                   Text('Select Model for $slotName', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white)),
                   const SizedBox(height: 16),
                   Expanded(
                     child: ListView.builder(
                       itemCount: fetchedModels.length,
                       itemBuilder: (c, i) => ListTile(
                         leading: const Icon(LucideIcons.bot, color: AppTheme.duoBlue),
                         title: Text(fetchedModels[i], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                         onTap: () {
                            setState(() {
                              if (slotName == 'Primary - Text') {
                                _modelPrimaryText = fetchedModels[i];
                              } else if (slotName == 'Primary - Graphics') {
                                _modelPrimaryGraphics = fetchedModels[i];
                              } else if (slotName == 'Lite') {
                                _modelLite = fetchedModels[i];
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

  Widget _buildModelSlotCard({
    required String title,
    required String subtitle,
    required String selectedModel,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.duoBlue, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Text(
                    selectedModel,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(LucideIcons.edit2, color: Colors.white54),
            onPressed: onTap,
          ),
        ],
      ),
    );
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
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 32),
              decoration: AppTheme.glassDecoration,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppTheme.duoBlue,
                    child: Text(
                      user?.displayName?.isNotEmpty == true ? user!.displayName![0].toUpperCase() : 'U', 
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user?.displayName ?? 'Guest User', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white)),
                        Text(user?.email ?? 'Not logged in', style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: DuoButton(
                text: 'PDF Browser',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PdfBrowserScreen()));
                },
                color: AppTheme.duoViolet,
                shadowColor: AppTheme.duoVioletDark,
              ),
            ),
            const SizedBox(height: 32),

            const Text('API Keys', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Add multiple keys to fall back automatically if rate-limited.', style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 16),
            StringListManager(
              key: _keysManagerKey,
              initialItems: _keys,
              hintText: 'Enter Gemini API Key',
              itemIcon: LucideIcons.key,
              onChanged: (newKeys) => setState(() => _keys = newKeys),
            ),
            const SizedBox(height: 32),

            const Text('AI Model Assignments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Select specialized models for text, graphics, and light-weight tasks.', style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Primary - Text',
              subtitle: 'Generates final interactive lessons & quizzes.',
              selectedModel: _modelPrimaryText,
              icon: LucideIcons.fileText,
              onTap: () => _showModelPicker('Primary - Text'),
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Primary - Graphics',
              subtitle: 'Used for rendering and generating media assets.',
              selectedModel: _modelPrimaryGraphics,
              icon: LucideIcons.image,
              onTap: () => _showModelPicker('Primary - Graphics'),
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Lite',
              subtitle: 'Creates skeletons and maps lesson plan lists.',
              selectedModel: _modelLite,
              icon: LucideIcons.zap,
              onTap: () => _showModelPicker('Lite'),
            ),
            
            const SizedBox(height: 48),
            DuoButton(
              text: 'Save Settings',
              onPressed: _saveSettings,
              color: AppTheme.duoGreen,
              shadowColor: AppTheme.duoGreenDark,
            ),
            
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: DuoButton(
                text: 'Sign Out',
                onPressed: () async {
                  Navigator.pop(context);
                  await FirebaseAuth.instance.signOut();
                },
                color: AppTheme.duoRed,
                shadowColor: AppTheme.duoRedDark,
                isOutline: true,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}