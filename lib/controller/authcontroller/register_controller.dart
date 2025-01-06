import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
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

  Future<void> signUpAndSaveToFirestore() async {
    final name = nameController.text.trim();
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

      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
        'uid': userCredential.user?.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.toNamed('/home')?.then((_) {
        nameController.clear();
        emailController.clear();
        passwordController.clear();
      });
    } on FirebaseAuthException catch (e) {
      utils.showSnackbar("Error", e.toString());
    } catch (e) {
      utils.showSnackbar("Error", "Failed to Save User");
    } finally {
      isLoading.value = false;
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
      Get.back();
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
        Get.back();
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
