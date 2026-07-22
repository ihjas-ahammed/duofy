import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../theme/app_theme.dart';
import '../services/database_service.dart';
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
      margin: const EdgeInsets.only(bottom: 16),
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                    const SizedBox(width: 12),
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
                                      const SizedBox(width: 6),
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
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
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
                child: const Text(
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
                    'AI Model Fallbacks (Gemini)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Models are evaluated top-to-bottom. If the first model fails or rate-limits, we automatically fallback to the next.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
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
                    'AI Model Fallbacks (Groq)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fallback models evaluated top-to-bottom for Groq integration.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
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
                    'AI Model Fallbacks (Cerebras)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fallback models evaluated top-to-bottom for Cerebras integration.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
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
                    'AI Model Fallbacks (OpenRouter)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fallback models evaluated top-to-bottom for OpenRouter integration.',
                    style: TextStyle(color: context.colors.textFaint, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
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
