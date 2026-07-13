import 'dart:convert';
import 'package:duofy/services/generation_manager.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../services/fb/fb_auth.dart';
import '../services/global_state.dart';
import '../services/database_service.dart';
import '../services/secrets_service.dart';
import '../services/usage_limit_service.dart';
import '../theme/app_theme.dart';
import '../widgets/daily_goal_card.dart';
import '../widgets/duo_button.dart';
import '../widgets/learner_profile_card.dart';
import '../widgets/string_list_manager.dart';
import '../widgets/responsive_center.dart';

import '../models/app_models.dart';
import 'pdf_browser_screen.dart';
import 'metacognition_setup_screen.dart';
import 'ai_queue_screen.dart';
import 'experiments_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _keys = [];
  String _selectedCategory = 'general';
  List<String> _models = [];
  // Each slot is now an ordered list — the first model is tried first, the
  // next is the fallback, and so on. Empty list means "use the built-in
  // default" but the UI keeps at least one entry to avoid that state.
  List<String> _modelPrimaryText = [
    'gemini-flash-lite-latest',
    'gemini-2.5-flash-lite',
    'gemma-4-26b-a4b-it',
    'gemma-4-31b-it',
  ];
  List<String> _modelPrimaryGraphics = [
    'gemini-3.5-flash',
    'gemini-3-flash-preview',
    'gemini-2.5-flash',
    'gemma-4-31b-it',
  ];
  List<String> _modelLite = [
    'gemini-flash-lite-latest',
    'gemini-3.1-flash-lite',
    'gemini-3.1-flash-lite-preview',
    'gemini-2.5-flash-lite',
    'gemma-4-26b-a4b-it',
    'gemini-2.0-flash-lite',
  ];
  List<String> _modelLive = ['gemini-3.1-flash-live-preview'];

  /// How many lesson requests to fire in parallel during generation.
  /// 'auto' lets the app pick from the device's capacity; otherwise a fixed
  /// count string ('1'..'4'). Read by AiService via the `gen_concurrency` pref.
  String _genConcurrency = 'auto';
  TimeOfDay _scheduleStart = const TimeOfDay(hour: 21, minute: 0);
  TimeOfDay _scheduleEnd = const TimeOfDay(hour: 9, minute: 0);

  /// Local-first: cloud backup/sync is opt-in. Mirrors
  /// [DatabaseService.cloudSyncPrefKey].
  bool _cloudSync = false;
  bool _isSyncing = false;
  bool _isLoading = true;
  bool _autoFetchBooks = true;
  bool _autoVerifyMappings = true;
  bool _autoGenerateModule1 = true;
  int? _lastSyncTime;
  final GlobalKey<StringListManagerState> _keysManagerKey =
      GlobalKey<StringListManagerState>();
  List<String> _groqKeys = [];
  List<String> _groqModelPrimaryText = [
    'llama-3.3-70b-versatile',
    'groq/compound',
  ];
  List<String> _groqModelPrimaryGraphics = [
    'llama-3.3-70b-versatile',
    'groq/compound',
  ];
  List<String> _groqModelLite = [
    'llama-3.1-8b-instant',
    'groq/compound-mini',
  ];
  List<String> _groqModelLive = [
    'llama-3.1-8b-instant',
    'groq/compound-mini',
  ];
  final GlobalKey<StringListManagerState> _groqKeysManagerKey =
      GlobalKey<StringListManagerState>();

  List<String> _cerebrasKeys = [];
  List<String> _cerebrasModelPrimaryText = [
    'llama-3.3-70b',
    'llama-3.1-70b',
  ];
  List<String> _cerebrasModelPrimaryGraphics = [
    'llama-3.3-70b',
    'llama-3.1-70b',
  ];
  List<String> _cerebrasModelLite = [
    'llama-3.1-8b',
  ];
  List<String> _cerebrasModelLive = [
    'llama-3.1-8b',
  ];
  final GlobalKey<StringListManagerState> _cerebrasKeysManagerKey =
      GlobalKey<StringListManagerState>();

  List<String> _openrouterKeys = [];
  List<String> _openrouterModelPrimaryText = [
    'meta-llama/llama-3.3-70b-instruct',
    'google/gemini-2.5-pro',
  ];
  List<String> _openrouterModelPrimaryGraphics = [
    'meta-llama/llama-3.3-70b-instruct',
    'google/gemini-2.5-pro',
  ];
  List<String> _openrouterModelLite = [
    'meta-llama/llama-3.1-8b-instruct',
    'google/gemini-2.5-flash',
  ];
  List<String> _openrouterModelLive = [
    'meta-llama/llama-3.1-8b-instruct',
    'google/gemini-2.5-flash',
  ];
  final GlobalKey<StringListManagerState> _openrouterKeysManagerKey =
      GlobalKey<StringListManagerState>();

  final DatabaseService _db = DatabaseService();
  final TextEditingController _customPromptController = TextEditingController();
  Map<String, dynamic>? _writingStyleProfile;

  final user = FbAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _customPromptController.dispose();
    super.dispose();
  }

  /// (uses the supplied default list when nothing is stored).
  Future<List<String>> _loadModelList(
    SharedPreferences prefs,
    String listKey,
    String legacyScalarKey,
    List<String> defaultList,
  ) async {
    final list = prefs.getStringList(listKey) ?? [];
    if (list.isNotEmpty) return list;
    final scalar = prefs.getString(legacyScalarKey);
    if (scalar != null && scalar.trim().isNotEmpty) return [scalar.trim()];
    return defaultList;
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    _cloudSync = await _db.isCloudEnabled();

    List<String> keys = prefs.getStringList('gemini_api_keys_list') ?? [];
    if (keys.isEmpty) {
      final keysString = prefs.getString('gemini_api_keys') ?? '';
      keys = keysString
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }

    // Legacy generic-models list. No UI binds to it anymore — the three
    // slots (Text / Graphics / Lite) own their own fallback ladders. We
    // still round-trip whatever the user previously had so we don't lose
    // it, but we no longer inject a hardcoded default (which used to be
    // gemini-1.5-flash and silently poisoned the ladder).
    List<String> models = prefs.getStringList('gemini_models_list') ?? [];

    List<String> primaryText = await _loadModelList(
      prefs,
      'model_primary_text_list',
      'model_primary_text',
      const [
        'gemini-flash-lite-latest',
        'gemini-2.5-flash-lite',
        'gemma-4-26b-a4b-it',
        'gemma-4-31b-it',
      ],
    );
    List<String> primaryGraphics = await _loadModelList(
      prefs,
      'model_primary_graphics_list',
      'model_primary_graphics',
      const [
        'gemini-3.5-flash',
        'gemini-3-flash-preview',
        'gemini-2.5-flash',
        'gemma-4-31b-it',
      ],
    );
    List<String> lite =
        await _loadModelList(prefs, 'model_lite_list', 'model_lite', const [
          'gemini-flash-lite-latest',
          'gemini-3.1-flash-lite',
          'gemini-3.1-flash-lite-preview',
          'gemini-2.5-flash-lite',
          'gemma-4-26b-a4b-it',
          'gemini-2.0-flash-lite',
        ]);
    List<String> live = await _loadModelList(
      prefs,
      'model_live_list',
      'model_live',
      const ['gemini-3.1-flash-live-preview'],
    );

    List<String> groqKeys = prefs.getStringList('groq_api_keys_list') ?? [];
    if (groqKeys.isEmpty) {
      final keysString = prefs.getString('groq_api_keys') ?? '';
      groqKeys = keysString
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    List<String> groqPT = await _loadModelList(
      prefs,
      'groq_model_primary_text_list',
      'groq_model_primary_text',
      const ['llama-3.3-70b-versatile', 'groq/compound'],
    );
    List<String> groqPG = await _loadModelList(
      prefs,
      'groq_model_primary_graphics_list',
      'groq_model_primary_graphics',
      const ['llama-3.3-70b-versatile', 'groq/compound'],
    );
    List<String> groqLite = await _loadModelList(
      prefs,
      'groq_model_lite_list',
      'groq_model_lite',
      const ['llama-3.1-8b-instant', 'groq/compound-mini'],
    );
    List<String> groqLive = await _loadModelList(
      prefs,
      'groq_model_live_list',
      'groq_model_live',
      const ['llama-3.1-8b-instant', 'groq/compound-mini'],
    );

    List<String> cerebrasKeys = prefs.getStringList('cerebras_api_keys_list') ?? [];
    if (cerebrasKeys.isEmpty) {
      final keysString = prefs.getString('cerebras_api_keys') ?? '';
      cerebrasKeys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    List<String> cerebrasPT = await _loadModelList(
      prefs,
      'cerebras_model_primary_text_list',
      'cerebras_model_primary_text',
      const ['llama-3.3-70b', 'llama-3.1-70b'],
    );
    List<String> cerebrasPG = await _loadModelList(
      prefs,
      'cerebras_model_primary_graphics_list',
      'cerebras_model_primary_graphics',
      const ['llama-3.3-70b', 'llama-3.1-70b'],
    );
    List<String> cerebrasLite = await _loadModelList(
      prefs,
      'cerebras_model_lite_list',
      'cerebras_model_lite',
      const ['llama-3.1-8b'],
    );
    List<String> cerebrasLive = await _loadModelList(
      prefs,
      'cerebras_model_live_list',
      'cerebras_model_live',
      const ['llama-3.1-8b'],
    );

    List<String> openrouterKeys = prefs.getStringList('openrouter_api_keys_list') ?? [];
    if (openrouterKeys.isEmpty) {
      final keysString = prefs.getString('openrouter_api_keys') ?? '';
      openrouterKeys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    List<String> openrouterPT = await _loadModelList(
      prefs,
      'openrouter_model_primary_text_list',
      'openrouter_model_primary_text',
      const ['meta-llama/llama-3.3-70b-instruct', 'google/gemini-2.5-pro'],
    );
    List<String> openrouterPG = await _loadModelList(
      prefs,
      'openrouter_model_primary_graphics_list',
      'openrouter_model_primary_graphics',
      const ['meta-llama/llama-3.3-70b-instruct', 'google/gemini-2.5-pro'],
    );
    List<String> openrouterLite = await _loadModelList(
      prefs,
      'openrouter_model_lite_list',
      'openrouter_model_lite',
      const ['meta-llama/llama-3.1-8b-instruct', 'google/gemini-2.5-flash'],
    );
    List<String> openrouterLive = await _loadModelList(
      prefs,
      'openrouter_model_live_list',
      'openrouter_model_live',
      const ['meta-llama/llama-3.1-8b-instruct', 'google/gemini-2.5-flash'],
    );

    // Hydrate from Firestore if local is empty.
    if (keys.isEmpty || models.isEmpty || groqKeys.isEmpty || cerebrasKeys.isEmpty || openrouterKeys.isEmpty) {
      final remote = await _db.fetchUserSettings();
      if (remote != null) {
        if (keys.isEmpty &&
            remote['apiKeys'] != null &&
            (remote['apiKeys'] as List).isNotEmpty) {
          keys = List<String>.from(remote['apiKeys']!);
          await prefs.setStringList('gemini_api_keys_list', keys);
        }
        if (models.isEmpty &&
            remote['models'] != null &&
            (remote['models'] as List).isNotEmpty) {
          models = List<String>.from(remote['models']!);
          await prefs.setStringList('gemini_models_list', models);
        }
        // Each *List remote key returns a (possibly empty) list. Adopt it
        // only when non-empty so we don\'t clobber the local default.
        final remotePT = remote['modelPrimaryTextList'] as List? ?? const [];
        if (remotePT.isNotEmpty) {
          primaryText = List<String>.from(remotePT);
          await prefs.setStringList('model_primary_text_list', primaryText);
        }
        final remotePG =
            remote['modelPrimaryGraphicsList'] as List? ?? const [];
        if (remotePG.isNotEmpty) {
          primaryGraphics = List<String>.from(remotePG);
          await prefs.setStringList(
            'model_primary_graphics_list',
            primaryGraphics,
          );
        }
        final remoteLite = remote['modelLiteList'] as List? ?? const [];
        if (remoteLite.isNotEmpty) {
          lite = List<String>.from(remoteLite);
          await prefs.setStringList('model_lite_list', lite);
        }
        final remoteLive = remote['modelLiveList'] as List? ?? const [];
        if (remoteLive.isNotEmpty) {
          live = List<String>.from(remoteLive);
          await prefs.setStringList('model_live_list', live);
        }
        if (groqKeys.isEmpty &&
            remote['groqApiKeys'] != null &&
            (remote['groqApiKeys'] as List).isNotEmpty) {
          groqKeys = List<String>.from(remote['groqApiKeys']!);
          await prefs.setStringList('groq_api_keys_list', groqKeys);
        }
        final remoteGroqPT = remote['groqModelPrimaryTextList'] as List? ?? const [];
        if (remoteGroqPT.isNotEmpty) {
          groqPT = List<String>.from(remoteGroqPT);
          await prefs.setStringList('groq_model_primary_text_list', groqPT);
        }
        final remoteGroqPG = remote['groqModelPrimaryGraphicsList'] as List? ?? const [];
        if (remoteGroqPG.isNotEmpty) {
          groqPG = List<String>.from(remoteGroqPG);
          await prefs.setStringList('groq_model_primary_graphics_list', groqPG);
        }
        final remoteGroqLite = remote['groqModelLiteList'] as List? ?? const [];
        if (remoteGroqLite.isNotEmpty) {
          groqLite = List<String>.from(remoteGroqLite);
          await prefs.setStringList('groq_model_lite_list', groqLite);
        }
        final remoteGroqLive = remote['groqModelLiveList'] as List? ?? const [];
        if (remoteGroqLive.isNotEmpty) {
          groqLive = List<String>.from(remoteGroqLive);
          await prefs.setStringList('groq_model_live_list', groqLive);
        }

        if (cerebrasKeys.isEmpty &&
            remote['cerebrasApiKeys'] != null &&
            (remote['cerebrasApiKeys'] as List).isNotEmpty) {
          cerebrasKeys = List<String>.from(remote['cerebrasApiKeys']!);
          await prefs.setStringList('cerebras_api_keys_list', cerebrasKeys);
        }
        final remoteCerebrasPT = remote['cerebrasModelPrimaryTextList'] as List? ?? const [];
        if (remoteCerebrasPT.isNotEmpty) {
          cerebrasPT = List<String>.from(remoteCerebrasPT);
          await prefs.setStringList('cerebras_model_primary_text_list', cerebrasPT);
        }
        final remoteCerebrasPG = remote['cerebrasModelPrimaryGraphicsList'] as List? ?? const [];
        if (remoteCerebrasPG.isNotEmpty) {
          cerebrasPG = List<String>.from(remoteCerebrasPG);
          await prefs.setStringList('cerebras_model_primary_graphics_list', cerebrasPG);
        }
        final remoteCerebrasLite = remote['cerebrasModelLiteList'] as List? ?? const [];
        if (remoteCerebrasLite.isNotEmpty) {
          cerebrasLite = List<String>.from(remoteCerebrasLite);
          await prefs.setStringList('cerebras_model_lite_list', cerebrasLite);
        }
        final remoteCerebrasLive = remote['cerebrasModelLiveList'] as List? ?? const [];
        if (remoteCerebrasLive.isNotEmpty) {
          cerebrasLive = List<String>.from(remoteCerebrasLive);
          await prefs.setStringList('cerebras_model_live_list', cerebrasLive);
        }

        if (openrouterKeys.isEmpty &&
            remote['openrouterApiKeys'] != null &&
            (remote['openrouterApiKeys'] as List).isNotEmpty) {
          openrouterKeys = List<String>.from(remote['openrouterApiKeys']!);
          await prefs.setStringList('openrouter_api_keys_list', openrouterKeys);
        }
        final remoteOpenrouterPT = remote['openrouterModelPrimaryTextList'] as List? ?? const [];
        if (remoteOpenrouterPT.isNotEmpty) {
          openrouterPT = List<String>.from(remoteOpenrouterPT);
          await prefs.setStringList('openrouter_model_primary_text_list', openrouterPT);
        }
        final remoteOpenrouterPG = remote['openrouterModelPrimaryGraphicsList'] as List? ?? const [];
        if (remoteOpenrouterPG.isNotEmpty) {
          openrouterPG = List<String>.from(remoteOpenrouterPG);
          await prefs.setStringList('openrouter_model_primary_graphics_list', openrouterPG);
        }
        final remoteOpenrouterLite = remote['openrouterModelLiteList'] as List? ?? const [];
        if (remoteOpenrouterLite.isNotEmpty) {
          openrouterLite = List<String>.from(remoteOpenrouterLite);
          await prefs.setStringList('openrouter_model_lite_list', openrouterLite);
        }
        final remoteOpenrouterLive = remote['openrouterModelLiveList'] as List? ?? const [];
        if (remoteOpenrouterLive.isNotEmpty) {
          openrouterLive = List<String>.from(remoteOpenrouterLive);
          await prefs.setStringList('openrouter_model_live_list', openrouterLive);
        }
      }
    }

    _keys = List.from(keys);
    _models = List.from(models);
    _modelPrimaryText = primaryText;
    _modelPrimaryGraphics = primaryGraphics;
    _modelLite = lite;
    _modelLive = live;
    _groqKeys = List.from(groqKeys);
    _groqModelPrimaryText = groqPT;
    _groqModelPrimaryGraphics = groqPG;
    _groqModelLite = groqLite;
    _groqModelLive = groqLive;
    _cerebrasKeys = List.from(cerebrasKeys);
    _cerebrasModelPrimaryText = cerebrasPT;
    _cerebrasModelPrimaryGraphics = cerebrasPG;
    _cerebrasModelLite = cerebrasLite;
    _cerebrasModelLive = cerebrasLive;
    _openrouterKeys = List.from(openrouterKeys);
    _openrouterModelPrimaryText = openrouterPT;
    _openrouterModelPrimaryGraphics = openrouterPG;
    _openrouterModelLite = openrouterLite;
    _openrouterModelLive = openrouterLive;
    _genConcurrency = prefs.getString('gen_concurrency') ?? 'auto';
    final startHour = prefs.getInt('schedule_start_hour') ?? 21;
    final startMinute = prefs.getInt('schedule_start_minute') ?? 0;
    final endHour = prefs.getInt('schedule_end_hour') ?? 9;
    final endMinute = prefs.getInt('schedule_end_minute') ?? 0;
    _scheduleStart = TimeOfDay(hour: startHour, minute: startMinute);
    _scheduleEnd = TimeOfDay(hour: endHour, minute: endMinute);
    _lastSyncTime = prefs.getInt('last_db_sync_time');
    _customPromptController.text =
        prefs.getString('custom_live_chat_prompt') ?? '';
    _autoFetchBooks = prefs.getBool('auto_fetch_books') ?? true;
    _autoVerifyMappings = prefs.getBool('auto_verify_mappings') ?? true;
    _autoGenerateModule1 = prefs.getBool('auto_generate_module_1') ?? true;

    final String? profileStr = prefs.getString('user_writing_style_profile');
    if (profileStr != null) {
      try {
        _writingStyleProfile = jsonDecode(profileStr) as Map<String, dynamic>;
      } catch (e) {
        print('Error decoding style profile: $e');
      }
    } else {
      _writingStyleProfile = null;
    }

    setState(() {
      _isLoading = false;
    });
  }

  String formatTime(int? ts) {
    if (ts == null || ts == 0) return 'Unknown';
    final dt = DateTime.fromMillisecondsSinceEpoch(ts);
    final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final minute = dt.minute.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    return '${dt.year}-$month-$day $hour:$minute $period';
  }

  Future<void> _triggerQuickSync() async {
    setState(() {
      _isSyncing = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      await _db.fetchBooks(forceRefresh: true);
      final now = DateTime.now().millisecondsSinceEpoch;
      await prefs.setInt('last_db_sync_time', now);
      setState(() {
        _lastSyncTime = now;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sync completed successfully.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Sync failed: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
      }
    }
  }

  Future<void> _saveSettings() async {
    // Commit any pending text in the API-key input field before reading the list.
    _keysManagerKey.currentState?.commitPending();
    _groqKeysManagerKey.currentState?.commitPending();
    _cerebrasKeysManagerKey.currentState?.commitPending();
    _openrouterKeysManagerKey.currentState?.commitPending();

    final prefs = await SharedPreferences.getInstance();
    final keysSaved = await prefs.setStringList('gemini_api_keys_list', _keys);
    final modelsSaved = await prefs.setStringList(
      'gemini_models_list',
      _models,
    );
    final pTextSaved = await prefs.setStringList(
      'model_primary_text_list',
      _modelPrimaryText,
    );
    final pGraphicsSaved = await prefs.setStringList(
      'model_primary_graphics_list',
      _modelPrimaryGraphics,
    );
    final liteSaved = await prefs.setStringList('model_lite_list', _modelLite);
    final liveSaved = await prefs.setStringList('model_live_list', _modelLive);

    final groqKeysSaved = await prefs.setStringList('groq_api_keys_list', _groqKeys);
    final groqPT = await prefs.setStringList('groq_model_primary_text_list', _groqModelPrimaryText);
    final groqPG = await prefs.setStringList('groq_model_primary_graphics_list', _groqModelPrimaryGraphics);
    final groqLite = await prefs.setStringList('groq_model_lite_list', _groqModelLite);
    final groqLive = await prefs.setStringList('groq_model_live_list', _groqModelLive);

    final cerebrasKeysSaved = await prefs.setStringList('cerebras_api_keys_list', _cerebrasKeys);
    final cerebrasPT = await prefs.setStringList('cerebras_model_primary_text_list', _cerebrasModelPrimaryText);
    final cerebrasPG = await prefs.setStringList('cerebras_model_primary_graphics_list', _cerebrasModelPrimaryGraphics);
    final cerebrasLite = await prefs.setStringList('cerebras_model_lite_list', _cerebrasModelLite);
    final cerebrasLive = await prefs.setStringList('cerebras_model_live_list', _cerebrasModelLive);

    final openrouterKeysSaved = await prefs.setStringList('openrouter_api_keys_list', _openrouterKeys);
    final openrouterPT = await prefs.setStringList('openrouter_model_primary_text_list', _openrouterModelPrimaryText);
    final openrouterPG = await prefs.setStringList('openrouter_model_primary_graphics_list', _openrouterModelPrimaryGraphics);
    final openrouterLite = await prefs.setStringList('openrouter_model_lite_list', _openrouterModelLite);
    final openrouterLive = await prefs.setStringList('openrouter_model_live_list', _openrouterModelLive);

    await prefs.setString('gen_concurrency', _genConcurrency);
    await prefs.setInt('schedule_start_hour', _scheduleStart.hour);
    await prefs.setInt('schedule_start_minute', _scheduleStart.minute);
    await prefs.setInt('schedule_end_hour', _scheduleEnd.hour);
    await prefs.setInt('schedule_end_minute', _scheduleEnd.minute);
    await prefs.setString(
      'custom_live_chat_prompt',
      _customPromptController.text.trim(),
    );
    await prefs.setBool('auto_fetch_books', _autoFetchBooks);
    await prefs.setBool('auto_verify_mappings', _autoVerifyMappings);
    await prefs.setBool('auto_generate_module_1', _autoGenerateModule1);
    await _db.setCloudEnabled(_cloudSync);

    // Mirror the head of each list back into the legacy scalar key so other
    // code paths still relying on it (older app versions, tests) keep
    // working without a follow-up migration.
    if (_modelPrimaryText.isNotEmpty)
      await prefs.setString('model_primary_text', _modelPrimaryText.first);
    if (_modelPrimaryGraphics.isNotEmpty)
      await prefs.setString(
        'model_primary_graphics',
        _modelPrimaryGraphics.first,
      );
    if (_modelLite.isNotEmpty)
      await prefs.setString('model_lite', _modelLite.first);
    if (_modelLive.isNotEmpty)
      await prefs.setString('model_live', _modelLive.first);

    if (_groqModelPrimaryText.isNotEmpty)
      await prefs.setString('groq_model_primary_text', _groqModelPrimaryText.first);
    if (_groqModelPrimaryGraphics.isNotEmpty)
      await prefs.setString('groq_model_primary_graphics', _groqModelPrimaryGraphics.first);
    if (_groqModelLite.isNotEmpty)
      await prefs.setString('groq_model_lite', _groqModelLite.first);
    if (_groqModelLive.isNotEmpty)
      await prefs.setString('groq_model_live', _groqModelLive.first);

    if (_cerebrasModelPrimaryText.isNotEmpty)
      await prefs.setString('cerebras_model_primary_text', _cerebrasModelPrimaryText.first);
    if (_cerebrasModelPrimaryGraphics.isNotEmpty)
      await prefs.setString('cerebras_model_primary_graphics', _cerebrasModelPrimaryGraphics.first);
    if (_cerebrasModelLite.isNotEmpty)
      await prefs.setString('cerebras_model_lite', _cerebrasModelLite.first);
    if (_cerebrasModelLive.isNotEmpty)
      await prefs.setString('cerebras_model_live', _cerebrasModelLive.first);

    if (_openrouterModelPrimaryText.isNotEmpty)
      await prefs.setString('openrouter_model_primary_text', _openrouterModelPrimaryText.first);
    if (_openrouterModelPrimaryGraphics.isNotEmpty)
      await prefs.setString('openrouter_model_primary_graphics', _openrouterModelPrimaryGraphics.first);
    if (_openrouterModelLite.isNotEmpty)
      await prefs.setString('openrouter_model_lite', _openrouterModelLite.first);
    if (_openrouterModelLive.isNotEmpty)
      await prefs.setString('openrouter_model_live', _openrouterModelLive.first);

    if (!keysSaved ||
        !modelsSaved ||
        !pTextSaved ||
        !pGraphicsSaved ||
        !liteSaved ||
        !liveSaved ||
        !groqKeysSaved ||
        !groqPT ||
        !groqPG ||
        !groqLite ||
        !groqLive ||
        !cerebrasKeysSaved ||
        !cerebrasPT ||
        !cerebrasPG ||
        !cerebrasLite ||
        !cerebrasLive ||
        !openrouterKeysSaved ||
        !openrouterPT ||
        !openrouterPG ||
        !openrouterLite ||
        !openrouterLive) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Local save failed — syncing to cloud only.'),
          ),
        );
      }
    }

    await _db.saveUserSettings(
      apiKeys: _keys,
      models: _models,
      modelPrimaryTextList: _modelPrimaryText,
      modelPrimaryGraphicsList: _modelPrimaryGraphics,
      modelLiteList: _modelLite,
      modelLiveList: _modelLive,
      groqApiKeys: _groqKeys,
      groqModelPrimaryTextList: _groqModelPrimaryText,
      groqModelPrimaryGraphicsList: _groqModelPrimaryGraphics,
      groqModelLiteList: _groqModelLite,
      groqModelLiveList: _groqModelLive,
      cerebrasApiKeys: _cerebrasKeys,
      cerebrasModelPrimaryTextList: _cerebrasModelPrimaryText,
      cerebrasModelPrimaryGraphicsList: _cerebrasModelPrimaryGraphics,
      cerebrasModelLiteList: _cerebrasModelLite,
      cerebrasModelLiveList: _cerebrasModelLive,
      openrouterApiKeys: _openrouterKeys,
      openrouterModelPrimaryTextList: _openrouterModelPrimaryText,
      openrouterModelPrimaryGraphicsList: _openrouterModelPrimaryGraphics,
      openrouterModelLiteList: _openrouterModelLite,
      openrouterModelLiveList: _openrouterModelLive,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved ${_keys.length} key(s) and assigned models.'),
        ),
      );
      Navigator.pop(context);
    }
  }

  /// Fetches the list of models available to the current API key. Mixed
  /// remote response + the hard-coded model names we want to keep
  /// discoverable even when the API doesn\'t list them.
  Future<List<String>> _fetchAvailableModels() async {
    final response = await http.get(
      Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models?key=${_keys.first}',
      ),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch: ${response.statusCode}');
    }
    final data = jsonDecode(response.body);
    final List fetched = data['models'] ?? [];
    final List<String> fetchedModels = [];
    for (var m in fetched) {
      String name = m['name'];
      if (name.startsWith('models/')) name = name.substring(7);
      if (name.contains('gemini') || name.contains('gemma'))
        fetchedModels.add(name);
    }
    for (final id in const [
      'gemma4',
      'gemini-3.5-flash',
      'gemini-3-flash-preview',
      'gemini-2.5-flash',
      'gemini-3.1-flash-live-preview',
      'gemini-flash-lite-latest',
      'gemini-3.1-flash-lite',
      'gemini-3.1-flash-lite-preview',
      'gemini-2.5-flash-lite',
      'gemini-2.0-flash-lite',
      'gemma-4-31b-it',
      'gemma-4-26b-a4b-it',
    ]) {
      if (!fetchedModels.contains(id)) fetchedModels.add(id);
    }
    fetchedModels.sort((a, b) {
      int rank(String n) {
        if (n.startsWith('gemma-4') || n == 'gemma4') return 0;
        if (n.startsWith('gemini-3') || n.startsWith('gemini-2')) return 1;
        if (n.startsWith('gemini')) return 2;
        if (n.startsWith('gemma')) return 3;
        return 4;
      }

      final r = rank(a).compareTo(rank(b));
      return r != 0 ? r : a.compareTo(b);
    });
    return fetchedModels;
  }

  Future<void> _addModelToSlot(String slotName) async {
    final isGroq = slotName.startsWith('Groq');
    final isCerebras = slotName.startsWith('Cerebras');
    final isOpenRouter = slotName.startsWith('OpenRouter');
    final isGemini = !isGroq && !isCerebras && !isOpenRouter;

    if (isGemini && _keys.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add an API key first.')),
      );
      return;
    }
    List<String> fetched;
    if (isGroq) {
      fetched = const [
        'llama-3.3-70b-versatile',
        'llama-3.1-8b-instant',
        'groq/compound',
        'groq/compound-mini',
      ];
    } else if (isCerebras) {
      fetched = const [
        'llama-3.3-70b',
        'llama-3.1-70b',
        'llama-3.1-8b',
      ];
    } else if (isOpenRouter) {
      fetched = const [
        'meta-llama/llama-3.3-70b-instruct',
        'meta-llama/llama-3.1-8b-instruct',
        'google/gemini-2.5-pro',
        'google/gemini-2.5-flash',
        'google/gemma-2-9b-it:free',
      ];
    } else {
      try {
        fetched = await _fetchAvailableModels();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
        return;
      }
    }
    if (!mounted || fetched.isEmpty) return;

    final List<String> current = _listForSlot(slotName);
    await showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Fallback Model for $slotName',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Models are tried in the order you list them. The first one that succeeds wins.',
              style: TextStyle(color: context.colors.textFaint, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: fetched.length,
                itemBuilder: (c, i) {
                  final name = fetched[i];
                  final alreadyIn = current.contains(name);
                  return ListTile(
                    leading: Icon(
                      alreadyIn ? LucideIcons.checkCircle : LucideIcons.bot,
                      color: alreadyIn ? AppTheme.duoGreen : AppTheme.duoBlue,
                    ),
                    title: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    subtitle: alreadyIn
                        ? Text(
                            'Already in this slot',
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontSize: 11,
                            ),
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        final list = _listForSlot(slotName);
                        // Bump to the end if re-added so user can reorder by
                        // re-picking, then dedupe.
                        list.remove(name);
                        list.add(name);
                      });
                      Navigator.pop(ctx);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _listForSlot(String slotName) {
    switch (slotName) {
      case 'Primary - Text':
        return _modelPrimaryText;
      case 'Primary - Graphics':
        return _modelPrimaryGraphics;
      case 'Lite':
        return _modelLite;
      case 'Live':
        return _modelLive;
      case 'Groq - Primary - Text':
        return _groqModelPrimaryText;
      case 'Groq - Primary - Graphics':
        return _groqModelPrimaryGraphics;
      case 'Groq - Lite':
        return _groqModelLite;
      case 'Groq - Live':
        return _groqModelLive;
      case 'Cerebras - Primary - Text':
        return _cerebrasModelPrimaryText;
      case 'Cerebras - Primary - Graphics':
        return _cerebrasModelPrimaryGraphics;
      case 'Cerebras - Lite':
        return _cerebrasModelLite;
      case 'Cerebras - Live':
        return _cerebrasModelLive;
      case 'OpenRouter - Primary - Text':
        return _openrouterModelPrimaryText;
      case 'OpenRouter - Primary - Graphics':
        return _openrouterModelPrimaryGraphics;
      case 'OpenRouter - Lite':
        return _openrouterModelLite;
      case 'OpenRouter - Live':
        return _openrouterModelLive;
      default:
        return [];
    }
  }

  void _reorderSlot(String slotName, int oldIndex, int newIndex) {
    setState(() {
      final list = _listForSlot(slotName);
      if (newIndex > oldIndex) newIndex -= 1;
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }

  void _removeFromSlot(String slotName, int index) {
    setState(() {
      final list = _listForSlot(slotName);
      if (list.length <= 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Need at least one model per slot.')),
        );
        return;
      }
      list.removeAt(index);
    });
  }

  Widget _buildModelSlotCard({
    required String title,
    required String subtitle,
    required String slotName,
    required IconData icon,
  }) {
    final List<String> models = _listForSlot(slotName);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.duoBlue, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () => _addModelToSlot(slotName),
                icon: const Icon(
                  LucideIcons.plus,
                  size: 14,
                  color: AppTheme.duoBlue,
                ),
                label: const Text(
                  'Add fallback',
                  style: TextStyle(
                    color: AppTheme.duoBlue,
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Ordered fallback ladder. Drag the handle to change priority,
          // tap the trash to remove (at least one entry required).
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            itemCount: models.length,
            onReorder: (oldIndex, newIndex) =>
                _reorderSlot(slotName, oldIndex, newIndex),
            itemBuilder: (context, i) {
              final m = models[i];
              final isPrimary = i == 0;
              return Container(
                key: ValueKey('${slotName}_$i'),
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: context.colors.shadow,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isPrimary
                        ? AppTheme.duoBlue.withOpacity(0.6)
                        : context.colors.outline,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isPrimary
                            ? AppTheme.duoBlue
                            : context.colors.outline,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          color: isPrimary
                              ? context.colors.textPrimary
                              : context.colors.textSecondary,
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        m,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: isPrimary
                              ? Colors.amber
                              : context.colors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (models.length > 1)
                      IconButton(
                        icon: Icon(
                          LucideIcons.trash2,
                          size: 16,
                          color: context.colors.textFaint,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        onPressed: () => _removeFromSlot(slotName, i),
                      ),
                    ReorderableDragStartListener(
                      index: i,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          LucideIcons.gripVertical,
                          size: 16,
                          color: context.colors.textFaint,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUsageLimitsSection() {
    final activeGemini = {
      if (_modelPrimaryText.isNotEmpty) _modelPrimaryText.first,
      if (_modelPrimaryGraphics.isNotEmpty) _modelPrimaryGraphics.first,
      if (_modelLite.isNotEmpty) _modelLite.first,
      if (_modelLive.isNotEmpty) _modelLive.first,
    };
    if (activeGemini.isEmpty) {
      activeGemini.addAll(['gemini-3.5-flash', 'gemini-flash-lite-latest', 'gemini-3.1-flash-live-preview']);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.activity, color: AppTheme.duoBlue, size: 24),
              const SizedBox(width: 12),
              Text(
                'API Usage Limits',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              Text(
                '${UsageLimitService.instance.dailyActiveUsers} Active User(s)',
                style: TextStyle(
                  color: context.colors.textFaint,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Daily usage limits are calculated based on daily active users sharing the free keys. Add your own key to bypass limits.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 11),
          ),
          const SizedBox(height: 16),
          ...activeGemini.map((model) {
            return FutureBuilder<int>(
              future: UsageLimitService.instance.getUsage(model),
              builder: (context, snapshot) {
                final usage = snapshot.data ?? 0;
                final limit = UsageLimitService.instance.getLimit(model);
                final double percent = limit > 0 ? (usage / limit).clamp(0.0, 1.0) : 0.0;
                final isLimitHit = usage >= limit;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model,
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$usage / $limit reqs',
                            style: TextStyle(
                              color: isLimitHit ? AppTheme.duoRed : context.colors.textFaint,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percent,
                          backgroundColor: context.colors.outline,
                          color: isLimitHit ? AppTheme.duoRed : AppTheme.duoBlue,
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
          FutureBuilder<bool>(
            future: UsageLimitService.instance.areAllLimitsHit(activeGemini.toList()),
            builder: (context, snapshot) {
              final allHit = snapshot.data ?? false;
              if (allHit) {
                return Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.duoRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.duoRed.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'All limits reached! Please add your own API key to restore service.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.duoRed,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (!GlobalState.developerModeNotifier.value)
                        DuoButton(
                          text: 'Add API Key',
                          onPressed: () {
                            setState(() {
                              GlobalState.developerModeNotifier.value = true;
                              _selectedCategory = 'advanced';
                            });
                          },
                          color: AppTheme.duoBlue,
                          shadowColor: AppTheme.duoBlueDark,
                          isOutline: true,
                        ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCloudSyncCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _cloudSync
              ? AppTheme.duoBlue.withOpacity(0.5)
              : context.colors.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _cloudSync ? LucideIcons.cloud : LucideIcons.cloudOff,
                color: _cloudSync ? AppTheme.duoBlue : context.colors.textFaint,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Cloud Backup & Sync',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              Switch(
                value: _cloudSync,
                activeColor: AppTheme.duoBlue,
                onChanged: _isGuest
                    ? null
                    : (v) async {
                        setState(() => _cloudSync = v);
                        // Persist immediately so a refresh elsewhere honours it
                        // even before "Save Settings" is tapped.
                        await _db.setCloudEnabled(v);
                      },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _isGuest
                ? 'Sign in to back up your courses to the cloud. Everything is currently stored on this device.'
                : _cloudSync
                ? 'Your courses and settings are backed up to your account and synced across devices. Local storage stays the source of truth.'
                : 'Off — courses are stored only on this device (no network used). Turn on to back up and sync across devices, and to publish to the community.',
            style: TextStyle(
              color: context.colors.textFaint,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          if (_cloudSync && !_isGuest) ...[
            const SizedBox(height: 16),
            Divider(color: context.colors.outline, height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LAST SYNCED',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _lastSyncTime == null || _lastSyncTime == 0
                          ? 'Never synced'
                          : formatTime(_lastSyncTime),
                      style: TextStyle(
                        color: context.colors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _isSyncing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppTheme.duoBlue,
                        ),
                      )
                    : TextButton.icon(
                        onPressed: _triggerQuickSync,
                        icon: const Icon(
                          LucideIcons.refreshCw,
                          size: 14,
                          color: AppTheme.duoBlue,
                        ),
                        label: const Text(
                          'Sync Now',
                          style: TextStyle(
                            color: AppTheme.duoBlue,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  bool get _isGuest => user == null;

  Widget _buildConcurrencyCard() {
    const options = <String, String>{
      'auto': 'Auto (recommended)',
      '1': '1 (safest)',
      '2': '2',
      '3': '3',
      '4': '4',
    };
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.gauge, color: AppTheme.duoBlue, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Parallel requests',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: context.colors.textPrimary,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: context.colors.shadow,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: context.colors.outline),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: options.containsKey(_genConcurrency)
                    ? _genConcurrency
                    : 'auto',
                dropdownColor: context.colors.surface,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                items: options.entries
                    .map(
                      (e) =>
                          DropdownMenuItem(value: e.key, child: Text(e.value)),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _genConcurrency = v);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.cpu, color: AppTheme.duoBlue, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Automation Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Auto-fetch Reference Books',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Extract mentioned books from syllabus and download them from the marketplace automatically.',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch(
                value: _autoFetchBooks,
                activeColor: AppTheme.duoBlue,
                onChanged: (v) {
                  setState(() => _autoFetchBooks = v);
                },
              ),
            ],
          ),
          Divider(color: context.colors.outline, height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Verification Verification',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Verify page ranges automatically using AI and proceed without manual confirmation.',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch(
                value: _autoVerifyMappings,
                activeColor: AppTheme.duoBlue,
                onChanged: (v) {
                  setState(() => _autoVerifyMappings = v);
                },
              ),
            ],
          ),
          Divider(color: context.colors.outline, height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Auto-generate Module 1',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Create outlines for Module 1 sections and auto-generate the first unit with diagrams.',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch(
                value: _autoGenerateModule1,
                activeColor: AppTheme.duoBlue,
                onChanged: (v) {
                  setState(() => _autoGenerateModule1 = v);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAiQueueCard() {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AiQueueScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.duoBlue.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    LucideIcons.cpu,
                    color: AppTheme.duoBlue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Request Queue',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Monitor active, queued, and scheduled lesson generation tasks.',
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  LucideIcons.chevronRight,
                  color: context.colors.textFaint,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExperimentsCard() {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ExperimentsScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.duoViolet.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    LucideIcons.flaskConical,
                    color: AppTheme.duoViolet,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Experiments / Slide Testing',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Load slide presets or paste custom slide JSON to test rendering live.',
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  LucideIcons.chevronRight,
                  color: context.colors.textFaint,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  Widget _buildScheduleCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                LucideIcons.calendarRange,
                color: AppTheme.duoBlue,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Auto-schedule hours',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Time',
                    style: TextStyle(
                      color: context.colors.textFaint,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _scheduleStart,
                      );
                      if (time != null) setState(() => _scheduleStart = time);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.shadow,
                      foregroundColor: context.colors.textPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: context.colors.outline),
                      ),
                    ),
                    child: Text(_formatTimeOfDay(_scheduleStart)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End Time',
                    style: TextStyle(
                      color: context.colors.textFaint,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _scheduleEnd,
                      );
                      if (time != null) setState(() => _scheduleEnd = time);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.shadow,
                      foregroundColor: context.colors.textPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: context.colors.outline),
                      ),
                    ),
                    child: Text(_formatTimeOfDay(_scheduleEnd)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveChatPromptCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                LucideIcons.messageSquare,
                color: AppTheme.duoBlue,
                size: 28,
              ),
              const SizedBox(width: 16),
              Text(
                'Chat System Prompt',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: context.colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'This prompt is appended to the tutor\'s instructions in both live and standard chat modes. Use it to specify custom personas, topics, or explanation guidelines.',
            style: TextStyle(
              color: context.colors.textFaint,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _customPromptController,
            maxLines: 4,
            minLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: context.colors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText:
                  'e.g. Always explain concepts using analogies to space exploration. Keep tone humorous.',
              hintStyle: TextStyle(
                color: context.colors.textFaint,
                fontSize: 12,
              ),
              filled: true,
              fillColor: context.colors.shadow,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: context.colors.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.duoBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetacognitionCard() {
    final profile = _writingStyleProfile;
    final hasProfile = profile != null;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassOf(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.brain, color: AppTheme.duoBlue, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Writing Style Personalized',
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              if (hasProfile)
                const Icon(
                  LucideIcons.checkCircle2,
                  color: AppTheme.duoGreen,
                  size: 20,
                )
              else
                const Icon(
                  LucideIcons.alertCircle,
                  color: AppTheme.duoOrange,
                  size: 20,
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (hasProfile) ...[
            _buildProfileRow(
              'Syntactic Complexity',
              profile['syntactic_complexity']?.toString().toUpperCase() ??
                  'MEDIUM',
            ),
            _buildProfileRow(
              'Lexical Richness',
              profile['lexical_richness']?.toString().toUpperCase() ??
                  'MODERATE',
            ),
            _buildProfileRow(
              'Tone & Register',
              profile['tone_and_register']?.toString().toUpperCase() ??
                  'OBJECTIVE',
            ),
            _buildProfileRow(
              'Pacing & Rhythm',
              profile['pacing_and_rhythm']?.toString() ?? 'Flowing prose',
            ),
            _buildProfileRow(
              'Transitions Favored',
              (profile['transitional_mechanics'] as List?)?.join(', ') ??
                  'however, furthermore',
            ),
          ] else ...[
            Text(
              'No custom writing style profile is set yet. Sirius is currently generating lessons in standard academic style.',
              style: TextStyle(
                color: context.colors.textFaint,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.duoBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const MetacognitionSetupScreen(isSettingsMode: true),
                  ),
                ).then((updated) {
                  if (updated == true) {
                    _loadSettings();
                  }
                });
              },
              child: Text(
                hasProfile
                    ? 'Re-evaluate Writing Style'
                    : 'Set Up Writing Style Profile',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                color: context.colors.textFaint,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: context.colors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
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

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 900;

    if (isDesktop) {
      return Scaffold(
        backgroundColor: context.colors.background,
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left sidebar: categories & profile
            Container(
              width: 300,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Profile Header Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: AppTheme.glassOf(context),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppTheme.duoBlue,
                          child: Text(
                            user?.displayName?.isNotEmpty == true
                                ? user!.displayName![0].toUpperCase()
                                : 'U',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: context.colors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.displayName ?? 'Guest User',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  color: context.colors.textPrimary,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                user?.email ?? 'Not logged in',
                                style: TextStyle(
                                  color: context.colors.textFaint,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Categories list
                  _buildCategoryMenuItem(
                    'general',
                    LucideIcons.settings,
                    'General & Goals',
                  ),
                  const SizedBox(height: 8),
                  _buildCategoryMenuItem(
                    'profile',
                    LucideIcons.user,
                    'Profile & Style',
                  ),
                  const SizedBox(height: 8),
                  if (GlobalState.developerModeNotifier.value) ...[
                    _buildCategoryMenuItem(
                      'advanced',
                      LucideIcons.cpu,
                      'Advanced Config',
                    ),
                  ],

                  const Spacer(),

                  // Bottom action buttons (Save, Sign Out)
                  DuoButton(
                    text: 'Save Settings',
                    onPressed: _saveSettings,
                    color: AppTheme.duoGreen,
                    shadowColor: AppTheme.duoGreenDark,
                  ),
                  const SizedBox(height: 12),
                  if (user != null)
                    DuoButton(
                      text: 'Sign Out',
                      onPressed: () async {
                        Navigator.pop(context);
                        await FbAuth.instance.signOut();
                        SecretsService.instance.clear();
                        GlobalState.isGuestNotifier.value = false;
                        GlobalState.xpNotifier.value = 0;
                      },
                      color: AppTheme.duoRed,
                      shadowColor: AppTheme.duoRedDark,
                      isOutline: true,
                    )
                  else
                    DuoButton(
                      text: 'Sign In / Log In',
                      onPressed: () {
                        GlobalState.isGuestNotifier.value = false;
                        GlobalState.forceShowAuthScreen.value = true;
                        Navigator.pop(context);
                      },
                      color: AppTheme.duoBlue,
                      shadowColor: AppTheme.duoBlueDark,
                    ),
                ],
              ),
            ),
            Container(width: 1, color: context.colors.outline),

            // Right side: scrollable contents of selected category
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: _buildCategoryContent(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 32),
                decoration: AppTheme.glassOf(context),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppTheme.duoBlue,
                      child: Text(
                        user?.displayName?.isNotEmpty == true
                            ? user!.displayName![0].toUpperCase()
                            : 'U',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: context.colors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? 'Guest User',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: context.colors.textPrimary,
                            ),
                          ),
                          Text(
                            user?.email ?? 'Not logged in',
                            style: TextStyle(
                              color: context.colors.textFaint,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Text(
                'Appearance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                'Follow the system, or pick light/dark explicitly.',
                style: TextStyle(color: context.colors.textFaint, fontSize: 12),
              ),
              const SizedBox(height: 16),
              _buildAppearanceCard(),
              const SizedBox(height: 32),

              const Text(
                'Learning',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                'Set a daily XP goal and an optional study reminder.',
                style: TextStyle(color: context.colors.textFaint, fontSize: 12),
              ),
              const SizedBox(height: 16),
              const DailyGoalCard(),
              const SizedBox(height: 32),

              const Text(
                'Personalization',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                'Optional: tune the generated content to your writing and learning style.',
                style: TextStyle(color: context.colors.textFaint, fontSize: 12),
              ),
              const SizedBox(height: 16),
              const LearnerProfileCard(),
              const SizedBox(height: 16),
              _buildMetacognitionCard(),
              const SizedBox(height: 32),

              const Text(
                'Storage',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                'Courses are saved on this device first. Cloud sync is optional.',
                style: TextStyle(color: context.colors.textFaint, fontSize: 12),
              ),
              const SizedBox(height: 16),
              _buildCloudSyncCard(),
              const SizedBox(height: 32),

              const Text(
                'API Usage & Limits',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              _buildUsageLimitsSection(),
              const SizedBox(height: 32),

              Container(
                decoration: AppTheme.glassOf(context),
                child: SwitchListTile(
                  value: GlobalState.developerModeNotifier.value,
                  activeColor: AppTheme.duoRed,
                  title: Text(
                    'Developer mode',
                    style: TextStyle(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Text(
                    'Unlock lesson editing, slide deletion, lesson deletion, and manual content regeneration.',
                    style: TextStyle(
                      color: context.colors.textFaint,
                      fontSize: 11,
                    ),
                  ),
                  onChanged: (v) => setState(() {
                    GlobalState.developerModeNotifier.value = v;
                    if (!v) {
                      GlobalState.advancedModeNotifier.value = false;
                    }
                  }),
                ),
              ),
              const SizedBox(height: 32),
              if (GlobalState.developerModeNotifier.value) ...[
                const Text(
                  'API Keys (Gemini)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add multiple Gemini keys to fall back automatically if rate-limited.',
                  style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                ),
                const SizedBox(height: 16),
                StringListManager(
                  key: _keysManagerKey,
                  initialItems: _keys,
                  hintText: 'Enter Gemini API Key',
                  itemIcon: LucideIcons.key,
                  onChanged: (newKeys) => setState(() => _keys = newKeys),
                ),
                const SizedBox(height: 32),

                const Text(
                  'API Keys (Groq)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add Groq keys to fall back automatically when Gemini rate-limits.',
                  style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                ),
                const SizedBox(height: 16),
                StringListManager(
                  key: _groqKeysManagerKey,
                  initialItems: _groqKeys,
                  hintText: 'Enter Groq API Key',
                  itemIcon: LucideIcons.key,
                  onChanged: (newKeys) => setState(() => _groqKeys = newKeys),
                ),
                const SizedBox(height: 32),

                const Text(
                  'API Keys (Cerebras)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add Cerebras keys to fall back automatically when Gemini and Groq rate-limit.',
                  style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                ),
                const SizedBox(height: 16),
                StringListManager(
                  key: _cerebrasKeysManagerKey,
                  initialItems: _cerebrasKeys,
                  hintText: 'Enter Cerebras API Key',
                  itemIcon: LucideIcons.key,
                  onChanged: (newKeys) => setState(() => _cerebrasKeys = newKeys),
                ),
                const SizedBox(height: 32),

                const Text(
                  'API Keys (OpenRouter)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add OpenRouter keys to fall back automatically when Gemini, Groq, and Cerebras rate-limit.',
                  style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                ),
                const SizedBox(height: 16),
                StringListManager(
                  key: _openrouterKeysManagerKey,
                  initialItems: _openrouterKeys,
                  hintText: 'Enter OpenRouter API Key',
                  itemIcon: LucideIcons.key,
                  onChanged: (newKeys) => setState(() => _openrouterKeys = newKeys),
                ),
                const SizedBox(height: 32),

                Container(
                  decoration: AppTheme.glassOf(context),
                  child: SwitchListTile(
                    value: GlobalState.advancedModeNotifier.value,
                    activeColor: AppTheme.duoViolet,
                    title: Text(
                      'Advanced mode',
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Text(
                      'Model ladders, concurrency, automation, experiments, and per-node generation menus.',
                      style: TextStyle(
                        color: context.colors.textFaint,
                        fontSize: 11,
                      ),
                    ),
                    onChanged: (v) => setState(
                      () => GlobalState.advancedModeNotifier.value = v,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],

              if (GlobalState.advancedModeNotifier.value) ...[
                SizedBox(
                  width: double.infinity,
                  child: DuoButton(
                    text: 'PDF Browser',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PdfBrowserScreen(),
                        ),
                      );
                    },
                    color: AppTheme.duoViolet,
                    shadowColor: AppTheme.duoVioletDark,
                  ),
                ),
                const SizedBox(height: 32),

                const Text(
                  'AI Model Assignments (Gemini)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select specialized Gemini models for text, graphics, and light-weight tasks.',
                  style: TextStyle(
                    color: context.colors.textFaint,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Primary - Text',
                  subtitle: 'Generates final interactive lessons & quizzes.',
                  slotName: 'Primary - Text',
                  icon: LucideIcons.fileText,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Primary - Graphics',
                  subtitle: 'Generates canvas diagrams for lessons & proofs.',
                  slotName: 'Primary - Graphics',
                  icon: LucideIcons.image,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Lite',
                  subtitle: 'Creates skeletons and maps lesson plan lists.',
                  slotName: 'Lite',
                  icon: LucideIcons.zap,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Live',
                  subtitle: 'Real-time live model for chat & voice assistance.',
                  slotName: 'Live',
                  icon: LucideIcons.mic,
                ),
                const SizedBox(height: 32),

                const Text(
                  'AI Model Assignments (Groq Fallback)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select specialized Groq models for text, graphics, and light-weight fallback tasks.',
                  style: TextStyle(
                    color: context.colors.textFaint,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Groq - Primary - Text',
                  subtitle: 'Fallback model for lessons & quizzes.',
                  slotName: 'Groq - Primary - Text',
                  icon: LucideIcons.fileText,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Groq - Primary - Graphics',
                  subtitle: 'Fallback model for canvas diagrams & proofs.',
                  slotName: 'Groq - Primary - Graphics',
                  icon: LucideIcons.image,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Groq - Lite',
                  subtitle: 'Fallback model for skeletons and outlines.',
                  slotName: 'Groq - Lite',
                  icon: LucideIcons.zap,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Groq - Live',
                  subtitle: 'Fallback model for live voice & chat assistance.',
                  slotName: 'Groq - Live',
                  icon: LucideIcons.mic,
                ),
                const SizedBox(height: 32),

                const Text(
                  'AI Model Assignments (Cerebras Fallback)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select specialized Cerebras models for text, graphics, and light-weight fallback tasks.',
                  style: TextStyle(
                    color: context.colors.textFaint,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Cerebras - Primary - Text',
                  subtitle: 'Fallback model for lessons & quizzes.',
                  slotName: 'Cerebras - Primary - Text',
                  icon: LucideIcons.fileText,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Cerebras - Primary - Graphics',
                  subtitle: 'Fallback model for canvas diagrams & proofs.',
                  slotName: 'Cerebras - Primary - Graphics',
                  icon: LucideIcons.image,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Cerebras - Lite',
                  subtitle: 'Fallback model for skeletons and outlines.',
                  slotName: 'Cerebras - Lite',
                  icon: LucideIcons.zap,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'Cerebras - Live',
                  subtitle: 'Fallback model for live voice & chat assistance.',
                  slotName: 'Cerebras - Live',
                  icon: LucideIcons.mic,
                ),
                const SizedBox(height: 32),

                const Text(
                  'AI Model Assignments (OpenRouter Fallback)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select specialized OpenRouter models for text, graphics, and light-weight fallback tasks.',
                  style: TextStyle(
                    color: context.colors.textFaint,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'OpenRouter - Primary - Text',
                  subtitle: 'Fallback model for lessons & quizzes.',
                  slotName: 'OpenRouter - Primary - Text',
                  icon: LucideIcons.fileText,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'OpenRouter - Primary - Graphics',
                  subtitle: 'Fallback model for canvas diagrams & proofs.',
                  slotName: 'OpenRouter - Primary - Graphics',
                  icon: LucideIcons.image,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'OpenRouter - Lite',
                  subtitle: 'Fallback model for skeletons and outlines.',
                  slotName: 'OpenRouter - Lite',
                  icon: LucideIcons.zap,
                ),
                const SizedBox(height: 16),

                _buildModelSlotCard(
                  title: 'OpenRouter - Live',
                  subtitle: 'Fallback model for live voice & chat assistance.',
                  slotName: 'OpenRouter - Live',
                  icon: LucideIcons.mic,
                ),
                const SizedBox(height: 32),

                const Text(
                  'Generation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'How many lessons to generate at once. Higher is faster but uses more bandwidth and may hit rate limits.',
                  style: TextStyle(
                    color: context.colors.textFaint,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                _buildConcurrencyCard(),
                const SizedBox(height: 16),
                _buildScheduleCard(),
                const SizedBox(height: 16),
                _buildAutomationCard(),
                const SizedBox(height: 16),
                _buildAiQueueCard(),
                const SizedBox(height: 16),
                _buildExperimentsCard(),

                const SizedBox(height: 32),
                const Text(
                  'Live Chat Assistant',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Customize the behavior and system instructions for the real-time AI helper.',
                  style: TextStyle(
                    color: context.colors.textFaint,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                _buildLiveChatPromptCard(),
              ],

              const SizedBox(height: 48),
              DuoButton(
                text: 'Save Settings',
                onPressed: _saveSettings,
                color: AppTheme.duoGreen,
                shadowColor: AppTheme.duoGreenDark,
              ),

              const SizedBox(height: 16),
              if (user != null)
                SizedBox(
                  width: double.infinity,
                  child: DuoButton(
                    text: 'Sign Out',
                    onPressed: () async {
                      Navigator.pop(context);
                      await FbAuth.instance.signOut();
                      SecretsService.instance.clear();
                      GlobalState.isGuestNotifier.value = false;
                      GlobalState.xpNotifier.value = 0;
                    },
                    color: AppTheme.duoRed,
                    shadowColor: AppTheme.duoRedDark,
                    isOutline: true,
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: DuoButton(
                    text: 'Sign In / Log In',
                    onPressed: () {
                      GlobalState.isGuestNotifier.value = false;
                      GlobalState.forceShowAuthScreen.value = true;
                      Navigator.pop(context);
                    },
                    color: AppTheme.duoBlue,
                    shadowColor: AppTheme.duoBlueDark,
                  ),
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryMenuItem(String category, IconData icon, String label) {
    final bool isSelected = _selectedCategory == category;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.duoBlue.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppTheme.duoBlue.withOpacity(0.3)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppTheme.duoBlue
                  : context.colors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isSelected
                    ? AppTheme.duoBlue
                    : context.colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceCard() {
    return Container(
      decoration: AppTheme.glassOf(context),
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: GlobalState.themeModeNotifier,
        builder: (context, mode, _) => Row(
          children: [
            Icon(
              mode == ThemeMode.dark
                  ? LucideIcons.moon
                  : mode == ThemeMode.light
                  ? LucideIcons.sun
                  : LucideIcons.monitor,
              size: 20,
              color: context.colors.textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Theme',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(value: ThemeMode.system, label: Text('Auto')),
                ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
              ],
              selected: {mode},
              showSelectedIcon: false,
              onSelectionChanged: (s) =>
                  GlobalState.themeModeNotifier.value = s.first,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryContent() {
    if (_selectedCategory == 'general') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Appearance',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Follow the system, or pick light/dark explicitly.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          _buildAppearanceCard(),
          const SizedBox(height: 32),

          const Text(
            'Learning Goal',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Set a daily XP goal and an optional study reminder.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          const DailyGoalCard(),
          const SizedBox(height: 32),

          const Text(
            'Storage & Sync',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Courses are saved on this device first. Cloud sync is optional.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          _buildCloudSyncCard(),
          const SizedBox(height: 32),

          const Text(
            'API Usage & Limits',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          _buildUsageLimitsSection(),
          const SizedBox(height: 32),

          const Text(
            'Developer Mode',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Unlock developer tools, lesson editing, and model ladders.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: AppTheme.glassOf(context),
            child: SwitchListTile(
              value: GlobalState.developerModeNotifier.value,
              activeColor: AppTheme.duoRed,
              title: Text(
                'Developer mode',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: Text(
                'Unlock lesson editing, slide deletion, lesson deletion, and manual content regeneration.',
                style: TextStyle(color: context.colors.textFaint, fontSize: 11),
              ),
              onChanged: (v) => setState(() {
                GlobalState.developerModeNotifier.value = v;
                if (!v) {
                  GlobalState.advancedModeNotifier.value = false;
                  _selectedCategory = 'general';
                }
              }),
            ),
          ),
        ],
      );
    } else if (_selectedCategory == 'profile') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personalization',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Optional: tune the generated content to your writing and learning style.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          const LearnerProfileCard(),
          const SizedBox(height: 16),
          _buildMetacognitionCard(),
          const SizedBox(height: 32),

          const Text(
            'Live Chat Assistant',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Customize the behavior and system instructions for the real-time AI helper.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          _buildLiveChatPromptCard(),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'API Keys (Gemini)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Add multiple Gemini keys to fall back automatically if rate-limited.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          StringListManager(
            key: _keysManagerKey,
            initialItems: _keys,
            hintText: 'Enter Gemini API Key',
            itemIcon: LucideIcons.key,
            onChanged: (newKeys) => setState(() => _keys = newKeys),
          ),
          const SizedBox(height: 32),

          const Text(
            'API Keys (Groq)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Add Groq keys to fall back automatically when Gemini rate-limits.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          StringListManager(
            key: _groqKeysManagerKey,
            initialItems: _groqKeys,
            hintText: 'Enter Groq API Key',
            itemIcon: LucideIcons.key,
            onChanged: (newKeys) => setState(() => _groqKeys = newKeys),
          ),
          const SizedBox(height: 32),

          const Text(
            'API Keys (Cerebras)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Add Cerebras keys to fall back automatically when Gemini and Groq rate-limit.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          StringListManager(
            key: _cerebrasKeysManagerKey,
            initialItems: _cerebrasKeys,
            hintText: 'Enter Cerebras API Key',
            itemIcon: LucideIcons.key,
            onChanged: (newKeys) => setState(() => _cerebrasKeys = newKeys),
          ),
          const SizedBox(height: 32),

          const Text(
            'API Keys (OpenRouter)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Add OpenRouter keys to fall back automatically when Gemini, Groq, and Cerebras rate-limit.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          StringListManager(
            key: _openrouterKeysManagerKey,
            initialItems: _openrouterKeys,
            hintText: 'Enter OpenRouter API Key',
            itemIcon: LucideIcons.key,
            onChanged: (newKeys) => setState(() => _openrouterKeys = newKeys),
          ),
          const SizedBox(height: 32),

          const Text(
            'Advanced Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Enable Advanced Mode to configure AI models, concurrency settings, and execute experiments.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: AppTheme.glassOf(context),
            child: SwitchListTile(
              value: GlobalState.advancedModeNotifier.value,
              activeColor: AppTheme.duoViolet,
              title: Text(
                'Advanced mode',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: Text(
                'Model ladders, concurrency, automation, experiments, and per-node generation menus.',
                style: TextStyle(color: context.colors.textFaint, fontSize: 11),
              ),
              onChanged: (v) =>
                  setState(() => GlobalState.advancedModeNotifier.value = v),
            ),
          ),
          const SizedBox(height: 32),

          if (GlobalState.advancedModeNotifier.value) ...[
            SizedBox(
              width: double.infinity,
              child: DuoButton(
                text: 'PDF Browser',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PdfBrowserScreen()),
                  );
                },
                color: AppTheme.duoViolet,
                shadowColor: AppTheme.duoVioletDark,
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'AI Model Assignments (Gemini)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              'Select specialized Gemini models for text, graphics, and light-weight tasks.',
              style: TextStyle(color: context.colors.textFaint, fontSize: 12),
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Primary - Text',
              subtitle: 'Generates final interactive lessons & quizzes.',
              slotName: 'Primary - Text',
              icon: LucideIcons.fileText,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Primary - Graphics',
              subtitle: 'Generates canvas diagrams for lessons & proofs.',
              slotName: 'Primary - Graphics',
              icon: LucideIcons.image,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Lite',
              subtitle: 'Creates skeletons and maps lesson plan lists.',
              slotName: 'Lite',
              icon: LucideIcons.zap,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Live',
              subtitle: 'Real-time live model for chat & voice assistance.',
              slotName: 'Live',
              icon: LucideIcons.mic,
            ),
            const SizedBox(height: 32),

            const Text(
              'AI Model Assignments (Groq Fallback)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              'Select specialized Groq models for text, graphics, and light-weight fallback tasks.',
              style: TextStyle(color: context.colors.textFaint, fontSize: 12),
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Groq - Primary - Text',
              subtitle: 'Fallback model for lessons & quizzes.',
              slotName: 'Groq - Primary - Text',
              icon: LucideIcons.fileText,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Groq - Primary - Graphics',
              subtitle: 'Fallback model for canvas diagrams & proofs.',
              slotName: 'Groq - Primary - Graphics',
              icon: LucideIcons.image,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Groq - Lite',
              subtitle: 'Fallback model for skeletons and outlines.',
              slotName: 'Groq - Lite',
              icon: LucideIcons.zap,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Groq - Live',
              subtitle: 'Fallback model for live voice & chat assistance.',
              slotName: 'Groq - Live',
              icon: LucideIcons.mic,
            ),
            const SizedBox(height: 32),

            const Text(
              'AI Model Assignments (Cerebras Fallback)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
             Text(
              'Select specialized Cerebras models for text, graphics, and light-weight fallback tasks.',
              style: TextStyle(color: context.colors.textFaint, fontSize: 12),
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Cerebras - Primary - Text',
              subtitle: 'Fallback model for lessons & quizzes.',
              slotName: 'Cerebras - Primary - Text',
              icon: LucideIcons.fileText,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Cerebras - Primary - Graphics',
              subtitle: 'Fallback model for canvas diagrams & proofs.',
              slotName: 'Cerebras - Primary - Graphics',
              icon: LucideIcons.image,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Cerebras - Lite',
              subtitle: 'Fallback model for skeletons and outlines.',
              slotName: 'Cerebras - Lite',
              icon: LucideIcons.zap,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'Cerebras - Live',
              subtitle: 'Fallback model for live voice & chat assistance.',
              slotName: 'Cerebras - Live',
              icon: LucideIcons.mic,
            ),
            const SizedBox(height: 32),

            const Text(
              'AI Model Assignments (OpenRouter Fallback)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              'Select specialized OpenRouter models for text, graphics, and light-weight fallback tasks.',
              style: TextStyle(color: context.colors.textFaint, fontSize: 12),
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'OpenRouter - Primary - Text',
              subtitle: 'Fallback model for lessons & quizzes.',
              slotName: 'OpenRouter - Primary - Text',
              icon: LucideIcons.fileText,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'OpenRouter - Primary - Graphics',
              subtitle: 'Fallback model for canvas diagrams & proofs.',
              slotName: 'OpenRouter - Primary - Graphics',
              icon: LucideIcons.image,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'OpenRouter - Lite',
              subtitle: 'Fallback model for skeletons and outlines.',
              slotName: 'OpenRouter - Lite',
              icon: LucideIcons.zap,
            ),
            const SizedBox(height: 16),

            _buildModelSlotCard(
              title: 'OpenRouter - Live',
              subtitle: 'Fallback model for live voice & chat assistance.',
              slotName: 'OpenRouter - Live',
              icon: LucideIcons.mic,
            ),
            const SizedBox(height: 32),

            const Text(
              'Generation Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              'How many lessons to generate at once, task queueing, schedule settings, and automated rules.',
              style: TextStyle(color: context.colors.textFaint, fontSize: 12),
            ),
            const SizedBox(height: 16),
            _buildConcurrencyCard(),
            const SizedBox(height: 16),
            _buildScheduleCard(),
            const SizedBox(height: 16),
            _buildAutomationCard(),
            const SizedBox(height: 16),
            _buildAiQueueCard(),
            const SizedBox(height: 16),
            _buildExperimentsCard(),
          ] else
            Container(
              padding: const EdgeInsets.all(20),
              decoration: AppTheme.glassOf(context),
              alignment: Alignment.center,
              child: Text(
                'Please enable Advanced Mode above to unlock model slot configurations and scheduling details.',
                textAlign: TextAlign.center,
                style: TextStyle(color: context.colors.textFaint, fontSize: 12),
              ),
            ),
        ],
      );
    }
  }
}
