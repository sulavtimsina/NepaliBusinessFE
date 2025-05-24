import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/authcontroller/reset_password_controller.dart';
import 'package:nepaliapp/utils/utils.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.25.h,
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
                        fontSize: 40.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    utils.greeting,
                    style: TextStyle(
                        color: utils.standardColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 30.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    utils.resetPageText,
                    style: TextStyle(
                        color: utils.secondaryColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 18.sp),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight - (screenHeight * 0.25.h) - kToolbarHeight,
              color: utils.halfScreenColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.85.w,
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
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 11, 49, 13)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New Here? ',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed('/registerScreen');
                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: utils.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 45.h,
                      width: screenWidth * 0.85.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
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
            ),
          ],
        ),
      ),
    );
  }
}
