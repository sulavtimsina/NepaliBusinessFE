import 'package:get/get.dart';
import 'package:nepaliapp/screen/dashboard%20UI/dashboard.dart';
import 'package:nepaliapp/screen/dashboard%20UI/favorite.dart';
import 'package:nepaliapp/screen/dashboard%20UI/profile.dart';

import '../../screen/dashboard UI/category.dart';

class NavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final List screens = const [
    DashboardScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void updatedIndex(int index) {
    selectedIndex.value = index;
  }
}
