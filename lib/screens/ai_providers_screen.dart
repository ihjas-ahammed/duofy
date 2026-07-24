import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';
import '../theme/app_theme.dart';
import '../services/database_service.dart';
import '../services/secrets_service.dart';
import '../services/usage_limit_service.dart';
import '../widgets/duo_button.dart';
import '../widgets/string_list_manager.dart';
import '../widgets/responsive_center.dart';

class AiProvidersScreen extends StatefulWidget {
  const AiProvidersScreen({super.key});

  @override
  State<AiProvidersScreen> createState() => _AiProvidersScreenState();
}

class _AiProvidersScreenState extends State<AiProvidersScreen> {
  bool _isLoading = true;

  // Gemini State
  List<String> _keys = [];
  List<String> _modelPrimaryText = [];
  List<String> _modelPrimaryGraphics = [];
  List<String> _modelLite = [];
  List<String> _modelLive = [];

  // Groq State
  List<String> _groqKeys = [];
  List<String> _groqModelPrimaryText = [];
  List<String> _groqModelPrimaryGraphics = [];
  List<String> _groqModelLite = [];
  List<String> _groqModelLive = [];

  // Cerebras State
  List<String> _cerebrasKeys = [];
  List<String> _cerebrasModelPrimaryText = [];
  List<String> _cerebrasModelPrimaryGraphics = [];
  List<String> _cerebrasModelLite = [];
  List<String> _cerebrasModelLive = [];

  // OpenRouter State
  List<String> _openrouterKeys = [];
  List<String> _openrouterModelPrimaryText = [];
  List<String> _openrouterModelPrimaryGraphics = [];
  List<String> _openrouterModelLite = [];
  List<String> _openrouterModelLive = [];

  // Concurrency limit
  String _genConcurrency = 'auto';

  // Global Keys for managers
  final GlobalKey<StringListManagerState> _keysManagerKey = GlobalKey<StringListManagerState>();
  final GlobalKey<StringListManagerState> _groqKeysManagerKey = GlobalKey<StringListManagerState>();
  final GlobalKey<StringListManagerState> _cerebrasKeysManagerKey = GlobalKey<StringListManagerState>();
  final GlobalKey<StringListManagerState> _openrouterKeysManagerKey = GlobalKey<StringListManagerState>();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

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

