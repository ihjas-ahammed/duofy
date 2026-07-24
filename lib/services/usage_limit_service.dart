import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fb/fb_auth.dart';
import 'fb/fb_firestore.dart';

class UsageLimitService {
  UsageLimitService._();
  static final UsageLimitService instance = UsageLimitService._();

  // Default daily request count (capacity) for our free keys per model
  static const Map<String, int> defaultCapacityLimits = {
    // Gemini Flash / Lite models
    'gemini-3.5-flash': 1500,
    'gemini-3-flash-preview': 1500,
    'gemini-2.5-flash': 1500,
    'gemini-flash-lite-latest': 1500,
    'gemini-3.1-flash-lite': 1500,
    'gemini-3.1-flash-lite-preview': 1500,
    'gemini-2.5-flash-lite': 1500,
    'gemini-2.0-flash-lite': 1500,
    'google/gemini-2.5-flash': 1500,

    // Gemini Pro / Live models
    'gemini-3.1-flash-live-preview': 50,
    'google/gemini-2.5-pro': 50,

    // Groq models
    'llama-3.3-70b-versatile': 14400,
    'llama-3.1-8b-instant': 14400,
    'groq/compound': 14400,
    'groq/compound-mini': 14400,

    // Cerebras models
    'llama-3.3-70b': 14400,
    'llama-3.1-8b': 14400,
    'llama-3.1-70b': 14400,

    // OpenRouter models
    'meta-llama/llama-3.3-70b-instruct': 200,
    'meta-llama/llama-3.1-8b-instruct': 200,
    'google/gemma-2-9b-it:free': 1500,
    'gemma-4-26b-a4b-it': 1500,
    'gemma-4-31b-it': 1500,
    'gemma4': 1500,
  };

  int _dailyActiveUsers = 1;
  final Map<String, int> _capacityLimits = Map.from(defaultCapacityLimits);
  SharedPreferences? _prefs;

  int get dailyActiveUsers => _dailyActiveUsers;

  // Initialize: register active user and fetch limits from Firebase
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final prefs = _prefs!;
    
    // Generate/retrieve a unique user ID for daily active tracking
    String? localUserId = prefs.getString('usage_limit_local_uid');
    if (localUserId == null) {
      localUserId = 'usr_${DateTime.now().millisecondsSinceEpoch}_${StackTrace.current.hashCode}';
      await prefs.setString('usage_limit_local_uid', localUserId);
    }
    
