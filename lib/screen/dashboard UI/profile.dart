import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/authcontroller/auth_controller_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthControllerState authControllerState = Get.put(AuthControllerState());
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80,
              // backgroundImage: NetworkImage('https://example.com/photo.jpg'),
            ),
            const SizedBox(height: 20),

            const Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Email
            const Text(
              'john.doe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
      ),
    );
  }
}
