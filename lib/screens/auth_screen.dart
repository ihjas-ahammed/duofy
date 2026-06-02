import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/fb/fb_auth.dart';
import '../services/global_state.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/responsive_center.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignUp = false;
  bool _isLoading = false;

  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  Future<void> _submit() async {
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();
    final username = _usernameCtrl.text.trim();

    if (email.isEmpty || password.isEmpty || (_isSignUp && username.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isSignUp) {
        final user = await FbAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        await user.updateDisplayName(username);
      } else {
        await FbAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      }
    } on FbAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Authentication error')));
    } finally {
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
              const SizedBox(height: 40),
              const Icon(LucideIcons.globe2, size: 80, color: AppTheme.duoBlue),
              const SizedBox(height: 24),
              Text(
                _isSignUp ? 'Create your\nprofile' : 'Enter your\ndetails',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              if (_isSignUp)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: _usernameCtrl,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black26,
                      hintText: 'Username',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    ),
                  ),
                ),
                
              TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  hintText: 'Email address',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                ),
              ),
              const SizedBox(height: 16),
              
              TextField(
                controller: _passwordCtrl,
                obscureText: true,
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  hintText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                ),
              ),
              const SizedBox(height: 32),
              
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: AppTheme.duoBlue))
              else
                DuoButton(
                  text: _isSignUp ? 'CREATE ACCOUNT' : 'SIGN IN',
                  color: AppTheme.duoBlue,
                  shadowColor: AppTheme.duoBlueDark,
                  onPressed: _submit,
                ),
                
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => setState(() => _isSignUp = !_isSignUp),
                child: Text(
                  _isSignUp ? 'ALREADY HAVE AN ACCOUNT?' : 'CREATE A PROFILE',
                  style: const TextStyle(color: AppTheme.duoBlue, fontWeight: FontWeight.w900, letterSpacing: 1.2),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  GlobalState.isGuestNotifier.value = true;
                  GlobalState.forceShowAuthScreen.value = false;
                },
                child: const Text(
                  'CONTINUE AS GUEST',
                  style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w900, letterSpacing: 1.2),
                ),
              )
            ],
          ),
          ),
        ),
      ),
    );
  }
}