import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signinwithEmailandpass(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return the user on successful login
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle errors
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception('Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Check if the user is currently signed in
  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }
}
