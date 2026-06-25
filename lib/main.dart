import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'services/fb/fb_core.dart';
import 'services/global_state.dart';
import 'services/notification_service.dart';
import 'screens/auth_gate.dart';
import 'screens/settings_screen.dart';
import 'screens/book_route_loader_screen.dart';
import 'services/learning_sync.dart';

import 'dart:ui';
import 'package:flutter/foundation.dart';

// Global Navigation Key to handle routing from notifications anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

String? startupError;
bool _isGlobalErrorDialogOpen = false;

/// Heuristic: is this error one of the "annoying but harmless" kind that does
/// NOT actually threaten to kill the app? These are the ones we log silently
/// instead of interrupting the user with a full-screen dialog. Anything not
/// matched here is treated as potentially fatal and surfaced.
bool _looksNonFatal(Object error) {
  final s = error.toString().toLowerCase();
  const benign = [
    // Transient network / IO — recoverable, the feature that needed it
    // already shows its own inline error.
    'socketexception',
    'timeoutexception',
    'connection closed',
    'connection refused',
    'connection reset',
    'connection terminated',
    'network is unreachable',
    'failed host lookup',
    'handshakeexception',
    'clientexception',
    'httpexception',
    'http request failed',
    // Framework layout / paint noise — visual only, never crashes the app.
    'renderflex',
    'overflowed',
    'a renderflex overflowed',
    'setstate() called after dispose',
    'was called during build',
    'mouse_tracker',
    'failed to load image',
    'imagecodecexception',
    'codec',
  ];
  return benign.any((fragment) => s.contains(fragment));
}

void showGlobalErrorAlert(Object error, StackTrace? stack) {
  debugPrint("GLOBAL ERROR OCCURRED: $error\n$stack");
  final context = navigatorKey.currentContext;
  if (context != null) {
    if (_isGlobalErrorDialogOpen) return;
    _isGlobalErrorDialogOpen = true;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentContext = navigatorKey.currentContext;
      if (currentContext == null) {
        _isGlobalErrorDialogOpen = false;
        return;
      }
      showDialog(
        context: currentContext,
        barrierDismissible: false,
        builder: (ctx) {
          if (!kDebugMode) {
            Future.delayed(const Duration(seconds: 3), () {
              if (_isGlobalErrorDialogOpen && ctx.mounted) {
                Navigator.of(ctx).pop();
              }
            });
          }
          return AlertDialog(
            backgroundColor: const Color(0xFF1E293B),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.error_outline, color: Colors.redAccent, size: 28),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "An Error Occurred",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "You can continue using other features. If the issue persists, please copy the details and report it.",
                    style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.4),
                  ),
                  if (stack != null) ...[
                    const SizedBox(height: 12),
                    const Text("Stack Trace:", style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(maxHeight: 120),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Text(
                          stack.toString(),
                          style: const TextStyle(color: Colors.white38, fontSize: 10, fontFamily: 'monospace'),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: "$error\n\n$stack"));
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(content: Text("Error details copied!")),
                  );
                },
                child: const Text("Copy Details", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () {
                  _isGlobalErrorDialogOpen = false;
                  Navigator.pop(ctx);
                },
                child: const Text("Dismiss", style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ).then((_) => _isGlobalErrorDialogOpen = false);
    });
  }
}

bool _isRateLimitDialogOpen = false;

