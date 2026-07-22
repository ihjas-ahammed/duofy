import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/fb/fb_auth.dart';
import '../services/global_state.dart';
import '../services/database_service.dart';
import '../services/secrets_service.dart';
import '../theme/app_theme.dart';
import '../widgets/daily_goal_card.dart';
import '../widgets/duo_button.dart';
import '../widgets/learner_profile_card.dart';
import '../widgets/responsive_center.dart';

import 'pdf_browser_screen.dart';
import 'dev/programming_slides_screen.dart';
import 'metacognition_setup_screen.dart';
import 'ai_queue_screen.dart';
import 'experiments_screen.dart';
import 'ai_providers_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedCategory = 'general';

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
    final prefs = await SharedPreferences.getInstance();

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

    // Read the latest AI Keys and model lists from shared preferences to avoid clobbering the cloud sync
    final keys = prefs.getStringList('gemini_api_keys_list') ?? [];
    final models = prefs.getStringList('gemini_models_list') ?? [];
    final pText = prefs.getStringList('model_primary_text_list') ?? [];
    final pGraphics = prefs.getStringList('model_primary_graphics_list') ?? [];
    final lite = prefs.getStringList('model_lite_list') ?? [];
    final live = prefs.getStringList('model_live_list') ?? [];

    final groqKeys = prefs.getStringList('groq_api_keys_list') ?? [];
    final groqPT = prefs.getStringList('groq_model_primary_text_list') ?? [];
    final groqPG = prefs.getStringList('groq_model_primary_graphics_list') ?? [];
    final groqLite = prefs.getStringList('groq_model_lite_list') ?? [];
    final groqLive = prefs.getStringList('groq_model_live_list') ?? [];

    final cerebrasKeys = prefs.getStringList('cerebras_api_keys_list') ?? [];
    final cerebrasPT = prefs.getStringList('cerebras_model_primary_text_list') ?? [];
    final cerebrasPG = prefs.getStringList('cerebras_model_primary_graphics_list') ?? [];
    final cerebrasLite = prefs.getStringList('cerebras_model_lite_list') ?? [];
    final cerebrasLive = prefs.getStringList('cerebras_model_live_list') ?? [];

    final openrouterKeys = prefs.getStringList('openrouter_api_keys_list') ?? [];
    final openrouterPT = prefs.getStringList('openrouter_model_primary_text_list') ?? [];
    final openrouterPG = prefs.getStringList('openrouter_model_primary_graphics_list') ?? [];
    final openrouterLite = prefs.getStringList('openrouter_model_lite_list') ?? [];
    final openrouterLive = prefs.getStringList('openrouter_model_live_list') ?? [];

    final selectedProvider = prefs.getString('selected_ai_provider');

    await _db.saveUserSettings(
      apiKeys: keys,
      models: models,
      modelPrimaryTextList: pText,
      modelPrimaryGraphicsList: pGraphics,
      modelLiteList: lite,
      modelLiveList: live,
      groqApiKeys: groqKeys,
      groqModelPrimaryTextList: groqPT,
      groqModelPrimaryGraphicsList: groqPG,
      groqModelLiteList: groqLite,
      groqModelLiveList: groqLive,
      cerebrasApiKeys: cerebrasKeys,
      cerebrasModelPrimaryTextList: cerebrasPT,
      cerebrasModelPrimaryGraphicsList: cerebrasPG,
      cerebrasModelLiteList: cerebrasLite,
      cerebrasModelLiveList: cerebrasLive,
      openrouterApiKeys: openrouterKeys,
      openrouterModelPrimaryTextList: openrouterPT,
      openrouterModelPrimaryGraphicsList: openrouterPG,
      openrouterModelLiteList: openrouterLite,
      openrouterModelLiveList: openrouterLive,
      selectedAiProvider: selectedProvider,
      genConcurrency: _genConcurrency,
      scheduleStartHour: _scheduleStart.hour,
      scheduleStartMinute: _scheduleStart.minute,
      scheduleEndHour: _scheduleEnd.hour,
      scheduleEndMinute: _scheduleEnd.minute,
      customLiveChatPrompt: _customPromptController.text.trim(),
      autoFetchBooks: _autoFetchBooks,
      autoVerifyMappings: _autoVerifyMappings,
      autoGenerateModule1: _autoGenerateModule1,
      writingStyleProfile: _writingStyleProfile,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Settings saved successfully!'),
        ),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildAiProvidersTile() {
    return Container(
      decoration: AppTheme.glassOf(context),
      child: ListTile(
        leading: const Icon(LucideIcons.brain, color: AppTheme.duoBlue),
        title: Text(
          'AI Providers & Models',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(
          'Configure Gemini, Groq, Cerebras, OpenRouter, and model assignments.',
          style: TextStyle(
            color: context.colors.textFaint,
            fontSize: 11,
          ),
        ),
        trailing: Icon(LucideIcons.chevronRight, color: context.colors.textFaint),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AiProvidersScreen()),
          ).then((_) {
            _loadSettings();
          });
        },
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
              ? AppTheme.duoBlue.withValues(alpha: 0.5)
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
                activeThumbColor: AppTheme.duoBlue,
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
                activeThumbColor: AppTheme.duoBlue,
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
                activeThumbColor: AppTheme.duoBlue,
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
                activeThumbColor: AppTheme.duoBlue,
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
                    color: AppTheme.duoBlue.withValues(alpha: 0.15),
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
                    color: AppTheme.duoViolet.withValues(alpha: 0.15),
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
                'AI & Models Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                'Configure API keys and fallback model ladders for Gemini, Groq, Cerebras, and OpenRouter.',
                style: TextStyle(color: context.colors.textFaint, fontSize: 12),
              ),
              const SizedBox(height: 16),
              _buildAiProvidersTile(),
              const SizedBox(height: 32),

              Container(
                decoration: AppTheme.glassOf(context),
                child: SwitchListTile(
                  value: GlobalState.developerModeNotifier.value,
                  activeThumbColor: AppTheme.duoRed,
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
                Container(
                  decoration: AppTheme.glassOf(context),
                  child: SwitchListTile(
                    value: GlobalState.advancedModeNotifier.value,
                    activeThumbColor: AppTheme.duoViolet,
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
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: DuoButton(
                    text: 'Programming Slides',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProgrammingSlidesScreen(),
                        ),
                      );
                    },
                    color: AppTheme.duoBlue,
                    shadowColor: AppTheme.duoBlueDark,
                  ),
                ),
                const SizedBox(height: 32),

                const Text(
                  'Generation Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Task queueing, schedule settings, and automated rules.',
                  style: TextStyle(
                    color: context.colors.textFaint,
                    fontSize: 12,
                  ),
                ),
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
              ? AppTheme.duoBlue.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppTheme.duoBlue.withValues(alpha: 0.3)
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
            'AI & Models Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            'Configure API keys and fallback model ladders for Gemini, Groq, Cerebras, and OpenRouter.',
            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
          ),
          const SizedBox(height: 16),
          _buildAiProvidersTile(),
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
              activeThumbColor: AppTheme.duoRed,
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
              activeThumbColor: AppTheme.duoViolet,
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
              'AI Providers & Model Fallbacks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              'Configure API keys and fallback model ladders for Google Gemini, Groq, Cerebras, and OpenRouter.',
              style: TextStyle(color: context.colors.textFaint, fontSize: 12),
            ),
            const SizedBox(height: 16),
            _buildAiProvidersTile(),
            const SizedBox(height: 32),

            const Text(
              'Generation Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              'Task queueing, schedule settings, and automated rules.',
              style: TextStyle(color: context.colors.textFaint, fontSize: 12),
            ),
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
