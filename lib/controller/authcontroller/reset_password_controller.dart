import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/utils/utils.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  RxBool isLoading = false.obs;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  final Utils utils = Utils();

  String? validateEmail(String email) {
    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+$").hasMatch(email)) {
      return "Please enter a valid email";
    }
    return null;
  }

  Future<void> sendResetPasswordEmail() async {
    final email = emailController.text.trim();

    final emailError = validateEmail(email);

    if (emailError != null) {
      utils.showSnackbar("Error", emailError);
      return;
    }
    try {
      isLoading.value = true;

      await _firebaseAuth.sendPasswordResetEmail(email: email);
      utils.showSnackbar("Success", "Email is sent");
    } on FirebaseAuthException catch (e) {
      utils.showSnackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();

    super.onClose();
  }
}
