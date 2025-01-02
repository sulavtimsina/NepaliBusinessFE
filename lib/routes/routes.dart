import 'package:get/get.dart';
import 'package:nepaliapp/screen/auth%20UI/forget_password.dart';
import 'package:nepaliapp/screen/auth%20UI/login_screen.dart';
import 'package:nepaliapp/screen/auth%20UI/register_screen.dart';

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
            page: () => Home(),
            transitionDuration: const Duration(milliseconds: 350),
            transition: Transition.fade),
      ];
}
