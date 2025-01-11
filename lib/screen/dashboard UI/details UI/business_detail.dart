import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/location_controller.dart';
import 'package:nepaliapp/utils/utils.dart';

class BusinessDetail extends StatelessWidget {
  final Utils utils = Utils();
  final String imageUrl;
  final String name;
  final String categoryBusiness;
  final String location;
  final String description;
  final int rating;

  BusinessDetail({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.categoryBusiness,
    required this.location,
    required this.description,
    required this.rating,
  });

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
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 200.h,
              width: double.infinity.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(height: 16.h),
            Text(
              name,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Category: $categoryBusiness',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            InkWell(
              onTap: () {
                controller.openGoogleMaps(location);
              },
              child: Text(
                'Location: $location',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  'Rating:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
