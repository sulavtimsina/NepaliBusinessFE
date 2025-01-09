import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/screen/dashboard%20UI/details%20UI/category_detail_buz.dart';
import 'package:nepaliapp/utils/custom_search_bar.dart';
import '../../controller/dashboard Controller/category_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              onSearch: (query) => controller.filterList(query),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Obx(() {
                if (controller.filteredCategories.isEmpty) {
                  return const Center(
                    child: Text('No categories found.'),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 100,
                  ),
                  itemCount: controller.filteredCategories.length,
                  itemBuilder: (context, index) {
                    final displayCategory =
                        controller.filteredCategories[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('detailScreen', arguments: displayCategory);
                      },
                      child: Card(
                        elevation: 4,
                        child: Center(
                          child: Text(
                            displayCategory,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
