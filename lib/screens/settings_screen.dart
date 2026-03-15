import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _keysController = TextEditingController();
  String _selectedModel = 'gemini-1.5-flash';
  
  final List<String> _models = [
    'gemini-1.5-flash',
    'gemini-1.5-pro',
    'gemini-2.0-flash-exp'
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _keysController.text = prefs.getString('gemini_api_keys') ?? '';
      _selectedModel = prefs.getString('gemini_model') ?? 'gemini-1.5-flash';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gemini_api_keys', _keysController.text.trim());
    await prefs.setString('gemini_model', _selectedModel);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings Saved Successfully')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Google Generative AI Config', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            TextField(
              controller: _keysController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Gemini API Keys (Comma Separated)',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black26,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Enter multiple API keys separated by commas. The system will fallback if one is rate limited.', style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 24),

            const Text('Active AI Model', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedModel,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black26,
              ),
              items: _models.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedModel = val);
              },
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