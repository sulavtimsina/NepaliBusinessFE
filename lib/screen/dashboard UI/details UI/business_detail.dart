import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/location_controller.dart';
import 'package:nepaliapp/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:nepaliapp/utils/info_row.dart';

import '../../../model/business.dart'; 
class BusinessDetail extends StatelessWidget {
  final Utils utils = Utils();
  final Business business;

  BusinessDetail({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    final LocationController controller = Get.put(LocationController());

    return Scaffold(
      appBar: AppBar(
        title: Text(utils.name),
        centerTitle: true,
        backgroundColor: utils.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Card(
              elevation: 2,
              child: CachedNetworkImage(
                imageUrl: business.imageUrl.isNotEmpty
                    ? business.imageUrl
                    : 'https://via.placeholder.com/150',
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 50),
              ),
            ),
            SizedBox(height: 16.h),
            // Business Name
            Text(
              business.name.isNotEmpty ? business.name : 'Unknown Business',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            // General Info
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'General Information',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.h),
                    InfoRow(label: 'Category', value: business.category),
                    InfoRow(label: 'Owner Name', value: business.ownerName),
                    InfoRow(
                        label: 'Description',
                        value: business.description,
                        isMultiline: true),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Address
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () => controller.openGoogleMaps(business.location),
                      child: InfoRow(
                        label: 'Location',
                        value: business.location,
                        icon: Icons.map,
                        isClickable: true,
                      ),
                    ),
                    InfoRow(label: 'City', value: business.city),
                    InfoRow(label: 'State/Region', value: business.state),
                    InfoRow(label: 'Zip Code', value: business.zipCode),
                    InfoRow(label: 'Country', value: business.country),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Contact Info
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.h),
                    InfoRow(
                        label: 'Contact Number', value: business.contactNumber),
                    InfoRow(
                      label: 'Email Address',
                      value: business.emailAddress,
                      icon: Icons.email,
                      isClickable: true,
                      onTap: () async {
                        final Uri emailUri =
                            Uri(scheme: 'mailto', path: business.emailAddress);
                        if (await canLaunchUrl(emailUri)) {
                          await launchUrl(emailUri);
                        } else {
                          Get.snackbar('Error', 'Unable to open email app.');
                        }
                      },
                    ),
                    InfoRow(
                      label: 'Website',
                      value: business.websiteUrl,
                      icon: Icons.web,
                      isClickable: true,
                      onTap: () async {
                        if (business.websiteUrl.isNotEmpty &&
                            await canLaunchUrlString(business.websiteUrl)) {
                          await launchUrlString(business.websiteUrl);
                        } else {
                          Get.snackbar('Error', 'Unable to open website.');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Social Media
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Social Media',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.h),
                    InfoRow(
                      label: 'Facebook',
                      value: business.facebook,
                      icon: Icons.facebook,
                      isClickable: true,
                      onTap: () async {
                        if (business.facebook.isNotEmpty &&
                            await canLaunchUrlString(business.facebook)) {
                          await launchUrlString(business.facebook);
                        } else {
                          Get.snackbar('Error', 'Unable to open Facebook.');
                        }
                      },
                    ),
                    InfoRow(
                      label: 'Instagram',
                      value: business.instagram,
                      icon: Icons.camera_alt,
                      isClickable: true,
                      onTap: () async {
                        if (business.instagram.isNotEmpty &&
                            await canLaunchUrlString(business.instagram)) {
                          await launchUrlString(business.instagram);
                        } else {
                          Get.snackbar('Error', 'Unable to open Instagram.');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Additional Info
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Additional Information',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.h),
                    InfoRow(
                        label: 'Language(s) Spoken',
                        value: business.languageSpoken),
                    InfoRow(
                        label: 'Operating Hours',
                        value: business.operatingHours),
                    InfoRow(
                        label: 'Payment Methods',
                        value: business.paymentMethods),
                    InfoRow(
                        label: 'Special Offers', value: business.specialOffers),
                    InfoRow(
                        label: 'Verification Status',
                        value: business.verificationStatus),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Rating
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rating:',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8.w),
                    Row(
                      children: List.generate(5, (index) {
                        if (index < business.rating.floor()) {
                          return const Icon(Icons.star, color: Colors.amber);
                        } else if (index < business.rating) {
                          return const Icon(Icons.star_half,
                              color: Colors.amber);
                        } else {
                          return const Icon(Icons.star_border,
                              color: Colors.amber);
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable widget for key-value pairs
