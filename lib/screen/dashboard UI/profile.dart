import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/authcontroller/auth_controller_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthControllerState authControllerState = Get.put(AuthControllerState());
    return Center(
        child: ElevatedButton(
            onPressed: () {
              authControllerState.signOut();
            },
            child: const Text('Logout')));
  }
}
