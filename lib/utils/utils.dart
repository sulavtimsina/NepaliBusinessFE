import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  final primaryColor = const Color(0xffB3E5FC);
  final secondaryColor = Colors.black;
  final halfScreenColor = const Color(0xfff4f4f4);
  final standardColor = Colors.black;
  final navtextcolor = Colors.white;
  final tabBackgroundColor = Colors.grey.shade800;

  final String name = 'KhojBiz';
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
