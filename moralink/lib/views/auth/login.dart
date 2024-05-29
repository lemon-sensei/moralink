// ---------- common
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../shared/widgets/responsive_layout.dart';

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
    final textTheme = Theme.of(context).textTheme;

    return ResponsiveLayout(
      mobileBody: _buildMobileLayout(authProvider, textTheme),
      tabletBody: _buildTabletLayout(authProvider, textTheme),
      desktopBody: _buildDesktopLayout(authProvider, textTheme),
    );
  }

  Widget _buildMobileLayout(AuthProvider authProvider, TextTheme textTheme) {
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
                Text(
                  "A NEW DHARMA PROVIDER",
                  style: textTheme.titleLarge,
                ),
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
                  Text(
                    "Continue with:",
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SignInButton(
                          Buttons.google,
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });

                            try {
                              await authProvider.signInWithGoogle(context);
                            } catch (e) {
                              print('Error signing in with Google: $e');
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
           Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text("By using Moralink, you agree to our", style: textTheme.bodySmall,),
                  Text("Privacy Policy and Terms and Condition", style: textTheme.bodySmall,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(AuthProvider authProvider, TextTheme textTheme) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/moralink_logo.png",
                    width: 200,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "A NEW DHARMA PROVIDER",
                    style: textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continue with:",
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SignInButton(
                    Buttons.google,
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        await authProvider.signInWithGoogle(context);
                      } catch (e) {
                        print('Error signing in with Google: $e');
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "By using Moralink, you agree to our",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(width: 4),
            Text(
              "Privacy Policy and Terms and Condition",
              style: textTheme.bodyMedium?.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(AuthProvider authProvider, TextTheme textTheme) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/moralink_logo.png",
                    width: 200,
                  ),
                  const SizedBox(height: 48),
                  Text(
                    "A NEW DHARMA PROVIDER",
                    style: textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continue with:",
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SignInButton(
                    Buttons.google,
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        await authProvider.signInWithGoogle(context);
                      } catch (e) {
                        print('Error signing in with Google: $e');
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "By using Moralink, you agree to our",
              style: textTheme.bodySmall,
            ),
            const SizedBox(width: 4),
            Text(
              "Privacy Policy and Terms and Condition",
              style: textTheme.bodySmall?.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
