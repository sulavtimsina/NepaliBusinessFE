import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nepaliapp/utils/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Utils utils = Utils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(utils.name),
        backgroundColor: utils.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: Container(
        color: utils.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
          ),
        ),
      ),
    );
  }
}
