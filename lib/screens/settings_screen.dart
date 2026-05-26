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
  // Each slot is now an ordered list — the first model is tried first, the
  // next is the fallback, and so on. Empty list means "use the built-in
  // default" but the UI keeps at least one entry to avoid that state.
  List<String> _modelPrimaryText = ['gemma4'];
  List<String> _modelPrimaryGraphics = ['gemini-3.5-flash'];
  List<String> _modelLite = ['gemini-flash-lite-latest'];
  /// How many lesson requests to fire in parallel during generation.
  /// 'auto' lets the app pick from the device's capacity; otherwise a fixed
  /// count string ('1'..'4'). Read by AiService via the `gen_concurrency` pref.
  String _genConcurrency = 'auto';
  /// Local-first: cloud backup/sync is opt-in. Mirrors
  /// [DatabaseService.cloudSyncPrefKey].
  bool _cloudSync = false;
  bool _isLoading = true;
  final GlobalKey<StringListManagerState> _keysManagerKey = GlobalKey<StringListManagerState>();
  final DatabaseService _db = DatabaseService();

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// Reads a per-slot model list, falling back to the legacy scalar key for
  /// users coming from an older install. Always returns a non-empty list
  /// (uses the supplied [defaultModel] when nothing is stored).
  Future<List<String>> _loadModelList(
    SharedPreferences prefs,
    String listKey,
    String legacyScalarKey,
    String defaultModel,
  ) async {
    final list = prefs.getStringList(listKey) ?? [];
    if (list.isNotEmpty) return list;
    final scalar = prefs.getString(legacyScalarKey);
    if (scalar != null && scalar.trim().isNotEmpty) return [scalar.trim()];
    return [defaultModel];
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    _cloudSync = await _db.isCloudEnabled();

    List<String> keys = prefs.getStringList('gemini_api_keys_list') ?? [];
    if (keys.isEmpty) {
       final keysString = prefs.getString('gemini_api_keys') ?? '';
       keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }

    // Legacy generic-models list. No UI binds to it anymore — the three
    // slots (Text / Graphics / Lite) own their own fallback ladders. We
    // still round-trip whatever the user previously had so we don\'t lose
    // it, but we no longer inject a hardcoded default (which used to be
    // gemini-1.5-flash and silently poisoned the ladder).
    List<String> models = prefs.getStringList('gemini_models_list') ?? [];

    List<String> primaryText = await _loadModelList(prefs, 'model_primary_text_list', 'model_primary_text', 'gemma4');
    List<String> primaryGraphics = await _loadModelList(prefs, 'model_primary_graphics_list', 'model_primary_graphics', 'gemini-3.5-flash');
    List<String> lite = await _loadModelList(prefs, 'model_lite_list', 'model_lite', 'gemini-flash-lite-latest');

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
        // Each *List remote key returns a (possibly empty) list. Adopt it
        // only when non-empty so we don\'t clobber the local default.
        final remotePT = remote['modelPrimaryTextList'] as List? ?? const [];
        if (remotePT.isNotEmpty) {
          primaryText = List<String>.from(remotePT);
          await prefs.setStringList('model_primary_text_list', primaryText);
        }
        final remotePG = remote['modelPrimaryGraphicsList'] as List? ?? const [];
        if (remotePG.isNotEmpty) {
          primaryGraphics = List<String>.from(remotePG);
          await prefs.setStringList('model_primary_graphics_list', primaryGraphics);
        }
        final remoteLite = remote['modelLiteList'] as List? ?? const [];
        if (remoteLite.isNotEmpty) {
          lite = List<String>.from(remoteLite);
          await prefs.setStringList('model_lite_list', lite);
        }
      }
    }

    _keys = List.from(keys);
    _models = List.from(models);
    _modelPrimaryText = primaryText;
    _modelPrimaryGraphics = primaryGraphics;
    _modelLite = lite;
    _genConcurrency = prefs.getString('gen_concurrency') ?? 'auto';

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
    final pTextSaved = await prefs.setStringList('model_primary_text_list', _modelPrimaryText);
    final pGraphicsSaved = await prefs.setStringList('model_primary_graphics_list', _modelPrimaryGraphics);
    final liteSaved = await prefs.setStringList('model_lite_list', _modelLite);
    await prefs.setString('gen_concurrency', _genConcurrency);
    await _db.setCloudEnabled(_cloudSync);

    // Mirror the head of each list back into the legacy scalar key so other
    // code paths still relying on it (older app versions, tests) keep
    // working without a follow-up migration.
    if (_modelPrimaryText.isNotEmpty) await prefs.setString('model_primary_text', _modelPrimaryText.first);
    if (_modelPrimaryGraphics.isNotEmpty) await prefs.setString('model_primary_graphics', _modelPrimaryGraphics.first);
    if (_modelLite.isNotEmpty) await prefs.setString('model_lite', _modelLite.first);

    if (!keysSaved || !modelsSaved || !pTextSaved || !pGraphicsSaved || !liteSaved) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Local save failed — syncing to cloud only.')));
      }
    }

    await _db.saveUserSettings(
      apiKeys: _keys,
      models: _models,
      modelPrimaryTextList: _modelPrimaryText,
      modelPrimaryGraphicsList: _modelPrimaryGraphics,
      modelLiteList: _modelLite,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved ${_keys.length} key(s) and assigned models.')));
      Navigator.pop(context);
    }
  }

  /// Fetches the list of models available to the current API key. Mixed
  /// remote response + the hard-coded model names we want to keep
  /// discoverable even when the API doesn\'t list them.
  Future<List<String>> _fetchAvailableModels() async {
    final response = await http.get(Uri.parse('https://generativelanguage.googleapis.com/v1beta/models?key=${_keys.first}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch: ${response.statusCode}');
    }
    final data = jsonDecode(response.body);
    final List fetched = data['models'] ?? [];
    final List<String> fetchedModels = [];
    for (var m in fetched) {
      String name = m['name'];
      if (name.startsWith('models/')) name = name.substring(7);
      if (name.contains('gemini') || name.contains('gemma')) fetchedModels.add(name);
    }
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
    return fetchedModels;
  }

  /// Opens the picker sheet for a slot and appends the chosen model to that
  /// slot\'s ordered list. Skips duplicates and bumps an existing entry to
  /// the front if the user re-picks it.
  Future<void> _addModelToSlot(String slotName) async {
    if (_keys.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please add an API key first.')));
      return;
    }
    List<String> fetched;
    try {
      fetched = await _fetchAvailableModels();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
      return;
    }
    if (!mounted || fetched.isEmpty) return;

    final List<String> current = _listForSlot(slotName);
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Fallback Model for $slotName', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white)),
            const SizedBox(height: 6),
            const Text(
              'Models are tried in the order you list them. The first one that succeeds wins.',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: fetched.length,
                itemBuilder: (c, i) {
                  final name = fetched[i];
                  final alreadyIn = current.contains(name);
                  return ListTile(
                    leading: Icon(alreadyIn ? LucideIcons.checkCircle : LucideIcons.bot,
                        color: alreadyIn ? AppTheme.duoGreen : AppTheme.duoBlue),
                    title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    subtitle: alreadyIn
                        ? const Text('Already in this slot', style: TextStyle(color: Colors.white38, fontSize: 11))
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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
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
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () => _addModelToSlot(slotName),
                icon: const Icon(LucideIcons.plus, size: 14, color: AppTheme.duoBlue),
                label: const Text('Add fallback', style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.w900, fontSize: 11)),
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
            onReorder: (oldIndex, newIndex) => _reorderSlot(slotName, oldIndex, newIndex),
            itemBuilder: (context, i) {
              final m = models[i];
              final isPrimary = i == 0;
              return Container(
                key: ValueKey('${slotName}_$i'),
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: isPrimary ? AppTheme.duoBlue.withOpacity(0.6) : Colors.white10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isPrimary ? AppTheme.duoBlue : Colors.white12,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('${i + 1}',
                          style: TextStyle(
                            color: isPrimary ? Colors.white : Colors.white70,
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                          )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        m,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: isPrimary ? Colors.amber : Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (models.length > 1)
                      IconButton(
                        icon: const Icon(LucideIcons.trash2, size: 16, color: Colors.white38),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        onPressed: () => _removeFromSlot(slotName, i),
                      ),
                    ReorderableDragStartListener(
                      index: i,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(LucideIcons.gripVertical, size: 16, color: Colors.white38),
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

  Widget _buildCloudSyncCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cloudSync ? AppTheme.duoBlue.withOpacity(0.5) : Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_cloudSync ? LucideIcons.cloud : LucideIcons.cloudOff,
                  color: _cloudSync ? AppTheme.duoBlue : Colors.white54, size: 28),
              const SizedBox(width: 16),
              const Expanded(
                child: Text('Cloud Backup & Sync',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white)),
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
            style: const TextStyle(color: Colors.white54, fontSize: 12, height: 1.4),
          ),
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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.gauge, color: AppTheme.duoBlue, size: 28),
          const SizedBox(width: 16),
          const Expanded(
            child: Text('Parallel requests',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: options.containsKey(_genConcurrency) ? _genConcurrency : 'auto',
                dropdownColor: AppTheme.surface,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                items: options.entries
                    .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
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

            const Text('Storage', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Courses are saved on this device first. Cloud sync is optional.',
                style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 16),
            _buildCloudSyncCard(),
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

            const SizedBox(height: 32),
            const Text('Generation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('How many lessons to generate at once. Higher is faster but uses more bandwidth and may hit rate limits.', style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 16),
            _buildConcurrencyCard(),

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