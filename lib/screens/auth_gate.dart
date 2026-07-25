import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/fb/fb_auth.dart';
import '../services/global_state.dart';
import '../widgets/realtime_progress_bar.dart';
import 'home_screen.dart';
import 'auth_screen.dart';
import 'onboarding/onboarding_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlobalState.onboardingCompleteNotifier,
      builder: (context, onboarded, _) {
        if (!onboarded) return const OnboardingScreen();
        return _buildAuthFlow(context);
      },
    );
  }

  Widget _buildAuthFlow(BuildContext context) {
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
                    body: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: RealtimeProgressBar(
                          title: 'Connecting to Auth Service',
                          progress: 0.50,
                          processName: 'Verifying user session...',
                        ),
                      ),
                    ),
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