import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nepaliapp/utils/utils.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool visiblePassword = true.obs;

  RxBool isLoading = false.obs;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<void> signInwithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) return;

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': user.displayName ?? 'No Name',
          'email': user.email ?? 'No Email',
          'uid': user.uid,
          'photoURL': user.photoURL ?? 'No Photo',
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      isLoading.value = true;
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
                loginResult.accessToken!.tokenString);

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(facebookAuthCredential);

        final User? user = userCredential.user;

        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'name': user.displayName ?? 'No Name',
            'email': user.email ?? 'No Email',
            'uid': user.uid,
            'photoURL': user.photoURL ?? 'No Photo',
            'createdAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        }
      } else {}
    } finally {
      isLoading.value = false;
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
