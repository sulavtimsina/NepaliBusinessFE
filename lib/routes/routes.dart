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
                  imageUrl: Get.arguments['imageUrl'] ?? 'N/A',
                  name: Get.arguments['name'] ?? 'N/A',
                  categoryBusiness: Get.arguments['categoryBusiness'] ?? 'N/A',
                  location: Get.arguments['location'] ?? 'N/A',
                  description: Get.arguments['description'] ?? 'N/A',
                  rating: Get.arguments['rating'] ?? 0,
                  ownerName: Get.arguments['ownerName'] ?? 'N/A',
                  contactNumber: Get.arguments['contactNumber'] ?? 'N/A',
                  emailAddress: Get.arguments['emailAddress'] ?? 'N/A',
                  websiteURL: Get.arguments['websiteURL'] ?? '',
                  facebook: Get.arguments['facebook'] ?? '',
                  instagram: Get.arguments['instagram'] ?? '',
                  city: Get.arguments['city'] ?? 'N/A',
                  state: Get.arguments['stateRegion'] ?? 'N/A',
                  zipCode: Get.arguments['zipCode'] ?? 'N/A',
                  country: Get.arguments['country'] ?? 'N/A',
                  languageSpoken: Get.arguments['languageSpoken'] ?? 'N/A',
                  operatingHours: Get.arguments['operatingHours'] ?? 'N/A',
                  paymentMethod: Get.arguments['paymentMethod'] ?? 'N/A',
                  specialOffers: Get.arguments['specialOffers'] ?? 'N/A',
                  verificationStatus:
                      Get.arguments['verificationStatus'] ?? 'N/A',
                ),
            transitionDuration: const Duration(milliseconds: 350),
            transition: Transition.fade),
      ];
}
