import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdeSettings {
  final bool? forceDarkMode; // null = follow app theme, true = dark, false = light
  final double fontSize; // e.g. 11.0 to 22.0
  final bool wordWrap;
  final bool showLineNumbers;

  const IdeSettings({
    this.forceDarkMode,
    this.fontSize = 13.0,
    this.wordWrap = true,
    this.showLineNumbers = true,
  });

  IdeSettings copyWith({
    bool? forceDarkMode,
    double? fontSize,
    bool? wordWrap,
    bool? showLineNumbers,
  }) {
    return IdeSettings(
      forceDarkMode: forceDarkMode ?? this.forceDarkMode,
      fontSize: fontSize ?? this.fontSize,
      wordWrap: wordWrap ?? this.wordWrap,
      showLineNumbers: showLineNumbers ?? this.showLineNumbers,
    );
  }
}

class IdeSettingsService extends ChangeNotifier {
  static final IdeSettingsService _instance = IdeSettingsService._internal();
  static IdeSettingsService get instance => _instance;
  IdeSettingsService._internal() {
    loadSettings();
  }

  IdeSettings _settings = const IdeSettings();
  IdeSettings get settings => _settings;

  static const String _keyDarkMode = 'ide_force_dark_mode';
  static const String _keyFontSize = 'ide_font_size';
  static const String _keyWordWrap = 'ide_word_wrap';
  static const String _keyLineNumbers = 'ide_show_line_numbers';

  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool? darkVal;
      if (prefs.containsKey(_keyDarkMode)) {
        darkVal = prefs.getBool(_keyDarkMode);
      }
      final fontVal = prefs.getDouble(_keyFontSize) ?? 13.0;
      final wrapVal = prefs.getBool(_keyWordWrap) ?? true;
      final linesVal = prefs.getBool(_keyLineNumbers) ?? true;

      _settings = IdeSettings(
        forceDarkMode: darkVal,
        fontSize: fontVal,
        wordWrap: wrapVal,
        showLineNumbers: linesVal,
      );
      notifyListeners();
    } catch (e) {
      print('[IdeSettingsService] Error loading settings: $e');
    }
  }

  Future<void> updateSettings(IdeSettings newSettings) async {
    _settings = newSettings;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      if (newSettings.forceDarkMode == null) {
        await prefs.remove(_keyDarkMode);
      } else {
        await prefs.setBool(_keyDarkMode, newSettings.forceDarkMode!);
      }
      await prefs.setDouble(_keyFontSize, newSettings.fontSize);
      await prefs.setBool(_keyWordWrap, newSettings.wordWrap);
      await prefs.setBool(_keyLineNumbers, newSettings.showLineNumbers);
    } catch (e) {
      print('[IdeSettingsService] Error saving settings: $e');
    }
  }
}