/// Shows a non-blocking dialog asking the user to configure their own API
/// key when the shared fallback key hits rate limits. Debounced so it only
/// shows once at a time.
void showRateLimitDialog() {
  if (_isRateLimitDialogOpen) return;
  final context = navigatorKey.currentContext;
  if (context == null) return;
  _isRateLimitDialogOpen = true;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) {
      _isRateLimitDialogOpen = false;
      return;
    }
    showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (dCtx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.speed, color: Colors.orangeAccent, size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Rate Limit Reached",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: const Text(
          "You're using the shared API key, which has limited capacity. "
          "Add your own Gemini API key in Settings for uninterrupted usage.",
          style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _isRateLimitDialogOpen = false;
              Navigator.pop(dCtx);
            },
            child: const Text("Later", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              _isRateLimitDialogOpen = false;
              Navigator.pop(dCtx);
              // Navigate to SettingsScreen
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
            child: Text("Go to Settings", style: TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ).then((_) => _isRateLimitDialogOpen = false);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  
  try {
    await FbCore.initializeApp();
  } catch (e, stack) {
    startupError = "Firebase Init Error: $e\n$stack";
  }
  
  try {
    await NotificationService.init();
  } catch (e, stack) {
    startupError = (startupError ?? "") + "\nNotification Init Error: $e\n$stack";
  }

  try {
    // Initialize shared prefs and load global XP early
    final prefs = await SharedPreferences.getInstance();
    GlobalState.xpNotifier.value = prefs.getInt(LearningSync.xpKey) ?? 0;

    // Restore the guest-mode choice so desktop users who continued as a guest
    // aren't bounced to the login screen (and away from their guest library)
    // on every launch. Persist any later change to it.
    GlobalState.isGuestNotifier.value = prefs.getBool('is_guest_mode') ?? false;
    GlobalState.isGuestNotifier.addListener(() {
      SharedPreferences.getInstance().then(
        (p) => p.setBool('is_guest_mode', GlobalState.isGuestNotifier.value),
      );
    });

    // One-time cleanup: older builds auto-saved `gemini-1.5-flash` into the
    // generic models list / legacy scalar key whenever settings opened with
    // nothing configured. That model is no longer routable on the Gemini
    // API, so it kept poisoning every fallback ladder and surfaced as
    // "model not found" errors mid-generation. Strip it on startup.
    final legacyModels = prefs.getStringList('gemini_models_list') ?? const [];
    if (legacyModels.contains('gemini-1.5-flash')) {
      final cleaned = legacyModels.where((m) => m != 'gemini-1.5-flash').toList();
      await prefs.setStringList('gemini_models_list', cleaned);
    }
    if (prefs.getString('gemini_model') == 'gemini-1.5-flash') {
      await prefs.remove('gemini_model');
    }
  } catch (e, stack) {
    startupError = (startupError ?? "") + "\nPrefs Init Error: $e\n$stack";
  }

  // Set up global error boundaries.
  //
  // Framework errors caught by [FlutterError.onError] (overflows, paint/layout
  // glitches, "setState after dispose", etc.) are handled gracefully by Flutter
  // and don't kill the app — they're just noise. Log them, but never interrupt
  // the user with a dialog.
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint("FLUTTER FRAMEWORK ERROR (non-fatal): ${details.exception}");
  };

  // Errors reaching [PlatformDispatcher.onError] are otherwise-uncaught and are
  // the ones that would actually terminate the app. Surface those — but still
  // skip the handful of clearly-recoverable categories (transient network/IO)
  // that callers already report inline.
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    if (_looksNonFatal(error)) {
      debugPrint("UNCAUGHT NON-FATAL ERROR (suppressed dialog): $error");
    } else {
      showGlobalErrorAlert(error, stack);
    }
    return true; // Prevent default app crash behavior
  };

  runApp(const DuoFyApp());
}

class PopIntent extends Intent {
  const PopIntent();
}

class DuoFyApp extends StatelessWidget {
  const DuoFyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'DuoFY',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AuthGate(),
      shortcuts: <ShortcutActivator, Intent>{
        ...WidgetsApp.defaultShortcuts,
        const SingleActivator(LogicalKeyboardKey.escape): const PopIntent(),
      },
      actions: <Type, Action<Intent>>{
        ...WidgetsApp.defaultActions,
        PopIntent: CallbackAction<PopIntent>(
          onInvoke: (PopIntent intent) {
            if (navigatorKey.currentState?.canPop() ?? false) {
              navigatorKey.currentState?.maybePop();
            }
            return null;
          },
        ),
      },
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        if (name == '/' || name.isEmpty) {
          return MaterialPageRoute(builder: (_) => const AuthGate());
        }
        final bookId = name.replaceAll('/', '');
        if (bookId.isNotEmpty && bookId != 'index.html') {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => BookRouteLoaderScreen(bookId: bookId),
          );
        }
        return null;
      },
    );
  }
}