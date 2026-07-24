import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'services/fb/fb_core.dart';
import 'services/global_state.dart';
import 'services/notification_service.dart';
import 'screens/auth_gate.dart';
import 'widgets/walkthrough_banner.dart';
import 'screens/settings_screen.dart';
import 'screens/book_route_loader_screen.dart';
import 'services/learning_sync.dart';
import 'services/usage_limit_service.dart';
import 'services/guest_service.dart';

import 'dart:ui';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'screens/app_crash_recovery_screen.dart';

// Global Navigation Key to handle routing from notifications anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Global messenger so services (e.g. GenerationManager) can toast without a context
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

String? startupError;
bool _isGlobalErrorDialogOpen = false;

/// Heuristic: is this error one of the "annoying but harmless" kind that does
/// NOT actually threaten to kill the app? These are the ones we log silently
/// instead of interrupting the user with a full-screen dialog. Anything not
/// matched here is treated as potentially fatal and surfaced.
bool _looksNonFatal(Object error) {
  final s = error.toString().toLowerCase();
  if (s.contains('handshake') ||
      s.contains('network_error') ||
      s.contains('usage limit exceeded') ||
      s.contains('rate limit reached')) {
    return true;
  }

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
            backgroundColor: ctx.colors.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.redAccent, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "An Error Occurred",
                    style: TextStyle(color: ctx.colors.textPrimary, fontWeight: FontWeight.bold),
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
                    style: TextStyle(color: ctx.colors.textSecondary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "You can continue using other features. If the issue persists, please copy the details and report it.",
                    style: TextStyle(color: ctx.colors.textSecondary, fontSize: 13, height: 1.4),
                  ),
                  if (stack != null) ...[
                    const SizedBox(height: 12),
                    Text("Stack Trace:", style: TextStyle(color: ctx.colors.textFaint, fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ctx.colors.surfaceAlt,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(maxHeight: 120),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Text(
                          stack.toString(),
                          style: TextStyle(color: ctx.colors.textFaint, fontSize: 10, fontFamily: 'monospace'),
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
                child: Text("Copy Details", style: TextStyle(color: ctx.colors.textFaint, fontWeight: FontWeight.bold)),
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
        backgroundColor: dCtx.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.speed, color: Colors.orangeAccent, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Rate Limit Reached",
                style: TextStyle(color: dCtx.colors.textPrimary, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Text(
          "You're using the shared API key, which has limited capacity. "
          "Add your own Gemini API key in Settings for uninterrupted usage.",
          style: TextStyle(color: dCtx.colors.textSecondary, fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _isRateLimitDialogOpen = false;
              Navigator.pop(dCtx);
            },
            child: Text("Later", style: TextStyle(color: dCtx.colors.textFaint, fontWeight: FontWeight.bold)),
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
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Prevent raw red screen crashes with custom UI error widget
    ErrorWidget.builder = (FlutterErrorDetails details) {
      final ctx = navigatorKey.currentContext;
      final textPrimaryColor = ctx != null ? ctx.colors.textPrimary : AppTheme.darkColors.textPrimary;
      final textSecondaryColor = ctx != null ? ctx.colors.textSecondary : AppTheme.darkColors.textSecondary;
      return Container(
        padding: const EdgeInsets.all(16),
        color: AppTheme.surface,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.redAccent, size: 36),
                const SizedBox(height: 12),
                Text(
                  "UI Render Error",
                  style: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  details.exceptionAsString(),
                  style: TextStyle(color: textSecondaryColor, fontSize: 12, fontFamily: 'monospace'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    };

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    // Check for previous crash details
    final recordedCrash = await AppCrashRecoveryScreen.getRecordedCrash();

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      debugPrint("FLUTTER FRAMEWORK ERROR: ${details.exception}");
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      debugPrint("UNCAUGHT PROCESS ERROR: $error\n$stack");
      AppCrashRecoveryScreen.recordCrash(error, stack);
      if (!_looksNonFatal(error)) {
        showGlobalErrorAlert(error, stack);
      }
      return true; // Prevent default app crash
    };

    try {
      await FbCore.initializeApp();
      await UsageLimitService.instance.init();
    } catch (e, stack) {
      startupError = "Firebase Init Error: $e\n$stack";
    }

    try {
      await NotificationService.init();
    } catch (e, stack) {
      startupError = "${startupError ?? ""}\nNotification Init Error: $e\n$stack";
    }

    try {
      // Initialize shared prefs and load global XP early
      final prefs = await SharedPreferences.getInstance();
      GlobalState.xpNotifier.value = prefs.getInt(LearningSync.xpKey) ?? 0;

      // Restore guest-mode choice
      GlobalState.isGuestNotifier.value = prefs.getBool('is_guest_mode') ?? false;
      await GuestService.instance.getGuestId();
      GlobalState.isGuestNotifier.addListener(() {
        SharedPreferences.getInstance().then(
          (p) => p.setBool('is_guest_mode', GlobalState.isGuestNotifier.value),
        );
      });

      final hasOnboarded = prefs.getBool('onboarding_complete') ?? false;
      if (!hasOnboarded) {
        final isExistingUser = prefs.getString('user_writing_style_profile') != null ||
            (prefs.getStringList('gemini_api_keys_list')?.isNotEmpty ?? false) ||
            (prefs.getBool('is_guest_mode') ?? false);
        if (isExistingUser) {
          await prefs.setBool('onboarding_complete', true);
          if (!prefs.containsKey('advanced_mode')) {
            await prefs.setBool('advanced_mode', true);
          }
        }
      }
      GlobalState.onboardingCompleteNotifier.value = prefs.getBool('onboarding_complete') ?? false;
      GlobalState.advancedModeNotifier.value = prefs.getBool('advanced_mode') ?? false;
      GlobalState.advancedModeNotifier.addListener(() {
        SharedPreferences.getInstance().then(
          (p) => p.setBool('advanced_mode', GlobalState.advancedModeNotifier.value),
        );
      });

      GlobalState.developerModeNotifier.value = prefs.getBool('developer_mode') ?? false;
      GlobalState.developerModeNotifier.addListener(() {
        SharedPreferences.getInstance().then(
          (p) => p.setBool('developer_mode', GlobalState.developerModeNotifier.value),
        );
      });

      GlobalState.themeModeNotifier.value = ThemeMode.values.asNameMap()[
              prefs.getString('theme_mode')] ??
          ThemeMode.system;
      _syncCurrentBrightness(GlobalState.themeModeNotifier.value);
      GlobalState.themeModeNotifier.addListener(() {
        final mode = GlobalState.themeModeNotifier.value;
        _syncCurrentBrightness(mode);
        SharedPreferences.getInstance()
            .then((p) => p.setString('theme_mode', mode.name));
      });
      PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
        _syncCurrentBrightness(GlobalState.themeModeNotifier.value);
      };

      final legacyModels = prefs.getStringList('gemini_models_list') ?? const [];
      if (legacyModels.contains('gemini-1.5-flash')) {
        final cleaned = legacyModels.where((m) => m != 'gemini-1.5-flash').toList();
        await prefs.setStringList('gemini_models_list', cleaned);
      }
      if (prefs.getString('gemini_model') == 'gemini-1.5-flash') {
        await prefs.remove('gemini_model');
      }
    } catch (e, stack) {
      startupError = "${startupError ?? ""}\nPrefs Init Error: $e\n$stack";
    }

    if (recordedCrash != null) {
      runApp(AppCrashRecoveryScreen(
        error: recordedCrash['error'] ?? 'Unknown App Crash',
        stackTrace: recordedCrash['stack'] ?? '',
        onDismiss: () {
          runApp(const FlowApp());
        },
      ));
    } else {
      runApp(const FlowApp());
    }
  }, (Object error, StackTrace stack) {
    debugPrint("ZONED GLOBAL ERROR: $error\n$stack");
    AppCrashRecoveryScreen.recordCrash(error, stack);
    if (!_looksNonFatal(error)) {
      showGlobalErrorAlert(error, stack);
    }
  });
}

class PopIntent extends Intent {
  const PopIntent();
}

void _syncCurrentBrightness(ThemeMode mode) {
  AppTheme.currentBrightness = switch (mode) {
    ThemeMode.dark => Brightness.dark,
    ThemeMode.light => Brightness.light,
    ThemeMode.system => PlatformDispatcher.instance.platformBrightness,
  };
}

class FlowApp extends StatelessWidget {
  const FlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: GlobalState.themeModeNotifier,
      builder: (context, themeMode, _) => _buildApp(themeMode),
    );
  }

  Widget _buildApp(ThemeMode themeMode) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Flow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      builder: (context, child) => Stack(
        children: [
          ?child,
          const Positioned.fill(child: WalkthroughBanner()),
        ],
      ),
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