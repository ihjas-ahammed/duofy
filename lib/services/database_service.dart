import 'dart:async';
import 'dart:convert';
import '../platform/io_shim.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../data/mock_books.dart';
import '../utils/latex_utils.dart';
import 'guest_service.dart';
import 'fb/fb_auth.dart';
import 'fb/fb_firestore.dart';

/// Local-first storage.
///
/// Books are the source of truth **on the device**: each book is a single
/// JSON file under the app's documents directory, mirrored by an in-memory
/// map so reads are cheap and a per-lesson streaming save only rewrites that
/// one small file (not the whole library, as the old single-key
/// SharedPreferences cache did).
///
/// Cloud (Firestore) is an **optional backup/sync layer**, controlled by the
/// [cloudSyncPrefKey] setting and OFF by default. When disabled, no Firestore
/// reads or writes occur at all — the app works fully offline.
class DatabaseService {
  final FbFirestore _db = FbFirestore.instance;

  String get uid {
    final user = FbAuth.instance.currentUser;
    if (user != null) return user.uid;
    return GuestService.instance.guestIdSync;
  }

  static bool isGuestId(String? u) => GuestService.isGuestId(u);

  // ---------------------------------------------------------------------------
  // Cloud sync toggle (local-first: OFF unless the user opts in from Settings)
  // ---------------------------------------------------------------------------
  static const String cloudSyncPrefKey = 'cloud_sync_enabled';

