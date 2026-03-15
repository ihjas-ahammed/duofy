import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/api_keys_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _keys =[];
  String _selectedModel = 'gemini-1.5-flash';
  bool _isFetchingModels = false;
  
  List<String> _models =[
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
      List<String> keys = prefs.getStringList('gemini_api_keys_list') ??[];
      if (keys.isEmpty) {
         final keysString = prefs.getString('gemini_api_keys') ?? '';
         keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
      _keys = keys;
      _selectedModel = prefs.getString('gemini_model') ?? 'gemini-1.5-flash';
      
      if (!_models.contains(_selectedModel)) {
        _models.insert(0, _selectedModel);
      }
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('gemini_api_keys_list', _keys);
    await prefs.setString('gemini_model', _selectedModel);
    
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
        final List fetched = data['models'] ??[];
        List<String> newModels =[];
        
        for (var m in fetched) {
          String name = m['name'];
          if (name.startsWith('models/')) name = name.substring(7);
          if (name.contains('gemini')) newModels.add(name);
        }

        if (newModels.isNotEmpty) {
          setState(() {
            _models = newModels;
            if (!_models.contains(_selectedModel)) _selectedModel = _models.first;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Models fetched successfully!')));
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
    return Scaffold(
      appBar: AppBar(title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w900))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const Text('API Keys', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Add multiple keys to fall back automatically if rate-limited.', style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 16),
            
            ApiKeysManager(
              initialKeys: _keys,
              onChanged: (newKeys) => setState(() => _keys = newKeys),
            ),
            const SizedBox(height: 32),

            const Text('Active AI Model', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedModel,
              isExpanded: true,
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
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: DuoButton(
                text: _isFetchingModels ? 'Fetching...' : 'Fetch Latest Models',
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