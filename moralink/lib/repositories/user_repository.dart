import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moralink/models/user.dart'; // Import the updated model

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AppUser?> fetchCurrentUser() async {
    // Return type updated
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(userId).get();

    if (snapshot.exists) {
      return AppUser.fromJson(
          snapshot.data() as Map<String, dynamic>); // AppUser instead of User
    }

    return null;
  }

  Future<void> updateUserProfile(AppUser updatedUser) async {
    // Parameter type updated
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('users').doc(userId).set(updatedUser.toJson());
  }

// ...
}
