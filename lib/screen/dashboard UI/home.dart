import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/navigation_controller.dart';
import 'package:nepaliapp/utils/utils.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());
    final Utils utils = Utils();
    return Scaffold(
      appBar: AppBar(
        title: Text(utils.name),
        backgroundColor: utils.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() => navigationController
          .screens[navigationController.selectedIndex.value]),
      bottomNavigationBar: Container(
        color: utils.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            backgroundColor: utils.primaryColor,
            color: utils.standardColor,
            activeColor: utils.secondaryColor,
            tabBackgroundColor: utils.navtextcolor,
            gap: 8,
            padding: const EdgeInsets.all(16),
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
              GButton(
                icon: Icons.person_2_rounded,
                text: 'Profile',
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
