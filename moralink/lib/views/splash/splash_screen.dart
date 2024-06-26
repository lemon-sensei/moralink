// ---------- Common
import 'package:flutter/material.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

import '../../config/app_config.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/moralink_logo.png",
                  width: 75,
                ),
                Text(
                  "MORALINK",
                  style: Theme.of(context).textTheme.headlineLarge,
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