    // 1. Gemini Load
    List<String> keys = prefs.getStringList('gemini_api_keys_list') ?? [];
    if (keys.isEmpty) {
      final keysString = prefs.getString('gemini_api_keys') ?? '';
      keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
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
    List<String> lite = await _loadModelList(
      prefs,
      'model_lite_list',
      'model_lite',
      const [
        'gemini-flash-lite-latest',
        'gemini-3.1-flash-lite',
        'gemini-3.1-flash-lite-preview',
        'gemini-2.5-flash-lite',
        'gemma-4-26b-a4b-it',
        'gemini-2.0-flash-lite',
      ],
    );
    List<String> live = await _loadModelList(
      prefs,
      'model_live_list',
      'model_live',
      const ['gemini-3.1-flash-live-preview'],
    );

    // 2. Groq Load
    List<String> groqKeys = prefs.getStringList('groq_api_keys_list') ?? [];
    if (groqKeys.isEmpty) {
      final keysString = prefs.getString('groq_api_keys') ?? '';
      groqKeys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
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

    // 3. Cerebras Load
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

    // 4. OpenRouter Load
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

    setState(() {
      _keys = List.from(keys);
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
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    _keysManagerKey.currentState?.commitPending();
    _groqKeysManagerKey.currentState?.commitPending();
    _cerebrasKeysManagerKey.currentState?.commitPending();
    _openrouterKeysManagerKey.currentState?.commitPending();

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('gemini_api_keys_list', _keys);
    await prefs.setStringList('model_primary_text_list', _modelPrimaryText);
    await prefs.setStringList('model_primary_graphics_list', _modelPrimaryGraphics);
    await prefs.setStringList('model_lite_list', _modelLite);
    await prefs.setStringList('model_live_list', _modelLive);

    await prefs.setStringList('groq_api_keys_list', _groqKeys);
    await prefs.setStringList('groq_model_primary_text_list', _groqModelPrimaryText);
    await prefs.setStringList('groq_model_primary_graphics_list', _groqModelPrimaryGraphics);
    await prefs.setStringList('groq_model_lite_list', _groqModelLite);
    await prefs.setStringList('groq_model_live_list', _groqModelLive);

    await prefs.setStringList('cerebras_api_keys_list', _cerebrasKeys);
    await prefs.setStringList('cerebras_model_primary_text_list', _cerebrasModelPrimaryText);
    await prefs.setStringList('cerebras_model_primary_graphics_list', _cerebrasModelPrimaryGraphics);
    await prefs.setStringList('cerebras_model_lite_list', _cerebrasModelLite);
    await prefs.setStringList('cerebras_model_live_list', _cerebrasModelLive);

    await prefs.setStringList('openrouter_api_keys_list', _openrouterKeys);
    await prefs.setStringList('openrouter_model_primary_text_list', _openrouterModelPrimaryText);
    await prefs.setStringList('openrouter_model_primary_graphics_list', _openrouterModelPrimaryGraphics);
    await prefs.setStringList('openrouter_model_lite_list', _openrouterModelLite);
    await prefs.setStringList('openrouter_model_live_list', _openrouterModelLive);

    await prefs.setString('gen_concurrency', _genConcurrency);

    // Legacy scalars
    if (_modelPrimaryText.isNotEmpty) await prefs.setString('model_primary_text', _modelPrimaryText.first);
    if (_modelPrimaryGraphics.isNotEmpty) await prefs.setString('model_primary_graphics', _modelPrimaryGraphics.first);
    if (_modelLite.isNotEmpty) await prefs.setString('model_lite', _modelLite.first);
    if (_modelLive.isNotEmpty) await prefs.setString('model_live', _modelLive.first);

    if (_groqModelPrimaryText.isNotEmpty) await prefs.setString('groq_model_primary_text', _groqModelPrimaryText.first);
    if (_groqModelPrimaryGraphics.isNotEmpty) await prefs.setString('groq_model_primary_graphics', _groqModelPrimaryGraphics.first);
    if (_groqModelLite.isNotEmpty) await prefs.setString('groq_model_lite', _groqModelLite.first);
    if (_groqModelLive.isNotEmpty) await prefs.setString('groq_model_live', _groqModelLive.first);

    if (_cerebrasModelPrimaryText.isNotEmpty) await prefs.setString('cerebras_model_primary_text', _cerebrasModelPrimaryText.first);
    if (_cerebrasModelPrimaryGraphics.isNotEmpty) await prefs.setString('cerebras_model_primary_graphics', _cerebrasModelPrimaryGraphics.first);
    if (_cerebrasModelLite.isNotEmpty) await prefs.setString('cerebras_model_lite', _cerebrasModelLite.first);
    if (_cerebrasModelLive.isNotEmpty) await prefs.setString('cerebras_model_live', _cerebrasModelLive.first);

    if (_openrouterModelPrimaryText.isNotEmpty) await prefs.setString('openrouter_model_primary_text', _openrouterModelPrimaryText.first);
    if (_openrouterModelPrimaryGraphics.isNotEmpty) await prefs.setString('openrouter_model_primary_graphics', _openrouterModelPrimaryGraphics.first);
    if (_openrouterModelLite.isNotEmpty) await prefs.setString('openrouter_model_lite', _openrouterModelLite.first);
    if (_openrouterModelLive.isNotEmpty) await prefs.setString('openrouter_model_live', _openrouterModelLive.first);
    
    // Trigger recalculation in service cache
    await UsageLimitService.instance.init();

    final selectedProvider = prefs.getString('selected_ai_provider');
    await DatabaseService().saveUserSettings(
      apiKeys: _keys,
      models: const [],
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
      selectedAiProvider: selectedProvider,
      genConcurrency: _genConcurrency,
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

  Future<List<String>> _fetchAvailableModels() async {
    if (_keys.isEmpty) return [];
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
      if (name.contains('gemini') || name.contains('gemma')) {
        fetchedModels.add(name);
      }
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
        return;
      }
    }
    if (!mounted || fetched.isEmpty) return;

    final List<String> current = _listForSlot(slotName);
    await showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.surface,
      shape: RoundedRectangleBorder(
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
            SizedBox(height: 6),
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
                            style: TextStyle(color: context.colors.textFaint, fontSize: 11),
                          )
                        : null,
                    trailing: alreadyIn
                        ? null
                        : IconButton(
                            icon: const Icon(LucideIcons.plusCircle, color: AppTheme.duoBlue),
                            onPressed: () {
                              setState(() {
                                final list = _listForSlot(slotName);
                                list.remove(name);
                                list.add(name);
                              });
                              Navigator.pop(ctx);
                            },
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
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
      margin: EdgeInsets.only(bottom: 16),
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
              SizedBox(width: 16),
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
                    SizedBox(height: 4),
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
          const SizedBox(height: 12),
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
                margin: const EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.shadow,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isPrimary ? AppTheme.duoBlue.withValues(alpha: 0.6) : context.colors.outline,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isPrimary ? AppTheme.duoBlue : context.colors.outline,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          color: isPrimary ? context.colors.textPrimary : context.colors.textSecondary,
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                              color: isPrimary ? Colors.amber : context.colors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          FutureBuilder<int>(
                            future: UsageLimitService.instance.getUsage(m),
                            builder: (context, usageSnap) {
                              final usage = usageSnap.data ?? 0;
                              final limit = UsageLimitService.instance.getLimit(m);
                              final percent = limit > 0 ? (usage / limit).clamp(0.0, 1.0) : 0.0;
                              final isLimitHit = usage >= limit;
                              final platform = UsageLimitService.instance.getPlatformOfModel(m);
                              final hasOwnKey = UsageLimitService.instance.hasOwnApiKeySync(platform);
                              
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '$usage / $limit reqs',
                                        style: TextStyle(
                                          color: isLimitHit ? AppTheme.duoRed : context.colors.textFaint,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      if (hasOwnKey)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: AppTheme.duoGreen.withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Text(
                                            'OWN KEY',
                                            style: TextStyle(
                                              color: AppTheme.duoGreen,
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      else
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: AppTheme.duoBlue.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Text(
                                            'PUBLIC API',
                                            style: TextStyle(
                                              color: AppTheme.duoBlue,
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: SizedBox(
                                      height: 3,
                                      child: LinearProgressIndicator(
                                        value: percent,
                                        backgroundColor: context.colors.outline,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          isLimitHit ? AppTheme.duoRed : (hasOwnKey ? AppTheme.duoGreen : AppTheme.duoBlue),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
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
                        constraints: BoxConstraints(minWidth: 32, minHeight: 32),
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

  Widget _buildConcurrencyCard() {
    const options = <String, String>{
      'auto': 'Auto (recommended)',
      '1': '1 (safest)',
      '2': '2',
      '3': '3',
      '4': '4',
    };
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.gauge, color: AppTheme.duoBlue, size: 28),
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
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: context.colors.shadow,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: context.colors.outline),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: options.containsKey(_genConcurrency) ? _genConcurrency : 'auto',
                dropdownColor: context.colors.surface,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
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

  void _openTestAiDialog([String? provider]) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: TestAiDialog(
          geminiKeys: _keys,
          modelPrimaryText: _modelPrimaryText,
          modelPrimaryGraphics: _modelPrimaryGraphics,
          modelLite: _modelLite,
          modelLive: _modelLive,
          groqKeys: _groqKeys,
          groqModelPrimaryText: _groqModelPrimaryText,
          groqModelPrimaryGraphics: _groqModelPrimaryGraphics,
          groqModelLite: _groqModelLite,
          groqModelLive: _groqModelLive,
          cerebrasKeys: _cerebrasKeys,
          cerebrasModelPrimaryText: _cerebrasModelPrimaryText,
          cerebrasModelPrimaryGraphics: _cerebrasModelPrimaryGraphics,
          cerebrasModelLite: _cerebrasModelLite,
          cerebrasModelLive: _cerebrasModelLive,
          openrouterKeys: _openrouterKeys,
          openrouterModelPrimaryText: _openrouterModelPrimaryText,
          openrouterModelPrimaryGraphics: _openrouterModelPrimaryGraphics,
          openrouterModelLite: _openrouterModelLite,
          openrouterModelLive: _openrouterModelLive,
          initialProvider: provider,
        ),
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

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: AppBar(
          title: const Text(
            'AI Providers & Models',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: TextButton.icon(
                onPressed: () => _openTestAiDialog(),
                icon: const Icon(LucideIcons.bot, color: AppTheme.duoBlue, size: 18),
                label: const Text(
                  'TEST AI',
                  style: TextStyle(
                    color: AppTheme.duoBlue,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                onPressed: () async {
                  await _saveSettings();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('AI Configuration saved successfully!')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: AppTheme.duoGreen,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: AppTheme.duoBlue,
            labelColor: AppTheme.duoBlue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Gemini'),
              Tab(text: 'Groq'),
              Tab(text: 'Cerebras'),
              Tab(text: 'OpenRouter'),
              Tab(text: 'Concurrency'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Gemini Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                  SizedBox(height: 16),
                  StringListManager(
                    key: _keysManagerKey,
                    initialItems: _keys,
                    hintText: 'Enter Gemini API Key',
                    itemIcon: LucideIcons.key,
                    onChanged: (newKeys) => setState(() => _keys = newKeys),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'AI Model Fallbacks (Gemini)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Models are evaluated top-to-bottom. If the first model fails or rate-limits, we automatically fallback to the next.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  _buildModelSlotCard(
                    title: 'Primary - Text',
                    subtitle: 'Generates final interactive lessons & quizzes.',
                    slotName: 'Primary - Text',
                    icon: LucideIcons.fileText,
                  ),
                  _buildModelSlotCard(
                    title: 'Primary - Graphics',
                    subtitle: 'Generates canvas diagrams for lessons & proofs.',
                    slotName: 'Primary - Graphics',
                    icon: LucideIcons.image,
                  ),
                  _buildModelSlotCard(
                    title: 'Lite',
                    subtitle: 'Creates skeletons and maps lesson plan lists.',
                    slotName: 'Lite',
                    icon: LucideIcons.zap,
                  ),
                  _buildModelSlotCard(
                    title: 'Live',
                    subtitle: 'Real-time live model for chat & voice assistance.',
                    slotName: 'Live',
                    icon: LucideIcons.mic,
                  ),
                ],
              ),
            ),
            // Groq Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'API Keys (Groq)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add Groq keys to fall back automatically when Gemini rate-limits.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  StringListManager(
                    key: _groqKeysManagerKey,
                    initialItems: _groqKeys,
                    hintText: 'Enter Groq API Key',
                    itemIcon: LucideIcons.key,
                    onChanged: (newKeys) => setState(() => _groqKeys = newKeys),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'AI Model Fallbacks (Groq)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fallback models evaluated top-to-bottom for Groq integration.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  _buildModelSlotCard(
                    title: 'Groq - Primary - Text',
                    subtitle: 'Fallback model for lessons & quizzes.',
                    slotName: 'Groq - Primary - Text',
                    icon: LucideIcons.fileText,
                  ),
                  _buildModelSlotCard(
                    title: 'Groq - Primary - Graphics',
                    subtitle: 'Fallback model for canvas diagrams & proofs.',
                    slotName: 'Groq - Primary - Graphics',
                    icon: LucideIcons.image,
                  ),
                  _buildModelSlotCard(
                    title: 'Groq - Lite',
                    subtitle: 'Fallback model for skeletons and outlines.',
                    slotName: 'Groq - Lite',
                    icon: LucideIcons.zap,
                  ),
                  _buildModelSlotCard(
                    title: 'Groq - Live',
                    subtitle: 'Fallback model for live voice & chat assistance.',
                    slotName: 'Groq - Live',
                    icon: LucideIcons.mic,
                  ),
                ],
              ),
            ),
            // Cerebras Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'API Keys (Cerebras)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add Cerebras keys to fall back automatically when Gemini and Groq rate-limit.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  StringListManager(
                    key: _cerebrasKeysManagerKey,
                    initialItems: _cerebrasKeys,
                    hintText: 'Enter Cerebras API Key',
                    itemIcon: LucideIcons.key,
                    onChanged: (newKeys) => setState(() => _cerebrasKeys = newKeys),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'AI Model Fallbacks (Cerebras)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fallback models evaluated top-to-bottom for Cerebras integration.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  _buildModelSlotCard(
                    title: 'Cerebras - Primary - Text',
                    subtitle: 'Fallback model for lessons & quizzes.',
                    slotName: 'Cerebras - Primary - Text',
                    icon: LucideIcons.fileText,
                  ),
                  _buildModelSlotCard(
                    title: 'Cerebras - Primary - Graphics',
                    subtitle: 'Fallback model for canvas diagrams & proofs.',
                    slotName: 'Cerebras - Primary - Graphics',
                    icon: LucideIcons.image,
                  ),
                  _buildModelSlotCard(
                    title: 'Cerebras - Lite',
                    subtitle: 'Fallback model for skeletons and outlines.',
                    slotName: 'Cerebras - Lite',
                    icon: LucideIcons.zap,
                  ),
                  _buildModelSlotCard(
                    title: 'Cerebras - Live',
                    subtitle: 'Fallback model for live voice & chat assistance.',
                    slotName: 'Cerebras - Live',
                    icon: LucideIcons.mic,
                  ),
                ],
              ),
            ),
            // OpenRouter Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'API Keys (OpenRouter)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add OpenRouter keys to fall back automatically when Gemini, Groq, and Cerebras rate-limit.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  StringListManager(
                    key: _openrouterKeysManagerKey,
                    initialItems: _openrouterKeys,
                    hintText: 'Enter OpenRouter API Key',
                    itemIcon: LucideIcons.key,
                    onChanged: (newKeys) => setState(() => _openrouterKeys = newKeys),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'AI Model Fallbacks (OpenRouter)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fallback models evaluated top-to-bottom for OpenRouter integration.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  _buildModelSlotCard(
                    title: 'OpenRouter - Primary - Text',
                    subtitle: 'Fallback model for lessons & quizzes.',
                    slotName: 'OpenRouter - Primary - Text',
                    icon: LucideIcons.fileText,
                  ),
                  _buildModelSlotCard(
                    title: 'OpenRouter - Primary - Graphics',
                    subtitle: 'Fallback model for canvas diagrams & proofs.',
                    slotName: 'OpenRouter - Primary - Graphics',
                    icon: LucideIcons.image,
                  ),
                  _buildModelSlotCard(
                    title: 'OpenRouter - Lite',
                    subtitle: 'Fallback model for skeletons and outlines.',
                    slotName: 'OpenRouter - Lite',
                    icon: LucideIcons.zap,
                  ),
                  _buildModelSlotCard(
                    title: 'OpenRouter - Live',
                    subtitle: 'Fallback model for live voice & chat assistance.',
                    slotName: 'OpenRouter - Live',
                    icon: LucideIcons.mic,
                  ),
                ],
              ),
            ),
            // Concurrency Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Concurrency settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Configure request concurrency limits for content generation. Lowering this reduces rate-limiting errors.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  _buildConcurrencyCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestAiChatMessage {
  final String sender; // 'user', 'ai', 'error'
  final String text;
  final int? latencyMs;
  final DateTime timestamp;

  TestAiChatMessage({
    required this.sender,
    required this.text,
    this.latencyMs,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class TestAiDialog extends StatefulWidget {
  final List<String> geminiKeys;
  final List<String> modelPrimaryText;
  final List<String> modelPrimaryGraphics;
  final List<String> modelLite;
  final List<String> modelLive;

  final List<String> groqKeys;
  final List<String> groqModelPrimaryText;
  final List<String> groqModelPrimaryGraphics;
  final List<String> groqModelLite;
  final List<String> groqModelLive;

  final List<String> cerebrasKeys;
  final List<String> cerebrasModelPrimaryText;
  final List<String> cerebrasModelPrimaryGraphics;
  final List<String> cerebrasModelLite;
  final List<String> cerebrasModelLive;

  final List<String> openrouterKeys;
  final List<String> openrouterModelPrimaryText;
  final List<String> openrouterModelPrimaryGraphics;
  final List<String> openrouterModelLite;
  final List<String> openrouterModelLive;

  final String? initialProvider;

  const TestAiDialog({
    super.key,
    required this.geminiKeys,
    required this.modelPrimaryText,
    required this.modelPrimaryGraphics,
    required this.modelLite,
    required this.modelLive,
    required this.groqKeys,
    required this.groqModelPrimaryText,
    required this.groqModelPrimaryGraphics,
    required this.groqModelLite,
    required this.groqModelLive,
    required this.cerebrasKeys,
    required this.cerebrasModelPrimaryText,
    required this.cerebrasModelPrimaryGraphics,
    required this.cerebrasModelLite,
    required this.cerebrasModelLive,
    required this.openrouterKeys,
    required this.openrouterModelPrimaryText,
    required this.openrouterModelPrimaryGraphics,
    required this.openrouterModelLite,
    required this.openrouterModelLive,
    this.initialProvider,
  });

  @override
  State<TestAiDialog> createState() => _TestAiDialogState();
}

class _TestAiDialogState extends State<TestAiDialog> {
  late String _selectedProvider;
  String _selectedSlot = 'Primary - Text';
  String _selectedModel = '';
  final TextEditingController _customModelController = TextEditingController();
  bool _isCustomModel = false;

  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<TestAiChatMessage> _messages = [];
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _selectedProvider = widget.initialProvider ?? 'Google Gemini';
    _updateSelectedModel();
  }

  @override
  void dispose() {
    _customModelController.dispose();
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<String> _getAvailableModels() {
    switch (_selectedProvider) {
      case 'Google Gemini':
        switch (_selectedSlot) {
          case 'Primary - Text': return widget.modelPrimaryText;
          case 'Primary - Graphics': return widget.modelPrimaryGraphics;
          case 'Lite': return widget.modelLite;
          case 'Live': return widget.modelLive;
          default: return widget.modelPrimaryText;
        }
      case 'Groq':
        switch (_selectedSlot) {
          case 'Primary - Text': return widget.groqModelPrimaryText;
          case 'Primary - Graphics': return widget.groqModelPrimaryGraphics;
          case 'Lite': return widget.groqModelLite;
          case 'Live': return widget.groqModelLive;
          default: return widget.groqModelPrimaryText;
        }
      case 'Cerebras':
        switch (_selectedSlot) {
          case 'Primary - Text': return widget.cerebrasModelPrimaryText;
          case 'Primary - Graphics': return widget.cerebrasModelPrimaryGraphics;
          case 'Lite': return widget.cerebrasModelLite;
          case 'Live': return widget.cerebrasModelLive;
          default: return widget.cerebrasModelPrimaryText;
        }
      case 'OpenRouter':
        switch (_selectedSlot) {
          case 'Primary - Text': return widget.openrouterModelPrimaryText;
          case 'Primary - Graphics': return widget.openrouterModelPrimaryGraphics;
          case 'Lite': return widget.openrouterModelLite;
          case 'Live': return widget.openrouterModelLive;
          default: return widget.openrouterModelPrimaryText;
        }
      default:
        return [];
    }
  }

  void _updateSelectedModel() {
    final models = _getAvailableModels();
    if (models.isNotEmpty) {
      _selectedModel = models.first;
      _isCustomModel = false;
    } else {
      _selectedModel = '';
      _isCustomModel = true;
    }
  }

  Future<List<String>> _resolveKeysForProvider(String provider) async {
    List<String> keys = [];

    if (provider == 'Google Gemini') {
      keys = widget.geminiKeys.where((k) => k.trim().isNotEmpty).toList();
      if (keys.isNotEmpty) return keys;

      final secretKeys = await SecretsService.instance.geminiKeys();
      if (secretKeys.isNotEmpty) return secretKeys;

      final dbSettings = await DatabaseService().fetchUserSettings();
      final dbKeys = (dbSettings?['apiKeys'] as List?)?.map((e) => e.toString().trim()).where((e) => e.isNotEmpty).toList() ?? [];
      if (dbKeys.isNotEmpty) return dbKeys;

      final prefs = await SharedPreferences.getInstance();
      final prefKeys = prefs.getStringList('gemini_api_keys_list') ?? [];
      if (prefKeys.isNotEmpty) return prefKeys;
      final scalarKey = prefs.getString('gemini_api_keys');
      if (scalarKey != null && scalarKey.trim().isNotEmpty) return [scalarKey.trim()];
    } else if (provider == 'Groq') {
      keys = widget.groqKeys.where((k) => k.trim().isNotEmpty).toList();
      if (keys.isNotEmpty) return keys;

      final secretKeys = await SecretsService.instance.groqKeys();
      if (secretKeys.isNotEmpty) return secretKeys;

      final dbSettings = await DatabaseService().fetchUserSettings();
      final dbKeys = (dbSettings?['groqApiKeys'] as List?)?.map((e) => e.toString().trim()).where((e) => e.isNotEmpty).toList() ?? [];
      if (dbKeys.isNotEmpty) return dbKeys;

      final prefs = await SharedPreferences.getInstance();
      final prefKeys = prefs.getStringList('groq_api_keys_list') ?? [];
      if (prefKeys.isNotEmpty) return prefKeys;
      final scalarKey = prefs.getString('groq_api_keys');
      if (scalarKey != null && scalarKey.trim().isNotEmpty) return [scalarKey.trim()];
    } else if (provider == 'Cerebras') {
      keys = widget.cerebrasKeys.where((k) => k.trim().isNotEmpty).toList();
      if (keys.isNotEmpty) return keys;

      final secretKeys = await SecretsService.instance.cerebrasKeys();
      if (secretKeys.isNotEmpty) return secretKeys;

      final dbSettings = await DatabaseService().fetchUserSettings();
      final dbKeys = (dbSettings?['cerebrasApiKeys'] as List?)?.map((e) => e.toString().trim()).where((e) => e.isNotEmpty).toList() ?? [];
      if (dbKeys.isNotEmpty) return dbKeys;

      final prefs = await SharedPreferences.getInstance();
      final prefKeys = prefs.getStringList('cerebras_api_keys_list') ?? [];
      if (prefKeys.isNotEmpty) return prefKeys;
      final scalarKey = prefs.getString('cerebras_api_keys');
      if (scalarKey != null && scalarKey.trim().isNotEmpty) return [scalarKey.trim()];
    } else if (provider == 'OpenRouter') {
      keys = widget.openrouterKeys.where((k) => k.trim().isNotEmpty).toList();
      if (keys.isNotEmpty) return keys;

      final secretKeys = await SecretsService.instance.openrouterKeys();
      if (secretKeys.isNotEmpty) return secretKeys;

      final dbSettings = await DatabaseService().fetchUserSettings();
      final dbKeys = (dbSettings?['openrouterApiKeys'] as List?)?.map((e) => e.toString().trim()).where((e) => e.isNotEmpty).toList() ?? [];
      if (dbKeys.isNotEmpty) return dbKeys;

      final prefs = await SharedPreferences.getInstance();
      final prefKeys = prefs.getStringList('openrouter_api_keys_list') ?? [];
      if (prefKeys.isNotEmpty) return prefKeys;
      final scalarKey = prefs.getString('openrouter_api_keys');
      if (scalarKey != null && scalarKey.trim().isNotEmpty) return [scalarKey.trim()];
    }

    return [];
  }

  Future<void> _sendMessage([String? overrideText]) async {
    final text = (overrideText ?? _inputController.text).trim();
    if (text.isEmpty || _isGenerating) return;

    final targetModel = _isCustomModel ? _customModelController.text.trim() : _selectedModel;
    if (targetModel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select or specify a model to test.')),
      );
      return;
    }

    _inputController.clear();
    setState(() {
      _messages.add(TestAiChatMessage(sender: 'user', text: text));
      _isGenerating = true;
    });

    _scrollToBottom();

    final stopwatch = Stopwatch()..start();

    try {
      String responseText = '';

      final keys = await _resolveKeysForProvider(_selectedProvider);
      if (keys.isEmpty) {
        throw Exception('No $_selectedProvider API keys found in local settings, database, or shared secrets. Please add an API key in Settings.');
      }
      final apiKey = keys.first;

      if (_selectedProvider == 'Google Gemini') {
        final model = GenerativeModel(
          model: targetModel,
          apiKey: apiKey,
        );
        final res = await model.generateContent([Content.text(text)]);
        responseText = res.text ?? 'Empty response from Gemini.';
      } else if (_selectedProvider == 'Groq') {
        final res = await http.post(
          Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'model': targetModel,
            'messages': [{'role': 'user', 'content': text}],
          }),
        ).timeout(const Duration(seconds: 30));
        if (res.statusCode != 200) {
          throw Exception('Groq API HTTP Error (${res.statusCode}):\n${res.body}');
        }
        final data = jsonDecode(res.body);
        responseText = data['choices']?[0]?['message']?['content'] ?? 'No text returned from Groq.';
      } else if (_selectedProvider == 'Cerebras') {
        final res = await http.post(
          Uri.parse('https://api.cerebras.ai/v1/chat/completions'),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'model': targetModel,
            'messages': [{'role': 'user', 'content': text}],
          }),
        ).timeout(const Duration(seconds: 30));
        if (res.statusCode != 200) {
          throw Exception('Cerebras API HTTP Error (${res.statusCode}):\n${res.body}');
        }
        final data = jsonDecode(res.body);
        responseText = data['choices']?[0]?['message']?['content'] ?? 'No text returned from Cerebras.';
      } else if (_selectedProvider == 'OpenRouter') {
        final res = await http.post(
          Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
            'HTTP-Referer': 'https://duofy.app',
            'X-Title': 'Duofy',
          },
          body: jsonEncode({
            'model': targetModel,
            'messages': [{'role': 'user', 'content': text}],
          }),
        ).timeout(const Duration(seconds: 30));
        if (res.statusCode != 200) {
          throw Exception('OpenRouter API HTTP Error (${res.statusCode}):\n${res.body}');
        }
        final data = jsonDecode(res.body);
        responseText = data['choices']?[0]?['message']?['content'] ?? 'No text returned from OpenRouter.';
      }

      stopwatch.stop();
      if (mounted) {
        setState(() {
          _messages.add(TestAiChatMessage(
            sender: 'ai',
            text: responseText,
            latencyMs: stopwatch.elapsedMilliseconds,
          ));
          _isGenerating = false;
        });
        _scrollToBottom();
      }
    } catch (e, st) {
      stopwatch.stop();
      if (mounted) {
        setState(() {
          _messages.add(TestAiChatMessage(
            sender: 'error',
            text: 'ERROR LOG DETAILS:\n$e\n\nSTACK TRACE:\n$st',
            latencyMs: stopwatch.elapsedMilliseconds,
          ));
          _isGenerating = false;
        });
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableModels = _getAvailableModels();

    return Container(
      width: 720,
      height: 720,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.duoBlue.withValues(alpha: 0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: context.colors.surfaceAlt,
              borderRadius: BorderRadius.vertical(top: Radius.circular(23)),
              border: Border(bottom: BorderSide(color: context.colors.outline)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.duoBlue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(LucideIcons.bot, color: AppTheme.duoBlue, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Model Test & Debugger',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Test providers, AI types, and models with real-time error logs',
                        style: TextStyle(color: context.colors.textFaint, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(LucideIcons.x, color: context.colors.textSecondary),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Provider & Slot Selectors
          Container(
            padding: EdgeInsets.all(14),
            color: context.colors.background,
            child: Column(
              children: [
                Row(
                  children: [
                    // Provider Dropdown
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PROVIDER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: context.colors.textFaint)),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: context.colors.surfaceAlt,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: context.colors.outline),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedProvider,
                                dropdownColor: context.colors.surface,
                                style: TextStyle(color: context.colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 12),
                                items: const [
                                  DropdownMenuItem(value: 'Google Gemini', child: Text('Google Gemini')),
                                  DropdownMenuItem(value: 'Groq', child: Text('Groq')),
                                  DropdownMenuItem(value: 'Cerebras', child: Text('Cerebras')),
                                  DropdownMenuItem(value: 'OpenRouter', child: Text('OpenRouter')),
                                ],
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _selectedProvider = val;
                                      _updateSelectedModel();
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    // Slot / AI Type Dropdown
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AI TYPE / SLOT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: context.colors.textFaint)),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: context.colors.surfaceAlt,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: context.colors.outline),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSlot,
                                dropdownColor: context.colors.surface,
                                style: TextStyle(color: context.colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 12),
                                items: const [
                                  DropdownMenuItem(value: 'Primary - Text', child: Text('Primary - Text')),
                                  DropdownMenuItem(value: 'Primary - Graphics', child: Text('Primary - Graphics')),
                                  DropdownMenuItem(value: 'Lite', child: Text('Lite')),
                                  DropdownMenuItem(value: 'Live', child: Text('Live')),
                                ],
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _selectedSlot = val;
                                      _updateSelectedModel();
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Model Dropdown
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SELECT MODEL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: context.colors.textFaint)),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: context.colors.surfaceAlt,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: context.colors.outline),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _isCustomModel ? 'custom' : (_selectedModel.isEmpty ? null : _selectedModel),
                                dropdownColor: context.colors.surface,
                                style: const TextStyle(color: Colors.amber, fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 12),
                                items: [
                                  for (final m in availableModels)
                                    DropdownMenuItem(value: m, child: Text(m)),
                                  const DropdownMenuItem(value: 'custom', child: Text('+ Enter Custom Model...')),
                                ],
                                onChanged: (val) {
                                  if (val == 'custom') {
                                    setState(() {
                                      _isCustomModel = true;
                                    });
                                  } else if (val != null) {
                                    setState(() {
                                      _selectedModel = val;
                                      _isCustomModel = false;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_isCustomModel) ...[
                  SizedBox(height: 8),
                  TextField(
                    controller: _customModelController,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.amber),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Enter custom model identifier (e.g. meta-llama/llama-3.3-70b-instruct)',
                      hintStyle: TextStyle(color: context.colors.textFaint, fontSize: 11),
                      filled: true,
                      fillColor: context.colors.surfaceAlt,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Messages List
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.sparkles, color: AppTheme.duoBlue.withValues(alpha: 0.5), size: 36),
                          SizedBox(height: 12),
                          Text(
                            'Ready to test $_selectedProvider ($_selectedSlot)',
                            style: TextStyle(fontWeight: FontWeight.bold, color: context.colors.textSecondary, fontSize: 14),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Click a prompt below or type your own test prompt.',
                            style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ActionChip(
                                label: const Text('Hello! Verify model connection'),
                                onPressed: () => _sendMessage('Hello! Verify provider and model connectivity.'),
                              ),
                              ActionChip(
                                label: const Text('Explain 1+1'),
                                onPressed: () => _sendMessage('Explain why 1+1=2 in 1 sentence.'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(14),
                    itemCount: _messages.length,
                    itemBuilder: (context, i) {
                      final msg = _messages[i];
                      final isUser = msg.sender == 'user';
                      final isError = msg.sender == 'error';

                      if (isError) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFF450A0A),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.duoRed, width: 1.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(LucideIcons.alertTriangle, color: AppTheme.duoRed, size: 16),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'MODEL TEST ERROR LOG',
                                    style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.bold, fontSize: 11),
                                  ),
                                  Spacer(),
                                  if (msg.latencyMs != null)
                                    Text('${msg.latencyMs}ms', style: TextStyle(color: context.colors.textFaint, fontSize: 10)),
                                  IconButton(
                                    icon: Icon(LucideIcons.copy, color: context.colors.textSecondary, size: 14),
                                    tooltip: 'Copy Error Log',
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: msg.text));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Error log copied to clipboard!')),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              SelectableText(
                                msg.text,
                                style: const TextStyle(fontFamily: 'monospace', fontSize: 11.5, color: AppTheme.duoRed),
                              ),
                            ],
                          ),
                        );
                      }

                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                          decoration: BoxDecoration(
                            color: isUser ? AppTheme.duoBlue : context.colors.surfaceAlt,
                            borderRadius: BorderRadius.circular(14),
                            border: isUser ? null : Border.all(color: context.colors.outline),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isUser && msg.latencyMs != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    '⚡ ${msg.latencyMs}ms',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.duoGreen),
                                  ),
                                ),
                              SelectableText(
                                msg.text,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isUser ? Colors.white : context.colors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Bottom Input Bar
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.colors.surfaceAlt,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(23)),
              border: Border(top: BorderSide(color: context.colors.outline)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    enabled: !_isGenerating,
                    style: TextStyle(fontSize: 13, color: context.colors.textPrimary),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Type a test prompt (e.g. Test model output)...',
                      hintStyle: TextStyle(color: context.colors.textFaint, fontSize: 12),
                      filled: true,
                      fillColor: context.colors.background,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    ),
                    onSubmitted: (val) => _sendMessage(val),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: _isGenerating
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.duoGreen))
                      : const Icon(LucideIcons.send, color: AppTheme.duoBlue),
                  onPressed: _isGenerating ? null : () => _sendMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}