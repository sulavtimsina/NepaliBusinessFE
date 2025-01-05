import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/authcontroller/register_controller.dart';
import 'package:nepaliapp/utils/utils.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final RegisterController registerController = Get.put(RegisterController());
    final Utils utils = Utils();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                    utils.registerPageText,
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
                      controller: registerController.nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: utils.secondaryColor),
                        hintText: 'Name',
                        hintStyle: TextStyle(color: utils.secondaryColor),
                        prefixIcon: const Icon(CupertinoIcons.person),
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
                  const SizedBox(height: 12),
                  SizedBox(
                    width: screenWidth * 0.85,
                    child: TextField(
                      controller: registerController.emailController,
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
                  const SizedBox(height: 12),
                  SizedBox(
                      width: screenWidth * 0.85,
                      child: Obx(() {
                        return TextField(
                          controller: registerController.passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: registerController.visiblePassword.value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: utils.secondaryColor),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: utils.secondaryColor),
                            filled: true,
                            prefixIcon: const Icon(CupertinoIcons.lock_fill),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  registerController.visiblePassword.value =
                                      !registerController.visiblePassword.value;
                                },
                                icon: Icon(
                                  registerController.visiblePassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color:
                                      registerController.visiblePassword.value
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
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/loginScreen');
                    },
                    child: const Text(
                      'Already Have Account? Login',
                      style: TextStyle(fontSize: 16, color: Color(0xff114c2b)),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          registerController.signInwithGoogle();
                        },
                        child: Image.asset(
                          'assets/search.png',
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.2,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          registerController.signInWithFacebook();
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
                      onPressed: registerController.isLoading.value
                          ? null
                          : registerController.signUpAndSaveToFirestore,
                      child: Obx(() => registerController.isLoading.value
                          ? CircularProgressIndicator(
                              color: utils.secondaryColor,
                            )
                          : Text(
                              'Register',
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
