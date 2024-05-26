import 'package:flutter/material.dart';
import 'package:moralink/providers/auth_provider.dart';
import 'package:moralink/views/auth/widgets/google_sign_in_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GoogleSignInButton(),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: authProvider.signInWithGoogle,
              child: const Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}