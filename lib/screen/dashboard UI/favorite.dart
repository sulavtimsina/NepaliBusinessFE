import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/favorite_controller.dart';
import 'package:nepaliapp/utils/business_list_item.dart';
import 'package:nepaliapp/utils/custom_search_bar.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());

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
                'Favourite',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Obx(
                () {
                  if (controller.filteredfavList.isEmpty) {
                    return const Center(
                      child: Text('No Favorite businesses found'),
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final business = controller.filteredfavList[index];

                        return BusinessListItem(
                          name: business['Name'],
                          imageUrl: business['ImageUrl'],
                          category: business['Category'],
                          rating: business['Rating'],
                          location: business['Location'],
                          description: business['Description'],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: controller.filteredfavList.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