  /// Whether cloud backup/sync is enabled. Defaults to true so every user
  /// gets cloud backup out of the box. Can be turned off in Settings.
  Future<bool> isCloudEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(cloudSyncPrefKey) ?? true;
  }

  Future<void> setCloudEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(cloudSyncPrefKey, enabled);
  }

  FbCollectionRef get _userBooks =>
      _db.collection('users').doc(uid).collection('books');

  FbCollectionRef get _globalBooks => _db.collection('global_books');

  FbDocRef get _userSettingsDoc =>
      _db.collection('users').doc(uid).collection('meta').doc('settings');

  /// Per-user learning state (completed lessons, XP, bookmarks). Kept separate
  /// from books so progress syncs cheaply without rewriting course content.
  FbDocRef get _userLearningDoc =>
      _db.collection('users').doc(uid).collection('meta').doc('learning');

  FbDocRef get _userFoldersDoc =>
      _db.collection('users').doc(uid).collection('meta').doc('folders');

  FbDocRef get _userMetacogDoc =>
      _db.collection('users').doc(uid).collection('meta').doc('metacognition');

  // ---------------------------------------------------------------------------
  // Learning state (progress + bookmarks) — optional cloud backup, gated by the
  // same local-first cloud toggle. No-ops for guests / when cloud is off.
  // ---------------------------------------------------------------------------

  /// Pushes the merged learning state to Firestore (background, non-blocking).
  /// Safe to call on every change — it short-circuits when cloud is disabled.
  /// Pushes the merged learning state to Firestore (background, non-blocking).
  /// Safe to call on every change — it short-circuits when cloud is disabled.
  Future<void> saveLearningState({
    required List<String> completedLessons,
    required int xp,
    required List<Map<String, dynamic>> bookmarks,
    List<String>? activities,
    Map<String, int>? courseXp,
    String? recentlyCompleted,
  }) async {
    if (isGuestId(uid)) return;
    if (!await isCloudEnabled()) return;
    _userLearningDoc.set({
      'completedLessons': completedLessons,
      'xp': xp,
      'bookmarks': bookmarks,
      if (activities != null) 'activities': activities,
      if (courseXp != null) 'courseXp': courseXp,
      if (recentlyCompleted != null) 'recentlyCompleted': recentlyCompleted,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    }).catchError((e) {
      print("[DatabaseService] Error saving learning state: $e");
    });
  }

  /// Reads the cloud learning state, or null when unavailable (guest, cloud
  /// off, missing doc, or network error).
  Future<Map<String, dynamic>?> fetchLearningState() async {
    if (isGuestId(uid)) return null;
    if (!await isCloudEnabled()) return null;
    try {
      final snap = await _userLearningDoc.get().timeout(const Duration(seconds: 30));
      if (!snap.exists) return null;
      final data = snap.data() ?? {};
      return {
        'completedLessons': List<String>.from((data['completedLessons'] as List?) ?? const []),
        'xp': (data['xp'] is num) ? (data['xp'] as num).toInt() : 0,
        'bookmarks': ((data['bookmarks'] as List?) ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList(),
        'activities': List<String>.from((data['activities'] as List?) ?? const []),
        'courseXp': Map<String, int>.from(
          (data['courseXp'] as Map?)?.map(
                (k, v) => MapEntry(k.toString(), (v as num).toInt()),
              ) ??
              const {},
        ),
        'recentlyCompleted': data['recentlyCompleted']?.toString(),
      };
    } catch (e) {
      print("[DatabaseService] Error fetching learning state: $e");
      return null;
    }
  }

  Future<void> saveMetacognitionState({
    required List<String> events,
    required List<Map<String, dynamic>> reviewQueue,
    required Map<String, dynamic> reflections,
  }) async {
    if (isGuestId(uid)) return;
    if (!await isCloudEnabled()) return;
    _userMetacogDoc.set({
      'events': events,
      'reviewQueue': reviewQueue,
      'reflections': reflections,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    }).catchError((e) {
      print("[DatabaseService] Error saving metacognition state: $e");
    });
  }

  Future<Map<String, dynamic>?> fetchMetacognitionState() async {
    if (isGuestId(uid)) return null;
    if (!await isCloudEnabled()) return null;
    try {
      final snap = await _userMetacogDoc.get().timeout(const Duration(seconds: 30));
      if (!snap.exists) return null;
      final data = snap.data() ?? {};
      return {
        'events': List<String>.from((data['events'] as List?) ?? const []),
        'reviewQueue': ((data['reviewQueue'] as List?) ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList(),
        'reflections': Map<String, dynamic>.from((data['reflections'] as Map?) ?? const {}),
      };
    } catch (e) {
      print("[DatabaseService] Error fetching metacognition state: $e");
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Local file store (per-book JSON files + an in-memory index)
  // ---------------------------------------------------------------------------
  // Keyed by uid so switching accounts keeps libraries separate. Static so the
  // cache survives the short-lived `DatabaseService()` instances call sites
  // create.
  static final Map<String, Map<String, Book>> _mem = {};
  static final Map<String, Future<Map<String, Book>>> _loading = {};

  Future<Directory> _booksDir(String forUid) async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/flow_books/$forUid');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  File _bookFile(Directory dir, String id) {
    // Keep ids filename-safe (book ids are app-generated, but be defensive).
    final safe = id.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
    return File('${dir.path}/$safe.json');
  }

  /// Loads (once per uid) the on-disk library into memory, migrating any data
  /// left behind in the legacy single-key SharedPreferences cache.
  Future<Map<String, Book>> _ensureLoaded() {
    final u = uid;
    final cached = _mem[u];
    if (cached != null) return Future.value(cached);
    final inFlight = _loading[u];
    if (inFlight != null) return inFlight;
    final fut = _loadFromDisk(u);
    _loading[u] = fut;
    return fut;
  }

  Future<Map<String, Book>> _loadFromDisk(String u) async {
    final Map<String, Book> result = {};
    if (kIsWeb) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final keys = prefs.getKeys();
        for (final key in keys) {
          if (key.startsWith('web_book_${u}_')) {
            final txt = prefs.getString(key);
            if (txt != null && txt.trim().isNotEmpty) {
              final b = Book.fromJson(Map<String, dynamic>.from(jsonDecode(txt)));
              if (b.id.isNotEmpty) result[b.id] = b;
            }
          }
        }
      } catch (e) {
        print("[DatabaseService] web _loadFromDisk error: $e");
      }
      _mem[u] = result;
      _loading.remove(u);
      return result;
    }
    try {
      final dir = await _booksDir(u);
      final files = dir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.toLowerCase().endsWith('.json') && !f.path.endsWith('_slides.json'));
      for (final f in files) {
        try {
          final txt = await f.readAsString();
          if (txt.trim().isEmpty) continue;
          final b = Book.fromJson(Map<String, dynamic>.from(jsonDecode(txt)));
          if (b.id.isNotEmpty) result[b.id] = b;
        } catch (e) {
          // One bad file no longer nukes the whole library.
          print("[DatabaseService] Skipping unreadable book file ${f.path}: $e");
        }
      }

      // One-time migration from the old `cached_books_<uid>` blob. Guarded by a
      // flag so deleting every book doesn't resurrect them on next launch.
      final prefs = await SharedPreferences.getInstance();
      final migrated = prefs.getBool('books_migrated_$u') ?? false;
      if (result.isEmpty && !migrated) {
        final legacy = prefs.getString('cached_books_$u');
        if (legacy != null && legacy.trim().isNotEmpty) {
          try {
            final List decoded = jsonDecode(legacy);
            for (final e in decoded) {
              final b = Book.fromJson(Map<String, dynamic>.from(e));
              if (b.id.isNotEmpty) {
                result[b.id] = b;
                await _writeBookFile(u, b);
              }
            }
            print("[DatabaseService] Migrated ${result.length} books from legacy cache for $u.");
          } catch (e) {
            print("[DatabaseService] Legacy cache migration failed: $e");
          }
        }
        await prefs.setBool('books_migrated_$u', true);
      }
    } catch (e) {
      print("[DatabaseService] _loadFromDisk error for $u: $e");
    }
    _mem[u] = result;
    _loading.remove(u);
    return result;
  }

  /// Atomic-ish single-book write: write to a temp file then rename, so an
  /// interrupted write can never leave a half-written (corrupt) book file.
  Future<void> _writeBookFile(String forUid, Book book) async {
    final dir = await _booksDir(forUid);

    // 1. Separate slides and save them to individual JSON files (with LaTeX fixing)
    for (final m in book.modules) {
      for (final s in m.sections) {
        for (final u in s.units) {
          for (final l in u.lessons) {
            if (l.slides.isNotEmpty) {
              final fixedSlides = l.slides.map((slide) => LatexUtils.fixSlideLatex(slide)).toList();
              if (kIsWeb) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString(
                  'web_book_${forUid}_${book.id}_lesson_${l.id}_slides',
                  jsonEncode(fixedSlides.map((s) => s.toJson()).toList()),
                );
              } else {
                final slidesFile = File('${dir.path}/${book.id}_lesson_${l.id}_slides.json');
                final slidesJson = jsonEncode(fixedSlides.map((s) => s.toJson()).toList());
                await slidesFile.writeAsString(slidesJson, flush: true);
              }
            }
          }
        }
      }
    }

    // 2. Strip slides from the Book JSON to build the skeleton book
    final skeletonBook = buildSkeletonBook(book);

    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('web_book_${forUid}_${book.id}', jsonEncode(skeletonBook.toJson()));
      return;
    }

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    final target = _bookFile(dir, book.id);
    final tmp = File('${target.path}.tmp');
    try {
      await tmp.writeAsString(jsonEncode(skeletonBook.toJson()), flush: true);
      try {
        await tmp.rename(target.path);
      } catch (_) {
        if (await target.exists()) await target.delete();
        await tmp.rename(target.path);
      }
    } catch (e) {
      print("[DatabaseService] _writeBookFile atomic write failed: $e. Falling back to direct write...");
      await target.writeAsString(jsonEncode(skeletonBook.toJson()), flush: true);
      try {
        if (await tmp.exists()) await tmp.delete();
      } catch (_) {}
    }
  }

  Future<List<Slide>> loadSlidesForLesson(String bookId, String lessonId) async {
    if (kIsWeb) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final txt = prefs.getString('web_book_${uid}_${bookId}_lesson_${lessonId}_slides');
        if (txt != null && txt.trim().isNotEmpty) {
          final List decoded = jsonDecode(txt);
          final slides = decoded.map((s) => LatexUtils.fixSlideLatex(Slide.fromJson(Map<String, dynamic>.from(s)))).toList();
          if (slides.isNotEmpty) return slides;
        }
      } catch (e) {
        print("[DatabaseService] loadSlidesForLesson web error: $e");
      }
    } else {
      try {
        final dir = await _booksDir(uid);
        final file = File('${dir.path}/${bookId}_lesson_${lessonId}_slides.json');
        if (await file.exists()) {
          final txt = await file.readAsString();
          if (txt.trim().isNotEmpty) {
            final decoded = jsonDecode(txt);
            if (decoded is List) {
              final List<Slide> slides = [];
              for (final item in decoded) {
                if (item is Map) {
                  try {
                    slides.add(LatexUtils.fixSlideLatex(
                        Slide.fromJson(Map<String, dynamic>.from(item))));
                  } catch (e) {
                    print("[DatabaseService] Error parsing slide item: $e");
                  }
                }
              }
              if (slides.isNotEmpty) return slides;
            }
          }
        }
      } catch (e) {
        print("[DatabaseService] loadSlidesForLesson error: $e");
      }
    }

    // Fallback: check in-memory cache for slides
    final memBook = _mem[uid]?[bookId];
    if (memBook != null) {
      for (final m in memBook.modules) {
        for (final s in m.sections) {
          for (final u in s.units) {
            for (final l in u.lessons) {
              if (l.id == lessonId && l.slides.isNotEmpty) {
                return l.slides;
              }
            }
          }
        }
      }
    }

    return [];
  }

  Future<void> _deleteBookFile(String forUid, String id) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('web_book_${forUid}_$id');
      final keys = prefs.getKeys();
      for (final key in keys) {
        if (key.startsWith('web_book_${forUid}_${id}_lesson_')) {
          await prefs.remove(key);
        }
      }
      return;
    }
    try {
      final dir = await _booksDir(forUid);
      final f = _bookFile(dir, id);
      if (await f.exists()) await f.delete();

      // Clean up lesson slides
      final files = dir.listSync().whereType<File>();
      for (final file in files) {
        final filename = file.path.split('/').last;
        if (filename.startsWith('${id}_lesson_') && filename.endsWith('_slides.json')) {
          await file.delete();
        }
      }
    } catch (e) {
      print("[DatabaseService] _deleteBookFile error: $e");
    }
  }

  // ---------------------------------------------------------------------------
  // Settings (cloud-only convenience — local settings live in SharedPreferences
  // and are owned by SettingsScreen). Gated behind the cloud toggle.
  // ---------------------------------------------------------------------------
  Future<void> saveUserSettings({
    required List<String> apiKeys,
    required List<String> models,
    List<String>? modelPrimaryTextList,
    List<String>? modelPrimaryGraphicsList,
    List<String>? modelLiteList,
    List<String>? modelLiveList,
    List<String>? groqApiKeys,
    List<String>? groqModelPrimaryTextList,
    List<String>? groqModelPrimaryGraphicsList,
    List<String>? groqModelLiteList,
    List<String>? groqModelLiveList,
    List<String>? cerebrasApiKeys,
    List<String>? cerebrasModelPrimaryTextList,
    List<String>? cerebrasModelPrimaryGraphicsList,
    List<String>? cerebrasModelLiteList,
    List<String>? cerebrasModelLiveList,
    List<String>? openrouterApiKeys,
    List<String>? openrouterModelPrimaryTextList,
    List<String>? openrouterModelPrimaryGraphicsList,
    List<String>? openrouterModelLiteList,
    List<String>? openrouterModelLiveList,
    String? selectedAiProvider,
    String? genConcurrency,
    int? scheduleStartHour,
    int? scheduleStartMinute,
    int? scheduleEndHour,
    int? scheduleEndMinute,
    String? customLiveChatPrompt,
    bool? autoFetchBooks,
    bool? autoVerifyMappings,
    bool? autoGenerateModule1,
    Map<String, dynamic>? writingStyleProfile,
  }) async {
    if (isGuestId(uid)) return;
    if (!await isCloudEnabled()) return; // local-first: nothing to push
    _userSettingsDoc.set({
      'apiKeys': apiKeys,
      'models': models,
      if (modelPrimaryTextList != null) ...{
        'modelPrimaryTextList': modelPrimaryTextList,
        if (modelPrimaryTextList.isNotEmpty) 'modelPrimary': modelPrimaryTextList.first,
      },
      if (modelPrimaryGraphicsList != null) ...{
        'modelPrimaryGraphicsList': modelPrimaryGraphicsList,
        if (modelPrimaryGraphicsList.isNotEmpty) 'modelPrimaryGraphics': modelPrimaryGraphicsList.first,
      },
      if (modelLiteList != null) ...{
        'modelLiteList': modelLiteList,
        if (modelLiteList.isNotEmpty) 'modelLite': modelLiteList.first,
      },
      if (modelLiveList != null) ...{
        'modelLiveList': modelLiveList,
        if (modelLiveList.isNotEmpty) 'modelLive': modelLiveList.first,
      },
      'groqApiKeys': ?groqApiKeys,
      'groqModelPrimaryTextList': ?groqModelPrimaryTextList,
      'groqModelPrimaryGraphicsList': ?groqModelPrimaryGraphicsList,
      'groqModelLiteList': ?groqModelLiteList,
      'groqModelLiveList': ?groqModelLiveList,
      'cerebrasApiKeys': ?cerebrasApiKeys,
      'cerebrasModelPrimaryTextList': ?cerebrasModelPrimaryTextList,
      'cerebrasModelPrimaryGraphicsList': ?cerebrasModelPrimaryGraphicsList,
      'cerebrasModelLiteList': ?cerebrasModelLiteList,
      'cerebrasModelLiveList': ?cerebrasModelLiveList,
      'openrouterApiKeys': ?openrouterApiKeys,
      'openrouterModelPrimaryTextList': ?openrouterModelPrimaryTextList,
      'openrouterModelPrimaryGraphicsList': ?openrouterModelPrimaryGraphicsList,
      'openrouterModelLiteList': ?openrouterModelLiteList,
      'openrouterModelLiveList': ?openrouterModelLiveList,
      if (selectedAiProvider != null) 'selectedAiProvider': selectedAiProvider,
      if (genConcurrency != null) 'genConcurrency': genConcurrency,
      if (scheduleStartHour != null) 'scheduleStartHour': scheduleStartHour,
      if (scheduleStartMinute != null) 'scheduleStartMinute': scheduleStartMinute,
      if (scheduleEndHour != null) 'scheduleEndHour': scheduleEndHour,
      if (scheduleEndMinute != null) 'scheduleEndMinute': scheduleEndMinute,
      if (customLiveChatPrompt != null) 'customLiveChatPrompt': customLiveChatPrompt,
      if (autoFetchBooks != null) 'autoFetchBooks': autoFetchBooks,
      if (autoVerifyMappings != null) 'autoVerifyMappings': autoVerifyMappings,
      if (autoGenerateModule1 != null) 'autoGenerateModule1': autoGenerateModule1,
      if (writingStyleProfile != null) 'writingStyleProfile': writingStyleProfile,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    }).then((_) {
      print("[DatabaseService] User settings saved to Firestore.");
    }).catchError((e) {
      print("[DatabaseService] Error saving user settings: $e");
    });
  }

  Future<Map<String, dynamic>?> fetchUserSettings() async {
    if (isGuestId(uid)) return null;
    if (!await isCloudEnabled()) return null; // local-first: don't hit network
    try {
      final snap = await _userSettingsDoc.get().timeout(const Duration(seconds: 30));
      if (!snap.exists) return null;
      final data = snap.data() ?? {};
      List<String> readList(String listKey, String scalarKey) {
        final list = data[listKey] as List?;
        if (list != null && list.isNotEmpty) return List<String>.from(list);
        final scalar = data[scalarKey] as String?;
        if (scalar != null && scalar.trim().isNotEmpty) return [scalar.trim()];
        return [];
      }
      return {
        'apiKeys': List<String>.from((data['apiKeys'] as List?) ?? []),
        'models': List<String>.from((data['models'] as List?) ?? []),
        'modelPrimaryTextList': readList('modelPrimaryTextList', 'modelPrimaryText'),
        'modelPrimaryGraphicsList': readList('modelPrimaryGraphicsList', 'modelPrimaryGraphics'),
        'modelLiteList': readList('modelLiteList', 'modelLite'),
        'modelLiveList': readList('modelLiveList', 'modelLive'),
        'groqApiKeys': List<String>.from((data['groqApiKeys'] as List?) ?? []),
        'groqModelPrimaryTextList': List<String>.from((data['groqModelPrimaryTextList'] as List?) ?? []),
        'groqModelPrimaryGraphicsList': List<String>.from((data['groqModelPrimaryGraphicsList'] as List?) ?? []),
        'groqModelLiteList': List<String>.from((data['groqModelLiteList'] as List?) ?? []),
        'groqModelLiveList': List<String>.from((data['groqModelLiveList'] as List?) ?? []),
        'cerebrasApiKeys': List<String>.from((data['cerebrasApiKeys'] as List?) ?? []),
        'cerebrasModelPrimaryTextList': List<String>.from((data['cerebrasModelPrimaryTextList'] as List?) ?? []),
        'cerebrasModelPrimaryGraphicsList': List<String>.from((data['cerebrasModelPrimaryGraphicsList'] as List?) ?? []),
        'cerebrasModelLiteList': List<String>.from((data['cerebrasModelLiteList'] as List?) ?? []),
        'cerebrasModelLiveList': List<String>.from((data['cerebrasModelLiveList'] as List?) ?? []),
        'openrouterApiKeys': List<String>.from((data['openrouterApiKeys'] as List?) ?? []),
        'openrouterModelPrimaryTextList': List<String>.from((data['openrouterModelPrimaryTextList'] as List?) ?? []),
        'openrouterModelPrimaryGraphicsList': List<String>.from((data['openrouterModelPrimaryGraphicsList'] as List?) ?? []),
        'openrouterModelLiteList': List<String>.from((data['openrouterModelLiteList'] as List?) ?? []),
        'openrouterModelLiveList': List<String>.from((data['openrouterModelLiveList'] as List?) ?? []),
        if (data['selectedAiProvider'] != null) 'selectedAiProvider': data['selectedAiProvider'],
        if (data['genConcurrency'] != null) 'genConcurrency': data['genConcurrency'],
        if (data['scheduleStartHour'] != null) 'scheduleStartHour': data['scheduleStartHour'],
        if (data['scheduleStartMinute'] != null) 'scheduleStartMinute': data['scheduleStartMinute'],
        if (data['scheduleEndHour'] != null) 'scheduleEndHour': data['scheduleEndHour'],
        if (data['scheduleEndMinute'] != null) 'scheduleEndMinute': data['scheduleEndMinute'],
        if (data['customLiveChatPrompt'] != null) 'customLiveChatPrompt': data['customLiveChatPrompt'],
        if (data['autoFetchBooks'] != null) 'autoFetchBooks': data['autoFetchBooks'],
        if (data['autoVerifyMappings'] != null) 'autoVerifyMappings': data['autoVerifyMappings'],
        if (data['autoGenerateModule1'] != null) 'autoGenerateModule1': data['autoGenerateModule1'],
        if (data['writingStyleProfile'] != null) 'writingStyleProfile': data['writingStyleProfile'],
      };
    } catch (e) {
      print("[DatabaseService] Error fetching user settings: $e");
      return null;
    }
  }

  Future<void> syncUserSettingsToLocal() async {
    final settings = await fetchUserSettings();
    if (settings == null) return;
    final prefs = await SharedPreferences.getInstance();

    void setListIfNotEmpty(String key, dynamic list) {
      if (list is List && list.isNotEmpty) {
        prefs.setStringList(key, List<String>.from(list));
      }
    }

    setListIfNotEmpty('gemini_api_keys_list', settings['apiKeys']);
    setListIfNotEmpty('gemini_models_list', settings['models']);
    setListIfNotEmpty('model_primary_text_list', settings['modelPrimaryTextList']);
    setListIfNotEmpty('model_primary_graphics_list', settings['modelPrimaryGraphicsList']);
    setListIfNotEmpty('model_lite_list', settings['modelLiteList']);
    setListIfNotEmpty('model_live_list', settings['modelLiveList']);

    setListIfNotEmpty('groq_api_keys_list', settings['groqApiKeys']);
    setListIfNotEmpty('groq_model_primary_text_list', settings['groqModelPrimaryTextList']);
    setListIfNotEmpty('groq_model_primary_graphics_list', settings['groqModelPrimaryGraphicsList']);
    setListIfNotEmpty('groq_model_lite_list', settings['groqModelLiteList']);
    setListIfNotEmpty('groq_model_live_list', settings['groqModelLiveList']);

    setListIfNotEmpty('cerebras_api_keys_list', settings['cerebrasApiKeys']);
    setListIfNotEmpty('cerebras_model_primary_text_list', settings['cerebrasModelPrimaryTextList']);
    setListIfNotEmpty('cerebras_model_primary_graphics_list', settings['cerebrasModelPrimaryGraphicsList']);
    setListIfNotEmpty('cerebras_model_lite_list', settings['cerebrasModelLiteList']);
    setListIfNotEmpty('cerebras_model_live_list', settings['cerebrasModelLiveList']);

    setListIfNotEmpty('openrouter_api_keys_list', settings['openrouterApiKeys']);
    setListIfNotEmpty('openrouter_model_primary_text_list', settings['openrouterModelPrimaryTextList']);
    setListIfNotEmpty('openrouter_model_primary_graphics_list', settings['openrouterModelPrimaryGraphicsList']);
    setListIfNotEmpty('openrouter_model_lite_list', settings['openrouterModelLiteList']);
    setListIfNotEmpty('openrouter_model_live_list', settings['openrouterModelLiveList']);

    if (settings['selectedAiProvider'] is String) {
      await prefs.setString('selected_ai_provider', settings['selectedAiProvider']);
    }
    if (settings['genConcurrency'] is String) {
      await prefs.setString('gen_concurrency', settings['genConcurrency']);
    }
    if (settings['scheduleStartHour'] is int) {
      await prefs.setInt('schedule_start_hour', settings['scheduleStartHour']);
    }
    if (settings['scheduleStartMinute'] is int) {
      await prefs.setInt('schedule_start_minute', settings['scheduleStartMinute']);
    }
    if (settings['scheduleEndHour'] is int) {
      await prefs.setInt('schedule_end_hour', settings['scheduleEndHour']);
    }
    if (settings['scheduleEndMinute'] is int) {
      await prefs.setInt('schedule_end_minute', settings['scheduleEndMinute']);
    }
    if (settings['customLiveChatPrompt'] is String) {
      await prefs.setString('custom_live_chat_prompt', settings['customLiveChatPrompt']);
    }
    if (settings['autoFetchBooks'] is bool) {
      await prefs.setBool('auto_fetch_books', settings['autoFetchBooks']);
    }
    if (settings['autoVerifyMappings'] is bool) {
      await prefs.setBool('auto_verify_mappings', settings['autoVerifyMappings']);
    }
    if (settings['autoGenerateModule1'] is bool) {
      await prefs.setBool('auto_generate_module_1', settings['autoGenerateModule1']);
    }
  }

  // ---------------------------------------------------------------------------
  // Books
  // ---------------------------------------------------------------------------
  Future<List<Book>> fetchBooks({
    bool forceRefresh = false,
    Future<bool> Function(Book local, Book remote)? onConflict,
  }) async {
    final local = await _ensureLoaded();
    final cloud = await isCloudEnabled();

    // Local-first path: when cloud is off or user is guest, we never touch the network.
    if (!cloud || isGuestId(uid)) {
      if (local.isEmpty && isGuestId(uid)) {
        await _seedGuestMocks(local);
      }
      return _sorted(local.values);
    }

    // Cloud enabled: return local immediately unless a refresh was requested.
    if (!forceRefresh) {
      return _sorted(local.values);
    }

    // Two-way sync: pull remote, merge by updatedAt, push back local-newer
    // books, and persist the merged set to the local file store.
    try {
      final snapshot = await _userBooks.get().timeout(const Duration(seconds: 30));
      final Map<String, Book> remote = {};
      for (final doc in snapshot.docs) {
        try {
          final data = doc.data();
          if (data == null) continue;
          final b = Book.fromJson(Map<String, dynamic>.from(data));
          if (b.id.isNotEmpty) {
            remote[b.id] = b;
          }
        } catch (e) {
          print("[DatabaseService] Error parsing remote book ${doc.id}: $e");
        }
      }

      final Map<String, Book> merged = {...remote};
      final List<Book> toPush = [];
      final Set<String> idsToWrite = {};

      // 1. Check for remote-only books (remote has them, local doesn't)
      for (final remoteBook in remote.values) {
        if (!local.containsKey(remoteBook.id)) {
          idsToWrite.add(remoteBook.id);
        }
      }

      // 2. Check local-only and conflict updates
      for (final localBook in local.values) {
        final remoteBook = remote[localBook.id];
        if (remoteBook == null) {
          merged[localBook.id] = localBook;
          toPush.add(localBook);
        } else if (localBook.updatedAt != remoteBook.updatedAt) {
          // Conflict! Auto take the latest version: newer wins
          final localTime = localBook.updatedAt ?? 0;
          final remoteTime = remoteBook.updatedAt ?? 0;
          final keepLocal = localTime >= remoteTime;
          if (keepLocal) {
            merged[localBook.id] = localBook;
            toPush.add(localBook);
          } else {
            merged[localBook.id] = remoteBook;
            idsToWrite.add(remoteBook.id);
          }
        }
      }

      // Persist only new or updated books locally
      for (final id in idsToWrite) {
        final b = merged[id];
        if (b != null) {
          local[id] = b;
          await _writeBookFile(uid, b);
        }
      }

      // Background push of local-newer books (non-blocking).
      for (final b in toPush) {
        final skeleton = buildSkeletonBook(b);
        _userBooks.doc(b.id).set(skeleton.toJson()).catchError((e) {
          print("[DatabaseService] Error syncing local book ${b.id} to remote: $e");
        });
      }

      if (merged.isEmpty && isGuestId(uid)) {
        await _seedGuestMocks(local);
        return _sorted(local.values);
      }

      // Record successful sync time
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('last_db_sync_time', DateTime.now().millisecondsSinceEpoch);

      return _sorted(merged.values);
    } catch (e) {
      print("[DatabaseService] SYNC ERROR (returning local): $e");
      return _sorted(local.values);
    }
  }

  /// Helper to strip slides from a book structure for compact cloud backup or disk index storage.
  static Book buildSkeletonBook(Book book) {
    final skeletonModules = book.modules.map((m) {
      final skeletonSections = m.sections.map((s) {
        final skeletonUnits = s.units.map((u) {
          final skeletonLessons = u.lessons.map((l) {
            return l.copyWith(slides: []);
          }).toList();
          return u.copyWith(lessons: skeletonLessons);
        }).toList();
        return s.copyWith(units: skeletonUnits);
      }).toList();
      return m.copyWith(sections: skeletonSections);
    }).toList();
    return book.copyWith(modules: skeletonModules);
  }

  List<Book> _sorted(Iterable<Book> books) {
    final list = books.toList();
    list.sort((a, b) => (b.updatedAt ?? 0).compareTo(a.updatedAt ?? 0));
    return list;
  }

  Future<void> _seedGuestMocks(Map<String, Book> into) async {
    for (final book in mockBooks) {
      final seeded = book.copyWith(updatedAt: DateTime.now().millisecondsSinceEpoch);
      into[seeded.id] = seeded;
      await _writeBookFile(uid, seeded);
    }
    print("[DatabaseService] Seeded ${mockBooks.length} mock books for $uid (local).");
  }

  /// Returns the freshest in-memory copy of [bookId] (or null). Backed by the
  /// file store, so partial mutations during generation read each other's
  /// latest writes without re-reading the disk every time.
  Future<Book?> getBookFromCache(String bookId, {bool forceDiskReload = false}) async {
    final u = uid;
    if (forceDiskReload) {
      _mem.remove(u);
    }
    final books = await _ensureLoaded();
    final cached = books[bookId];
    if (cached != null) return cached;

    // Direct disk fallback
    if (!kIsWeb) {
      try {
        final dir = await _booksDir(u);
        final f = _bookFile(dir, bookId);
        if (await f.exists()) {
          final txt = await f.readAsString();
          if (txt.trim().isNotEmpty) {
            final b = Book.fromJson(Map<String, dynamic>.from(jsonDecode(txt)));
            if (b.id.isNotEmpty) {
              books[b.id] = b;
              return b;
            }
          }
        }
      } catch (e) {
        print("[DatabaseService] Direct disk fallback error for $bookId: $e");
      }
    }
    return null;
  }

  Future<void> saveGeneratedBook(Book book) async {
    final scopedBook = book.scopeBookIds(book.id);
    final updatedBook = scopedBook.copyWith(updatedAt: DateTime.now().millisecondsSinceEpoch);

    // 1. Local file store first — this is the source of truth and must succeed
    //    for the book to appear in the UI. Only this one book's file is
    //    rewritten, so per-lesson streaming saves stay cheap.
    final books = await _ensureLoaded();
    books[updatedBook.id] = updatedBook;
    try {
      await _writeBookFile(uid, updatedBook);
    } catch (e) {
      print("[DatabaseService] LOCAL WRITE ERROR during saveGeneratedBook: $e");
    }

    // 2. Optional cloud backup (background, non-blocking).
    if (await isCloudEnabled()) {
      final skeletonBook = buildSkeletonBook(updatedBook);
      _userBooks.doc(updatedBook.id).set(skeletonBook.toJson()).catchError((e) {
        print("[DatabaseService] Cloud push failed (book is still saved locally): $e");
      });
    }
  }

  Future<void> deleteBook(String id) async {
    final books = await _ensureLoaded();
    books.remove(id);
    await _deleteBookFile(uid, id);

    if (await isCloudEnabled()) {
      try {
        await _userBooks.doc(id).delete();
      } catch (e) {
        print("[DatabaseService] Cloud delete failed: $e");
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Global / community books (inherently a cloud feature)
  // ---------------------------------------------------------------------------
  String get _globalCacheKey => 'cached_global_books';

  Future<List<Book>> fetchGlobalBooks({bool useCacheOnly = false, bool forceNetwork = false}) async {
    final prefs = await SharedPreferences.getInstance();

    final cachedStr = prefs.getString(_globalCacheKey);
    List<Book> cachedGlobals = [];
    if (cachedStr != null) {
      try {
        final List decoded = jsonDecode(cachedStr);
        cachedGlobals = decoded.map((e) => Book.fromJson(Map<String, dynamic>.from(e))).toList();
      } catch (e) {
        print("[DatabaseService] Error parsing global cache: $e");
      }
    }

    if (useCacheOnly) return cachedGlobals;
    // Community browsing needs the network; respect the local-first toggle unless forced.
    if (!forceNetwork && !await isCloudEnabled()) return cachedGlobals;

    try {
      final snapshot = await _globalBooks.get().timeout(const Duration(seconds: 30));
      final freshGlobals = snapshot.docs
          .where((d) => d.data() != null)
          .map((d) => Book.fromJson(Map<String, dynamic>.from(d.data()!)))
          .toList();
      await prefs.setString(_globalCacheKey, jsonEncode(freshGlobals.map((b) => b.toJson()).toList()));
      return freshGlobals;
    } catch (e) {
      print("[DatabaseService] Error fetching global books: $e");
      return cachedGlobals;
    }
  }

  /// Publishes [book] to the community. Returns false (no-op) when cloud sync
  /// is disabled, so the caller can prompt the user to enable it.
  Future<bool> publishToGlobal(Book book) async {
    if (!await isCloudEnabled()) return false;
    final user = FbAuth.instance.currentUser;
    final publishedBook = book.copyWith(
      authorId: user?.uid,
      authorName: user?.displayName ?? 'Anonymous User',
      isGlobal: true,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    final jsonMap = publishedBook.toJson();
    final jsonStr = jsonEncode(jsonMap);
    if (jsonStr.length > 950000) {
      final skeleton = buildSkeletonBook(publishedBook);
      await _globalBooks.doc(book.id).set(skeleton.toJson());
    } else {
      await _globalBooks.doc(book.id).set(jsonMap);
    }
    // Also save this local copy with isGlobal = true to local database!
    await saveGeneratedBook(publishedBook);
    return true;
  }

  Future<Book?> fetchGlobalBookById(String id) async {
    try {
      final snap = await _globalBooks.doc(id).get().timeout(const Duration(seconds: 30));
      if (snap.exists && snap.data() != null) {
        return Book.fromJson(Map<String, dynamic>.from(snap.data()!));
      }
    } catch (e) {
      print("[DatabaseService] Error fetching global book by id $id: $e");
    }
    try {
      final cached = await fetchGlobalBooks(useCacheOnly: true);
      for (final b in cached) {
        if (b.id == id) return b;
      }
    } catch (e) {
      print("[DatabaseService] Error checking local cache for global book by id $id: $e");
    }
    return null;
  }

  Future<void> deleteGlobalBook(String id) async {
    if (!await isCloudEnabled()) return;
    try {
      await _globalBooks.doc(id).delete();
      print("[DatabaseService] Admin deleted global book: $id");
    } catch (e) {
      print("[DatabaseService] Error deleting global book: $e");
    }
  }

  Future<List<CourseFolder>> fetchFolders({bool forceRefresh = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final u = uid;
    final key = 'user_folders_$u';
    List<CourseFolder> local = [];
    final jsonStr = prefs.getString(key);
    if (jsonStr != null) {
      try {
        final List decoded = jsonDecode(jsonStr);
        local = decoded.map((e) => CourseFolder.fromJson(Map<String, dynamic>.from(e))).toList();
      } catch (e) {
        print("[DatabaseService] Error parsing folders: $e");
      }
    }

    if (!forceRefresh || isGuestId(u) || !await isCloudEnabled()) {
      return local;
    }

    try {
      final snap = await _userFoldersDoc.get().timeout(const Duration(seconds: 15));
      if (snap.exists && snap.data() != null) {
        final data = snap.data()!;
        final List remoteRaw = (data['folders'] as List?) ?? [];
        final remote = remoteRaw
            .whereType<Map>()
            .map((e) => CourseFolder.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        final Map<String, CourseFolder> map = {};
        for (final f in local) map[f.id] = f;
        for (final f in remote) map[f.id] = f;
        final merged = map.values.toList();

        if (merged.length != local.length || remote.length != local.length) {
          await prefs.setString(key, jsonEncode(merged.map((f) => f.toJson()).toList()));
          _userFoldersDoc.set({
            'folders': merged.map((f) => f.toJson()).toList(),
            'updatedAt': DateTime.now().millisecondsSinceEpoch,
          }).catchError((_) {});
        }
        return merged;
      }
    } catch (e) {
      print("[DatabaseService] Error syncing cloud folders: $e");
    }
    return local;
  }

  Future<void> saveFolders(List<CourseFolder> folders) async {
    final prefs = await SharedPreferences.getInstance();
    final u = uid;
    final key = 'user_folders_$u';
    final jsonStr = jsonEncode(folders.map((f) => f.toJson()).toList());
    await prefs.setString(key, jsonStr);

    if (!isGuestId(u) && await isCloudEnabled()) {
      _userFoldersDoc.set({
        'folders': folders.map((f) => f.toJson()).toList(),
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      }).catchError((e) {
        print("[DatabaseService] Error saving folders to cloud: $e");
      });
    }
  }
}