import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  var isLoading = true.obs;
  var userData = {}.obs;

  Future<void> fetchUserData(String userId) async {
    try {
      isLoading(true);
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        userData.value = doc.data()!;
      } else {
        userData.value = {"error": "User not found"};
      }
    } catch (e) {
      Get.snackbar('Error', "Error fetching user data: $e");
      userData.value = {"error": "Error fetching data"};
    } finally {
      isLoading(false);
    }
  }
}
