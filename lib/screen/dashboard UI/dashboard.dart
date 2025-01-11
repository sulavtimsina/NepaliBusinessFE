import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/business_data_controller.dart';
import 'package:nepaliapp/utils/business_list_item.dart';
import 'package:nepaliapp/utils/custom_search_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BusinessDataController());

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
                'Trending Businesses',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Obx(
                  () {
                    if (controller.filteredList.isEmpty) {
                      return Center(
                        child: Text(
                          'No businesses found',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final business = controller.filteredList[index];
                        return BusinessListItem(
                          name: business['Name'],
                          imageUrl: business['ImageUrl'],
                          category: business['Category'],
                          rating: business['Rating'],
                          location: business['Location'],
                          description: business['Description'],
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: controller.filteredList.length,
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
