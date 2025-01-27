import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                return business['Category'] == categoryData;
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
                  final business = filteredBusinesses[index];
                  return BusinessListItem(
                    name: business["Name"],
                    imageUrl: business["ImageUrl"],
                    category: business["Category"],
                    rating: business["Rating"],
                    location: business["Location"],
                    description: business["Description"],
                    ownerName: business['OwnerName'] ?? 'N/A',
                    contactNumber: business['ContactNumber'] ?? 'N/A',
                    emailAddress: business['EmailAddress'] ?? 'N/A',
                    websiteURL: business['WebsiteURL'] ?? '',
                    facebook: business['Facebook'] ?? '',
                    instagram: business['Instagram'] ?? '',
                    city: business['City'] ?? 'N/A',
                    state: business['StateRegion'] ?? 'N/A',
                    zipCode: business['Zipcode'] ?? 'N/A',
                    country: business['Country'] ?? 'N/A',
                    languageSpoken: business['LanguageSpoken'] ?? 'N/A',
                    operatingHours: business['OperatingHours'] ?? 'N/A',
                    paymentMethod: business['PaymentMethods'] ?? 'N/A',
                    specialOffers: business['SpecialOffers'] ?? 'N/A',
                    verificationStatus: business['VerificationStatus'] ?? 'N/A',
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
