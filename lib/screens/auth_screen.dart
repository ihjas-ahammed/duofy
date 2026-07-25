import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/fb/fb_auth.dart';
import '../services/global_state.dart';
import '../services/loading_progress_controller.dart';
import '../services/error_capture_service.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/responsive_center.dart';
import '../widgets/realtime_progress_bar.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  Future<void> _submit() async {
    final rawInput = _usernameCtrl.text.trim();
    final rawPassword = _passwordCtrl.text.trim();

    if (rawInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your username or email')),
      );
      return;
    }

    final String email;
    final String username;

    if (rawInput.contains('@')) {
      email = rawInput.toLowerCase();
      username = rawInput.split('@').first;
    } else {
      final sanitized = rawInput
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9_]'), '');
      final cleanUsername = sanitized.isEmpty ? 'user_${DateTime.now().millisecondsSinceEpoch}' : sanitized;
      email = '$cleanUsername@flow.in';
      username = rawInput;
    }

    final password = rawPassword.isNotEmpty
        ? rawPassword
        : 'duofy_secret_${rawInput.toLowerCase().replaceAll(RegExp(r'[^a-z0-9_]'), '')}';

    setState(() => _isLoading = true);
    LoadingProgressController.instance.startLoading('Validating input...');

    try {
      await Future.delayed(const Duration(milliseconds: 250));
      LoadingProgressController.instance.updateStep(0.40, 'Authenticating user...');
      try {
        await FbAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        LoadingProgressController.instance.updateStep(0.85, 'Loading user session...');
      } catch (_) {
        // Fallback: automatically create account if it doesn't exist yet
        LoadingProgressController.instance.updateStep(0.60, 'Creating new account...');
        final user = await FbAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        LoadingProgressController.instance.updateStep(0.85, 'Updating user profile...');
        await user.updateDisplayName(username);
      }
      LoadingProgressController.instance.updateStep(1.0, 'Login complete!');
      await Future.delayed(const Duration(milliseconds: 200));
    } on FbAuthException catch (e, stack) {
      ErrorCaptureService.instance.reportError(e, stack, category: 'Auth Error', processName: 'Login');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Authentication error')),
        );
      }
    } catch (e, stack) {
      ErrorCaptureService.instance.reportError(e, stack, category: 'Auth Error', processName: 'Login');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login error: $e')),
        );
      }
    } finally {
      LoadingProgressController.instance.stopLoading();
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.auth,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                const Icon(
                  LucideIcons.globe2,
                  size: 80,
                  color: AppTheme.duoBlue,
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome to Flow',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: context.colors.textPrimary,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in with username or email',
                  style: TextStyle(
                    fontSize: 14,
                    color: context.colors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),

                TextField(
                  controller: _usernameCtrl,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.colors.surfaceAlt,
                    hintText: 'Username or Email address',
                    hintStyle: TextStyle(color: context.colors.textFaint),
                    prefixIcon: Icon(
                      LucideIcons.user,
                      color: context.colors.textSecondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _passwordCtrl,
                  obscureText: true,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.colors.surfaceAlt,
                    hintText: 'Password',
                    hintStyle: TextStyle(color: context.colors.textFaint),
                    prefixIcon: Icon(
                      LucideIcons.lock,
                      color: context.colors.textSecondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                  onSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: 24),

                if (_isLoading)
                  ValueListenableBuilder<LoadingStep>(
                    valueListenable: LoadingProgressController.instance.loadingNotifier,
                    builder: (context, step, _) {
                      return RealtimeProgressBar(
                        title: 'Signing In',
                        progress: step.progress,
                        processName: step.processName,
                      );
                    },
                  )
                else
                  DuoButton(
                    text: 'SIGN IN',
                    color: AppTheme.duoBlue,
                    shadowColor: AppTheme.duoBlueDark,
                    onPressed: _submit,
                  ),

                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    GlobalState.isGuestNotifier.value = true;
                    GlobalState.forceShowAuthScreen.value = false;
                  },
                  child: Text(
                    'CONTINUE AS GUEST',
                    style: TextStyle(
                      color: context.colors.textFaint,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}