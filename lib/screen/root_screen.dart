import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/authcontroller/auth_controller_state.dart';
import 'package:nepaliapp/screen/auth%20UI/login_screen.dart';
import 'package:nepaliapp/screen/dashboard%20UI/home.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthControllerState authController = Get.find<AuthControllerState>();

    return Obx(() {
      if (authController.firebaseUser.value != null) {
        return const Home();
      } else {
        return const Login();
      }
    });
  }
}
