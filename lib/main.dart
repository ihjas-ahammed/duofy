import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'services/global_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize shared prefs and load global XP early
  final prefs = await SharedPreferences.getInstance();
  GlobalState.xpNotifier.value = prefs.getInt('user_xp') ?? 0;

  runApp(const DuoFyApp());
}

class DuoFyApp extends StatelessWidget {
  const DuoFyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DuoFY',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}