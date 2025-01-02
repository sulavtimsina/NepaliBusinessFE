import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/authcontroller/reset_password_controller.dart';
import 'package:nepaliapp/utils/utils.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final Utils utils = Utils();
    final ResetPasswordController resetPasswordController =
        Get.put(ResetPasswordController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        centerTitle: true,
        backgroundColor: utils.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.25,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    utils.name,
                    style: TextStyle(
                        color: utils.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    utils.greeting,
                    style: TextStyle(
                        color: utils.standardColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 30),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    utils.resetPageText,
                    style: TextStyle(
                        color: utils.secondaryColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 18),
                  )
                ],
              ),
            ),
            Container(
              width: screenWidth,
              color: utils.halfScreenColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.85,
                    child: TextField(
                      controller: resetPasswordController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: utils.secondaryColor),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: utils.secondaryColor),
                        prefixIcon: const Icon(CupertinoIcons.mail_solid),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 11, 49, 13)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/registerScreen');
                    },
                    child: const Text(
                      'New Here? Register Now',
                      style: TextStyle(fontSize: 16, color: Color(0xff114c2b)),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 45,
                    width: screenWidth * 0.85,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: utils.primaryColor,
                      ),
                      onPressed: resetPasswordController.isLoading.value
                          ? null
                          : resetPasswordController.sendResetPasswordEmail,
                      child: Obx(() => resetPasswordController.isLoading.value
                          ? CircularProgressIndicator(
                              color: utils.secondaryColor,
                            )
                          : Text(
                              'Reset',
                              style: TextStyle(
                                  color: utils.secondaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
