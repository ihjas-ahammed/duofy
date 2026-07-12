import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'b2_service.dart' show B2Credentials;
import 'fb/fb_firestore.dart';

/// Runtime fetcher for the app's shared credentials, which live in the
/// Firestore document `secrets/apikeys` instead of being compiled into the
/// binary (a public web bundle would hand them to anyone; git history is
/// forever). Firestore rules restrict the document to authenticated users
/// and it is never writable from clients — see firestore.rules and
/// docs/SECURITY.md.
///
/// Document shape:
///   GENAI:      list (or comma string) of shared Gemini API keys
///   B2_KEY_ID / B2_APP_KEY / B2_BUCKET / B2_REGION: Backblaze document store
///
/// Values are cached in memory only, and dropped on sign-out via [clear].
class SecretsService {
  SecretsService._();
  static final SecretsService instance = SecretsService._();

  Map<String, dynamic>? _doc;
  bool _fetchFailed = false;

  Future<Map<String, dynamic>?> _load() async {
    if (_doc != null) return _doc;
    if (_fetchFailed) return null; // don't hammer Firestore when offline/denied
    try {
      final doc = await FbFirestore.instance.collection('secrets').doc('apikeys').get();
      if (doc.exists) {
        _doc = doc.data() ?? {};
        return _doc;
      }
      _fetchFailed = true;
    } catch (e) {
      debugPrint('[SecretsService] Failed to fetch shared secrets: $e');
      _fetchFailed = true;
    }
    return null;
  }

  /// Shared Gemini keys, or empty when unavailable (signed out, offline,
  /// rules denied). Callers treat empty as "user must supply their own key".
  Future<List<String>> geminiKeys() async {
    final data = await _load();
    final raw = data?['GENAI'];
    if (raw is List) {
      return raw
          .map((e) => e?.toString().trim() ?? '')
          .where((e) => e.isNotEmpty)
          .toList();
    }
    if (raw is String && raw.trim().isNotEmpty) {
      return raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    return const [];
  }

  /// Shared or user-supplied Groq keys, falling back to the global key.
  Future<List<String>> groqKeys() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getStringList('groq_api_keys_list') ?? [];
    if (keys.isEmpty) {
      final keysString = prefs.getString('groq_api_keys') ?? '';
      keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    if (keys.isNotEmpty) return keys;

    final data = await _load();
    final raw = data?['GROQ'];
    List<String> shared = [];
    if (raw is List) {
      shared = raw.map((e) => e?.toString().trim() ?? '').where((e) => e.isNotEmpty).toList();
    } else if (raw is String && raw.trim().isNotEmpty) {
      shared = raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    if (shared.isNotEmpty) return shared;

    return const [];
  }

  /// Shared or user-supplied Cerebras keys, falling back to the global key.
  Future<List<String>> cerebrasKeys() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getStringList('cerebras_api_keys_list') ?? [];
    if (keys.isEmpty) {
      final keysString = prefs.getString('cerebras_api_keys') ?? '';
      keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    if (keys.isNotEmpty) return keys;

    final data = await _load();
    final raw = data?['CEREBRAS'];
    List<String> shared = [];
    if (raw is List) {
      shared = raw.map((e) => e?.toString().trim() ?? '').where((e) => e.isNotEmpty).toList();
    } else if (raw is String && raw.trim().isNotEmpty) {
      shared = raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    if (shared.isNotEmpty) return shared;

    return const [];
  }

  /// Shared or user-supplied OpenRouter keys, falling back to the global key.
  Future<List<String>> openrouterKeys() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getStringList('openrouter_api_keys_list') ?? [];
    if (keys.isEmpty) {
      final keysString = prefs.getString('openrouter_api_keys') ?? '';
      keys = keysString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    if (keys.isNotEmpty) return keys;

    final data = await _load();
    final raw = data?['OPENROUTER'];
    List<String> shared = [];
    if (raw is List) {
      shared = raw.map((e) => e?.toString().trim() ?? '').where((e) => e.isNotEmpty).toList();
    } else if (raw is String && raw.trim().isNotEmpty) {
      shared = raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    if (shared.isNotEmpty) return shared;

    return const [];
  }

  /// Shared Backblaze credentials for the community document store, or null
  /// when unavailable — the store then shows its "not configured" state.
  Future<B2Credentials?> b2Credentials() async {
    final data = await _load();
    if (data == null) return null;
    final creds = B2Credentials(
      keyId: data['B2_KEY_ID']?.toString().trim() ?? '',
      applicationKey: data['B2_APP_KEY']?.toString().trim() ?? '',
      bucketName: data['B2_BUCKET']?.toString().trim() ?? '',
      region: data['B2_REGION']?.toString().trim() ?? '',
    );
    return creds.isValid ? creds : null;
  }

  /// Drops cached secrets (call on sign-out) and allows a fresh fetch on the
  /// next request (e.g. after signing back in).
  void clear() {
    _doc = null;
    _fetchFailed = false;
  }
}
