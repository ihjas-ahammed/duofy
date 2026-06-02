import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/fb/fb_auth.dart';
import '../services/global_state.dart';
import 'home_screen.dart';
import 'auth_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlobalState.forceShowAuthScreen,
      builder: (context, forceAuth, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: GlobalState.isGuestNotifier,
          builder: (context, isGuest, _) {
            final bool showGuest = (isGuest || kIsWeb) && !forceAuth;
            if (showGuest) {
              return const HomeScreen();
            }
            
            return StreamBuilder<FbUser?>(
              stream: FbAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                
                if (snapshot.hasData) {
                  // Reset forceAuth once we logged in successfully
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    GlobalState.forceShowAuthScreen.value = false;
                  });
                  return const HomeScreen();
                }
                
                return const AuthScreen();
              },
            );
          },
        );
      },
    );
  }
}