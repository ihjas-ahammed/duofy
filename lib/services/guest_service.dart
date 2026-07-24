import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_service.dart';
import 'global_state.dart';
import 'secrets_service.dart';

/// Manages unique guest sessions and session resets.
class GuestService {
  GuestService._();
  static final GuestService instance = GuestService._();

  static const String _prefKeyGuestId = 'guest_session_id';
  String? _cachedGuestId;

  /// Gets the current unique guest session ID.
  /// If none exists in SharedPreferences or memory, a new unique ID is generated.
  Future<String> getGuestId() async {
    if (_cachedGuestId != null && _cachedGuestId!.isNotEmpty) {
      return _cachedGuestId!;
    }
    final prefs = await SharedPreferences.getInstance();
    String? storedId = prefs.getString(_prefKeyGuestId);
    if (storedId == null || storedId.isEmpty) {
      storedId = _generateUniqueGuestId();
      await prefs.setString(_prefKeyGuestId, storedId);
    }
    _cachedGuestId = storedId;
    return storedId;
  }

  /// Synchronous getter for guest ID with in-memory fallback.
  String get guestIdSync {
    if (_cachedGuestId != null && _cachedGuestId!.isNotEmpty) {
      return _cachedGuestId!;
    }
    final newId = _generateUniqueGuestId();
    _cachedGuestId = newId;
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString(_prefKeyGuestId) == null) {
        prefs.setString(_prefKeyGuestId, newId);
      }
    });
    return newId;
  }

  /// Generates a unique guest session ID e.g. guest_1721859000000_123456
  String _generateUniqueGuestId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomPart = Random().nextInt(900000) + 100000;
    return 'guest_${timestamp}_$randomPart';
  }

  /// Short display label for the current guest session (e.g. #123456)
  String getGuestIdShort() {
    final id = guestIdSync;
    final parts = id.split('_');
    if (parts.length >= 3) {
      return '#${parts.last}';
    }
    return '#${id.length > 6 ? id.substring(id.length - 6) : id}';
  }

  /// Checks if a given UID represents a guest session.
  static bool isGuestId(String? uid) {
    if (uid == null || uid.isEmpty) return true;
    return uid == 'guest' || uid.startsWith('guest_') || uid.startsWith('guest');
  }

  /// Resets the guest session: generates a new unique guest session ID,
  /// clears guest state, re-seeds local database, and reloads secrets.
  Future<String> resetGuestSession() async {
    final newGuestId = _generateUniqueGuestId();
    _cachedGuestId = newGuestId;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKeyGuestId, newGuestId);

    // Clear cached secrets so they can re-fetch
    SecretsService.instance.clear();

    // Reset XP and guest states
    GlobalState.xpNotifier.value = 0;

    // Reload database for new guest UID
    await DatabaseService().fetchBooks();

    return newGuestId;
  }
}