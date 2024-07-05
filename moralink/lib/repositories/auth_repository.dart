// ---------- Common
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moralink/repositories/user_repository.dart';
import '../models/user.dart';
import '../models/user_role.dart';

// ---------- Network
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserRepository _userRepository = UserRepository();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    // Check if the user exists in the Firestore database
    final AppUser? existingUser = await _userRepository.fetchCurrentUser();

    if (existingUser == null) {
      // If the user doesn't exist, create a new user with the default role
      final AppUser newUser = AppUser(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? '',
        email: userCredential.user!.email ?? '',
        photoUrl: userCredential.user!.photoURL,
        role: UserRole.user,
        registeredEvents: [],
        attendedEvents: [], // Initialize an empty list for registered events
      );

      // Update the user profile in the Firestore database
      await _userRepository.updateUserProfile(newUser);
    } else {
      // If the user exists, update the displayName and photoURL
      final updatedUser = AppUser(
        id: existingUser.id,
        name: userCredential.user!.displayName ?? existingUser.name,
        email: existingUser.email,
        photoUrl: userCredential.user!.photoURL ?? existingUser.photoUrl,
        role: existingUser.role,
        registeredEvents: existingUser.registeredEvents,
        attendedEvents: existingUser.attendedEvents,
        passportNumber: existingUser.passportNumber,
        nameOnPassport: existingUser.nameOnPassport,
        addressLine1: existingUser.addressLine1,
        addressLine2: existingUser.addressLine2,
        addressCity: existingUser.addressCity,
        addressState: existingUser.addressState,
        addressZipCode: existingUser.addressZipCode,
        addressCountry: existingUser.addressCountry,
        phone: existingUser.phone,
        lineId: existingUser.lineId,
      );

      // Update the user profile in the Firestore database
      await _userRepository.updateUserProfile(updatedUser);
    }

    return userCredential;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

// Add other authentication-related methods as needed
}
