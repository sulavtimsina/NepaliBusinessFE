import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/authcontroller/auth_controller_state.dart';
import 'package:nepaliapp/routes/routes.dart';
import 'package:nepaliapp/screen/dashboard%20UI/home.dart';
import 'package:nepaliapp/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthControllerState());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Utils().primaryColor),
            useMaterial3: true,
          ),
          home: const Home(),
          getPages: AppRoutes.appRoutes()),
    );
  }
}
