import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_list/handler/auth_exception_handler.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static String exception = "";

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      exception = AuthExceptionHandler.generateExceptionMessage(
          AuthExceptionHandler.handleException(e));
      print(exception);
      return null;
    }
  }

  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      exception = AuthExceptionHandler.generateExceptionMessage(
          AuthExceptionHandler.handleException(e));
      print(exception);
      return null;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      return await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      exception = AuthExceptionHandler.generateExceptionMessage(
          AuthExceptionHandler.handleException(e));
      print(exception);
      return;
    }
  }

  Future<void> signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      exception = AuthExceptionHandler.generateExceptionMessage(
          AuthExceptionHandler.handleException(e));
      print(exception);
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
