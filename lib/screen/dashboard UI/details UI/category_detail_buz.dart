import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/business_data_controller.dart';
import 'package:nepaliapp/model/business.dart';
import 'package:nepaliapp/utils/business_list_item.dart';
import 'package:nepaliapp/utils/custom_search_bar.dart';
import 'package:nepaliapp/utils/utils.dart';

class CategoryDetailBuz extends StatelessWidget {
  final String categoryData;

  const CategoryDetailBuz({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    final String categoryData = Get.arguments['categoryData'];
    final controller = Get.put(BusinessDataController());
    final Utils utils = Utils();
    return Scaffold(
      appBar: AppBar(
        title: Text(utils.name),
        centerTitle: true,
        backgroundColor: utils.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchBar(
            onSearch: (query) => controller.filterList(query),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              categoryData,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(() {
              final filteredBusinesses =
                  controller.filteredList.where((business) {
                return business.category == categoryData;
              }).toList();

              if (filteredBusinesses.isEmpty) {
                return Center(
                  child: Text(
                    'No businesses found for this category.',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                );
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  final Business business = filteredBusinesses[index];
                  return BusinessListItem(business: business);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: filteredBusinesses.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}
