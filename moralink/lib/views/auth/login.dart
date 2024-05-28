// ---------- common
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import 'package:moralink/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  "assets/images/moralink_logo.png",
                  width: 200,
                ),
                const SizedBox(height: 16),
                const Text("A NEW DHARMA PROVIDER"),
              ],
            ),
          ),
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  const Text("Continue with:"),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator() // Show a circular progress indicator
                      : SignInButton(
                          Buttons.google,
                          onPressed: () async {
                            setState(() {
                              _isLoading =
                                  true; // Disable the button and show the progress indicator
                            });

                            try {
                              // Call the signInWithGoogle method from the AuthProvider
                              await authProvider.signInWithGoogle(context);
                            } catch (e) {
                              // Handle sign-in error
                              print('Error signing in with Google: $e');
                            } finally {
                              setState(() {
                                _isLoading =
                                    false; // Re-enable the button and hide the progress indicator
                              });
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text("By using Moralink, you agree to our"),
                  Text("Privacy Policy and Terms and Condition"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
