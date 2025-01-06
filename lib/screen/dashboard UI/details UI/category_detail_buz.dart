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
        title: const Text('Businesses'),
        centerTitle: true,
        backgroundColor: utils.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSearchBar(),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                categoryData,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: StreamBuilder(
                stream: controller.businessStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    final filteredData = snapshot.data!.docs.where((doc) {
                      return doc['Category'] == categoryData;
                    }).toList();

                    if (filteredData.isEmpty) {
                      return const Center(
                        child: Text('No businesses found for this category.'),
                      );
                    }

                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final business = filteredData[index];
                          return BusinessListItem(
                            name: business["Name"],
                            imageUrl: business["ImageUrl"],
                            category: business["Category"],
                            rating: business["Rating"],
                            location: business["Location"],
                            description: business["Description"],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: filteredData.length,
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('No data available.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
