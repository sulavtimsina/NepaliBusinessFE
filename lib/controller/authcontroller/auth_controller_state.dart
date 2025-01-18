import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthControllerState extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Rxn<User?> firebaseUser = Rxn<User?>();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  void onInit() {
    firebaseUser.bindStream(authStateChanges);
    super.onInit();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    Get.offAllNamed('/loginScreen');
  }

  User? get currentUser => firebaseUser.value;
}
