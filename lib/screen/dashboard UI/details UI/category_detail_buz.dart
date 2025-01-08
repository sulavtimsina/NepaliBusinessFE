import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/business_data_controller.dart';
import 'package:nepaliapp/utils/business_list_item.dart';
import 'package:nepaliapp/utils/custom_search_bar.dart';
import 'package:nepaliapp/utils/utils.dart';

class CategoryDetailBuz extends StatelessWidget {
  final String categoryData;

  const CategoryDetailBuz({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BusinessDataController());
    final Utils utils = Utils();
    return Scaffold(
      appBar: AppBar(
        title: Text(utils.name),
        centerTitle: true,
        backgroundColor:
            utils.primaryColor, // Replace with your Utils primaryColor
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchBar(
            onSearch: (query) => controller.filterList(query),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              categoryData,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(() {
              final filteredBusinesses =
                  controller.filteredList.where((business) {
                return business['Category'] == categoryData;
              }).toList();

              if (filteredBusinesses.isEmpty) {
                return const Center(
                  child: Text('No businesses found for this category.'),
                );
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  final business = filteredBusinesses[index];
                  return BusinessListItem(
                    name: business["Name"],
                    imageUrl: business["ImageUrl"],
                    category: business["Category"],
                    rating: business["Rating"],
                    location: business["Location"],
                    description: business["Description"],
                  );
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
