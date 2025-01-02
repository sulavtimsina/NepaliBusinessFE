import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/utils/utils.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool visiblePassword = true.obs;

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

  String? validatePassword(String password) {
    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  Future<void> signInWithEmailAndPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);

    if (emailError != null || passwordError != null) {
      utils.showSnackbar("Error", emailError ?? passwordError!);
      return;
    }

    try {
      isLoading.value = true;
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.toNamed('/home')?.then((_) {
        emailController.clear();
        passwordController.clear();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        utils.showSnackbar("Error", "Email is incorrect");
      } else if (e.code == 'wrong-password') {
        utils.showSnackbar("Error", "Password is incorrect");
      } else {
        utils.showSnackbar("Error", e.message ?? "An unknown error occurred");
      }
    } catch (e) {
      utils.showSnackbar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      Get.offAllNamed('/loginScreen');
    } catch (e) {
      utils.showSnackbar("Error", "Failed to sign out. Please try again.");
    }
  }

  void togglePasswordVisibility() {
    visiblePassword.toggle();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
