import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      profileControllerState.fetchUserData(currentUser.uid);
    } else {
      return Scaffold(
        body: Center(
          child: Text(
            "User not logged in",
            style: TextStyle(fontSize: 18.sp, color: Colors.red),
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
                radius: 80.r,
                backgroundImage: photoUrl.isNotEmpty
                    ? NetworkImage(photoUrl)
                    : const AssetImage("assets/default.png") as ImageProvider,
              ),
              SizedBox(height: 20.h),
              Text(
                userName,
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                userEmail,
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: Text(
                    "Logout",
                    style: TextStyle(fontSize: 18.sp),
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
