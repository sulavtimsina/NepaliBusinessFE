import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/navigation_controller.dart';
import 'package:nepaliapp/utils/utils.dart';

import '../../controller/authcontroller/auth_controller_state.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());
    AuthControllerState authControllerState = Get.put(AuthControllerState());


    final Utils utils = Utils();
    return Scaffold(
      appBar: AppBar(
        title: Text(utils.name),
        backgroundColor: utils.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () =>authControllerState.signOut())
        ],
      ),

      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: EdgeInsets.only(bottom: 0.5.h),
            child: navigationController
                .screens[navigationController.selectedIndex.value],
          );
        }),
      ),
      bottomNavigationBar: Container(
        color: utils.navtextcolor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: GNav(
            backgroundColor: utils.navtextcolor,
            color: utils.standardColor,
            activeColor: utils.secondaryColor,
            tabBackgroundColor: utils.primaryColor,
            gap: 8,
            padding: EdgeInsets.all(16.r),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.category,
                text: 'Category',
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Favorite',
              ),
            ],
            onTabChange: (index) {
              navigationController.updatedIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
