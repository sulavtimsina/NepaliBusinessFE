import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Utils {
  final primaryColor = const Color(0xffc2e96a);
  final secondaryColor = const Color(0xff114c2b);
  final halfScreenColor = const Color(0xfff4f4f4);
  final standardColor = Colors.black;
  final navtextcolor = Colors.white;
  final tabBackgroundColor = Colors.grey.shade800;

  final String name = 'Easebuz';
  String get greeting => "Welcome to $name";
  String get loginPageText => "Login below to find business near you";
  String get registerPageText => "Register below to find business near you";
  String get resetPageText => "Enter you email and get Reset link";

  void showSnackbar(
    String title,
    String message,
  ) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.black,
    );
  }
}
