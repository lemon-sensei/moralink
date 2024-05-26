// ---------- Common
import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';

// ---------- Network
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthRepository _authRepository = AuthRepository();

  User? get currentUser => _auth.currentUser;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Sign in with Google using the AuthRepository
      await _authRepository.signInWithGoogle();

      // Navigate to the /home route after successful sign-in
      context.go('/home');
    } catch (e) {
      // Handle sign-in error
      print('Error signing in with Google: $e');
    }

    notifyListeners();
  }

  Future<void> signOut() async {
    await _authRepository.signOut();

    notifyListeners();
  }

// Add other authentication-related methods as needed
}