    final uid = FbAuth.instance.currentUser?.uid ?? localUserId;
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);
    
    // Reset local usage counts if day has changed
    final lastUsageDate = prefs.getString('usage_limit_last_date');
    if (lastUsageDate != todayStr) {
      await _resetLocalUsage(prefs, todayStr);
    }

    // Local-first: seed limits from cache/defaults immediately so startup never
    // blocks (or hangs offline) on a network round-trip. The Firebase refresh
    // runs in the background and updates these in place when it lands.
    _dailyActiveUsers = prefs.getInt('usage_limit_cached_users') ?? 1;
    for (final key in defaultCapacityLimits.keys) {
      _capacityLimits[key] =
          prefs.getInt('usage_limit_cached_capacity_$key') ??
          defaultCapacityLimits[key]!;
    }

    // Fire-and-forget: presence + capacity stats sync, off the startup path.
    unawaited(_syncWithBackend(prefs, uid, todayStr));
  }

  /// Background refresh of daily-active-user count and capacity limits. Never
  /// awaited by [init], so an offline or slow network can't delay app launch.
  Future<void> _syncWithBackend(
    SharedPreferences prefs,
    String uid,
    String todayStr,
  ) async {
    try {
      final db = FbFirestore.instance;

      // 1. Register presence in subcollection: usage_stats/day_$todayStr/users/$uid
      await db
          .collection('usage_stats')
          .doc('day_$todayStr')
          .collection('users')
          .doc(uid)
          .set({'timestamp': DateTime.now().millisecondsSinceEpoch});

      // 2. Fetch all daily active users for today
      final usersSnap = await db
          .collection('usage_stats')
          .doc('day_$todayStr')
          .collection('users')
          .get();
      _dailyActiveUsers = usersSnap.docs.isNotEmpty ? usersSnap.docs.length : 1;

      // 3. Fetch configured global request capacity limits from usage_stats/config
      final configSnap = await db.collection('usage_stats').doc('config').get();
      if (configSnap.exists) {
        final data = configSnap.data();
        if (data != null) {
          data.forEach((key, value) {
            if (value is num) {
              _capacityLimits[key] = value.toInt();
            }
          });
        }
      }

      // Save fetched stats to local cache for offline use
      await prefs.setInt('usage_limit_cached_users', _dailyActiveUsers);
      _capacityLimits.forEach((key, val) async {
        await prefs.setInt('usage_limit_cached_capacity_$key', val);
      });
    } catch (e) {
      debugPrint('[UsageLimitService] Failed to sync limits with Firebase: $e');
      // Cached/default values from init() stay in place.
    }
  }

  Future<void> _resetLocalUsage(SharedPreferences prefs, String todayStr) async {
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith('usage_limit_count_')) {
        await prefs.remove(key);
      }
    }
    await prefs.setString('usage_limit_last_date', todayStr);
  }

  // Check how many own API keys are configured synchronously
  int getKeysCount(String platform) {
    if (_prefs == null) return 0;
    final plat = platform.toLowerCase();
    List<String> list = [];
    String scalar = '';

    if (plat == 'gemini') {
      list = _prefs!.getStringList('gemini_api_keys_list') ?? [];
      scalar = _prefs!.getString('gemini_api_keys') ?? '';
    } else if (plat == 'groq') {
      list = _prefs!.getStringList('groq_api_keys_list') ?? [];
      scalar = _prefs!.getString('groq_api_keys') ?? '';
    } else if (plat == 'cerebras') {
      list = _prefs!.getStringList('cerebras_api_keys_list') ?? [];
      scalar = _prefs!.getString('cerebras_api_keys') ?? '';
    } else if (plat == 'openrouter') {
      list = _prefs!.getStringList('openrouter_api_keys_list') ?? [];
      scalar = _prefs!.getString('openrouter_api_keys') ?? '';
    }

    if (list.isNotEmpty) return list.length;
    if (scalar.trim().isNotEmpty) {
      return scalar.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).length;
    }
    return 0;
  }

  // Check if own API key is configured for a platform synchronously
  bool hasOwnApiKeySync(String platform) {
    return getKeysCount(platform) > 0;
  }

  // Check if own API key is configured for a platform (async fallback)
  Future<bool> hasOwnApiKey(String platform) async {
    return hasOwnApiKeySync(platform);
  }

  // Get platform name for a model
  String getPlatformOfModel(String modelName) {
    final name = modelName.toLowerCase();
    if (name.contains('groq') || name.contains('llama-3.3-70b-versatile') || name.contains('llama-3.1-8b-instant') || name.contains('compound')) {
      return 'groq';
    } else if (name.contains('cerebras') || (name.contains('llama') && !name.contains('groq') && !name.contains('instruct'))) {
      if (name == 'llama-3.3-70b' || name == 'llama-3.1-8b' || name == 'llama-3.1-70b') {
        return 'cerebras';
      }
    } else if (name.contains('openrouter') || name.contains('instruct') || name.contains('google/gemini-')) {
      return 'openrouter';
    }
    return 'gemini';
  }

  // Get platform-specific raw capacity limit for a model
  int getCapacity(String modelName) {
    if (_capacityLimits.containsKey(modelName)) {
      return _capacityLimits[modelName]!;
    }
    if (defaultCapacityLimits.containsKey(modelName)) {
      return defaultCapacityLimits[modelName]!;
    }
    // Dynamic fallbacks based on model names
    final lower = modelName.toLowerCase();
    if (lower.contains('flash-lite')) {
      return 1500;
    }
    if (lower.contains('flash')) {
      return 1500;
    }
    if (lower.contains('gemma')) {
      return 1500;
    }
    return 1500; // global fallback
  }

  // Get daily limit for a model (capacity * custom keys count, or capacity / daily active users)
  int getLimit(String modelName) {
    final capacity = getCapacity(modelName);
    final platform = getPlatformOfModel(modelName);
    final keyCount = getKeysCount(platform);

    if (keyCount > 0) {
      return capacity * keyCount;
    } else {
      return (capacity / _dailyActiveUsers).round();
    }
  }

  // Get current usage for a model today
  Future<int> getUsage(String modelName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('usage_limit_count_$modelName') ?? 0;
  }

  // Increment usage for a model
  Future<void> incrementUsage(String modelName) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await getUsage(modelName);
    await prefs.setInt('usage_limit_count_$modelName', current + 1);
  }

  // Check if limit is hit for a model
  Future<bool> isLimitExceeded(String modelName) async {
    final usage = await getUsage(modelName);
    final limit = getLimit(modelName);
    return usage >= limit;
  }

  // Check if all selected models in settings are rate limited/limits hit
  Future<bool> areAllLimitsHit(List<String> selectedModels) async {
    for (final model in selectedModels) {
      if (!await isLimitExceeded(model)) {
        return false;
      }
    }
    return true;
  }
}