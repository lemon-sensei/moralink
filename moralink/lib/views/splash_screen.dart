// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/themes/colors.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay or perform any necessary operations
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the home screen after the delay

      context.go("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    // Implement splash screen UI and navigation logic
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/moralink_logo_with_text.png",
                  width: 250,
                  height: 250,
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text("authenticating"),
            ),
          ),
        ],
      ),
    );
  }
}
