import 'package:flutter/material.dart';
import 'package:moralink/models/user.dart';
import 'package:moralink/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  Future<void> fetchCurrentUser() async {
    _currentUser = await _userRepository.fetchCurrentUser();
    notifyListeners();
  }

  Future<void> updateUserProfile(AppUser updatedUser) async {
    await _userRepository.updateUserProfile(updatedUser);
    _currentUser = updatedUser;
    notifyListeners();
  }

// Add other user-related methods as needed
}