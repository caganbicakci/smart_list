import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return null;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      return await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return;
    }
  }

  Future<void> signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      return;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return auth.currentUser;
    } catch (e) {
      return null;
    }
  }
}
