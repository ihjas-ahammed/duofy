import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'services/fb/fb_core.dart';
import 'services/global_state.dart';
import 'services/notification_service.dart';
import 'screens/auth_gate.dart';
import 'screens/book_route_loader_screen.dart';

// Global Navigation Key to handle routing from notifications anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FbCore.initializeApp();
  
  // Initialize Background Notifications System
  await NotificationService.init();

  // Initialize shared prefs and load global XP early
  final prefs = await SharedPreferences.getInstance();
  GlobalState.xpNotifier.value = prefs.getInt('user_xp') ?? 0;

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
      builder: (context, child) {
        return Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.escape): const PopIntent(),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              PopIntent: CallbackAction<PopIntent>(
                onInvoke: (PopIntent intent) {
                  if (navigatorKey.currentState?.canPop() ?? false) {
                    navigatorKey.currentState?.maybePop();
                  }
                  return null;
                },
              ),
            },
            child: child!,
          ),
        );
      },
    );
  }
}