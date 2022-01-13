import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_riverpod_architecture/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class SignInViewModel with ChangeNotifier {
  SignInViewModel({required this.authService});
  final FirebaseAuthService authService;
  bool isLoading = false;
  dynamic error;

  Future<void> _signIn(Future<User?> Function() signInMethod) async {
    try {
      isLoading = true;
      await signInMethod();
      notifyListeners();
      error = null;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInAnonymously() async {
    await _signIn(authService.signInAnon);
  }

  Future<void> signInEmailPassword({
    required final String email,
    required final String password,
  }) async {
    try {
      isLoading = true;

      await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      error = null;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
