import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/authcontroller/auth_controller_state.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/user_profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthControllerState authControllerState = Get.put(AuthControllerState());
    UserProfileController profileControllerState =
        Get.put(UserProfileController());

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Get the current user's UID
    final currentUser = FirebaseAuth.instance.currentUser;

    // Check if the user is logged in
    if (currentUser != null) {
      profileControllerState.fetchUserData(currentUser.uid);
    } else {
      return const Scaffold(
        body: Center(
          child: Text(
            "User not logged in",
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      body: Obx(() {
        if (profileControllerState.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final userData = profileControllerState.userData;

        if (userData.isEmpty || userData.containsKey("error")) {
          return Center(
            child: Text(
              userData["error"] ?? "Error loading profile",
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          );
        }

        final photoUrl = userData["photoURL"] ?? "";
        final userName = userData["name"] ?? "Unknown User";
        final userEmail = userData["email"] ?? "No Email Available";

        return SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: photoUrl.isNotEmpty
                    ? NetworkImage(photoUrl)
                    : const AssetImage("assets/default.png") as ImageProvider,
              ),
              const SizedBox(height: 20),
              Text(
                userName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                userEmail,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    authControllerState.signOut();
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
