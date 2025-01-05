import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/authcontroller/login_controller.dart';
import 'package:nepaliapp/utils/utils.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                    utils.loginPageText,
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
                  const SizedBox(height: 14),
                  SizedBox(
                      width: screenWidth * 0.85,
                      child: Obx(() {
                        return TextField(
                          controller: loginController.passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: loginController.visiblePassword.value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: utils.secondaryColor),
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
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 11, 49, 13)),
                            ),
                          ),
                        );
                      })),
                  const SizedBox(height: 14),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/forgetScreen');
                    },
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(fontSize: 16, color: Color(0xff114c2b)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/registerScreen');
                    },
                    child: const Text(
                      'New Here? Register Now',
                      style: TextStyle(fontSize: 16, color: Color(0xff114c2b)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "or login with",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          loginController.signInwithGoogle();
                        },
                        child: Image.asset(
                          'assets/search.png',
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.2,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          loginController.signInWithFacebook();
                        },
                        child: Image.asset(
                          'assets/facebook.png',
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
          ],
        ),
      ),
    );
  }
}
