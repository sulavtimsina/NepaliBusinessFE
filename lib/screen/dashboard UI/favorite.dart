import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/favorite_controller.dart';
import 'package:nepaliapp/utils/business_list_item.dart';
import 'package:nepaliapp/utils/custom_search_bar.dart';

import '../../model/business.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              onSearch: (query) => controller.filterList(query),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Text(
                'Favourite',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Obx(
                  () {
                    if (controller.filteredfavList.isEmpty) {
                      return Center(
                        child: Text(
                          'No Favorite businesses found',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final Business business =
                            controller.filteredfavList[index];
                        return BusinessListItem(business: business);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: controller.filteredfavList.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
