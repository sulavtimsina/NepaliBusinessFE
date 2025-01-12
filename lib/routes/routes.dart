import 'package:get/get.dart';
import 'package:nepaliapp/screen/auth%20UI/forget_password.dart';
import 'package:nepaliapp/screen/auth%20UI/login_screen.dart';
import 'package:nepaliapp/screen/auth%20UI/register_screen.dart';
import 'package:nepaliapp/screen/dashboard%20UI/details%20UI/business_detail.dart';
import 'package:nepaliapp/screen/dashboard%20UI/details%20UI/category_detail_buz.dart';

import '../screen/dashboard UI/home.dart';
import 'route_names.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RouteNames.loginScreen,
            page: () => const Login(),
            transitionDuration: const Duration(milliseconds: 350),
            transition: Transition.fade),
        GetPage(
            name: RouteNames.registerScreen,
            page: () => const RegisterScreen(),
            transitionDuration: const Duration(milliseconds: 350),
            transition: Transition.fade),
        GetPage(
            name: RouteNames.forgetScreen,
            page: () => const ForgetPassword(),
            transitionDuration: const Duration(milliseconds: 350),
            transition: Transition.fade),
        GetPage(
            name: RouteNames.home,
            page: () => const Home(),
            transitionDuration: const Duration(milliseconds: 350),
            transition: Transition.fade),
        GetPage(
            name: RouteNames.detailScreen,
            page: () => CategoryDetailBuz(
                  categoryData: Get.arguments['categoryData'],
                ),
            transitionDuration: const Duration(milliseconds: 350),
            transition: Transition.fade),
        GetPage(
            name: RouteNames.bussinesdetailScreen,
            page: () => BusinessDetail(
                imageUrl: Get.arguments['imageUrl'],
                name: Get.arguments['name'],
                categoryBusiness: Get.arguments['categoryBusiness'],
                location: Get.arguments['location'],
                description: Get.arguments['description'],
                rating: Get.arguments['rating']),
            transitionDuration: const Duration(milliseconds: 350),
            transition: Transition.fade),
      ];
}
