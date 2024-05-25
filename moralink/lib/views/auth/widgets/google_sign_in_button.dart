import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle Google Sign-In
      },
      icon: const FaIcon(FontAwesomeIcons.google),
      label: const Text('Sign In with Google'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        overlayColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}