import 'package:firebase_riverpod_architecture/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class SignUpViewModel with ChangeNotifier {
  SignUpViewModel({required this.authService});
  final FirebaseAuthService authService;
  bool isLoading = false;
  dynamic error;

  Future<void> registerEmailPassword({
    required final String email,
    required final String password,
  }) async {
    try {
      isLoading = true;

      await authService.createUserWithEmailAndPassword(
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
