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
  final _keyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadKey();
  }

  Future<void> _loadKey() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _keyController.text = prefs.getString('gemini_api_key') ?? '';
    });
  }

  Future<void> _saveKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gemini_api_key', _keyController.text.trim());
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('API Key Saved Successfully')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Google Generative AI Configuration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _keyController,
              decoration: const InputDecoration(
                labelText: 'Gemini API Key',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black26,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            const Text('Get your free API key from Google AI Studio. It is stored safely on your local device.', style: TextStyle(color: Colors.white54, fontSize: 12)),
            const Spacer(),
            DuoButton(
              text: 'Save Settings',
              onPressed: _saveKey,
              color: AppTheme.duoGreen,
              shadowColor: AppTheme.duoGreenDark,
            )
          ],
        ),
      ),
    );
  }
}