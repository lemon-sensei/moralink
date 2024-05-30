// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/models/user.dart';
import 'package:moralink/repositories/user_repository.dart';
import '../models/event.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  Future<void> fetchCurrentUser() async {
    _currentUser = await _userRepository.fetchCurrentUser();
    notifyListeners();
  }

  Future<AppUser> fetchUserById(String userId) async {
    return await _userRepository.fetchUserById(userId);
  }

  Future<void> updateUserProfile(AppUser updatedUser) async {
    final userRepository = UserRepository();
    await userRepository.updateUserProfile(updatedUser);
    _currentUser = updatedUser;
    notifyListeners();
  }

  Future<void> markEventAsAttended(Event event, AppUser user) async {
    await _userRepository.markEventAsAttended(event, user);
    notifyListeners();
  }

// Add other user-related methods as needed
}
