import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/authcontroller/login_controller.dart';
import 'package:nepaliapp/utils/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final LoginController loginController = Get.put(LoginController());
    final Utils utils = Utils();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: utils.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    utils.loginPageText,
                    style: TextStyle(
                        color: utils.secondaryColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 18.sp),
                  )
                ],
              ),
            ),
            Container(
              width: screenWidth,
              color: utils.halfScreenColor,
              height: screenHeight - (screenHeight * 0.25.h) - kToolbarHeight,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.85.w,
                      child: TextField(
                        controller: loginController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: utils.secondaryColor),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: utils.secondaryColor),
                          filled: true,
                          prefixIcon: const Icon(CupertinoIcons.mail_solid),
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
                    SizedBox(height: 14.h),
                    SizedBox(
                        width: screenWidth * 0.85.w,
                        child: Obx(() {
                          return TextField(
                            controller: loginController.passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: loginController.visiblePassword.value,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle:
                                  TextStyle(color: utils.secondaryColor),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: utils.secondaryColor),
                              filled: true,
                              prefixIcon: const Icon(CupertinoIcons.lock_fill),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    loginController.visiblePassword.value =
                                        !loginController.visiblePassword.value;
                                  },
                                  icon: Icon(
                                    loginController.visiblePassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: loginController.visiblePassword.value
                                        ? Colors.grey.shade500
                                        : utils.secondaryColor,
                                  )),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 11, 49, 13)),
                              ),
                            ),
                          );
                        })),
                    SizedBox(height: 14.h),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/forgetScreen');
                      },
                      child: Text(
                        'Forget Password',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: utils.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
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
                    SizedBox(height: 14.h),
                    Center(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0.h),
                            child: const Text(
                              "or login with",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            loginController.signInwithGoogle();
                          },
                          child: Image.asset(
                            'assets/search.png',
                            width: screenWidth * 0.15.w,
                            height: screenHeight * 0.15.h,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            loginController.signInWithFacebook();
                          },
                          child: Image.asset(
                            'assets/facebook.png',
                            width: screenWidth * 0.15.w,
                            height: screenHeight * 0.15.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01.h,
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
                        onPressed: loginController.isLoading.value
                            ? null
                            : loginController.signInWithEmailAndPassword,
                        child: Obx(() => loginController.isLoading.value
                            ? CircularProgressIndicator(
                                color: utils.secondaryColor,
                              )
                            : Text(
                                'Login',
                                style: TextStyle(
                                    color: utils.secondaryColor,
                                    fontWeight: FontWeight.bold),
                              )),
                      ),
                    )
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
