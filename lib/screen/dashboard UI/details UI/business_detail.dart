import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/location_controller.dart';
import 'package:nepaliapp/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BusinessDetail extends StatelessWidget {
  final Utils utils = Utils();
  final String imageUrl;
  final String name;
  final String categoryBusiness;
  final String location;
  final String description;
  final int rating;
  final String ownerName;
  final String contactNumber;
  final String emailAddress;
  final String websiteURL;
  final String facebook;
  final String instagram;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String languageSpoken;
  final String operatingHours;
  final String paymentMethod;
  final String specialOffers;
  final String verificationStatus;

  BusinessDetail({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.categoryBusiness,
    required this.location,
    required this.description,
    required this.rating,
    required this.ownerName,
    required this.contactNumber,
    required this.emailAddress,
    required this.websiteURL,
    required this.facebook,
    required this.instagram,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.languageSpoken,
    required this.operatingHours,
    required this.paymentMethod,
    required this.specialOffers,
    required this.verificationStatus,
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
            RichText(
              text: TextSpan(
                text: 'Category: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: categoryBusiness, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Owner Name: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: ownerName, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
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
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'City: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: city, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'State/Region: ',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: state,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Zip Code: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: zipCode, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Country: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: country, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
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
            RichText(
              text: TextSpan(
                text: 'Contact Number: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: contactNumber, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Email Address: ', // Bold label
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: emailAddress,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.blue, // Indicate it's clickable
                      fontWeight: FontWeight.normal,
                      decoration:
                          TextDecoration.underline, // Underline for links
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: emailAddress,
                        );
                        if (await canLaunchUrl(emailUri)) {
                          await launchUrl(emailUri);
                        } else {
                          Get.snackbar('Error', 'Unable to open email app.');
                        }
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Website Url: ', // Bold label
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: websiteURL,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (await canLaunchUrlString(websiteURL)) {
                          await launchUrlString(websiteURL);
                        } else {
                          Get.snackbar('Error', 'Unable to open website.');
                        }
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Facebook: ', // Bold label
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: facebook,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (await canLaunchUrlString(facebook)) {
                          await launchUrlString(facebook);
                        } else {
                          Get.snackbar('Error', 'Unable to open Facebook.');
                        }
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Instagram: ', // Bold label
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: instagram,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (await canLaunchUrlString(instagram)) {
                          await launchUrlString(instagram);
                        } else {
                          Get.snackbar('Error', 'Unable to open Instagram.');
                        }
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Language(s) Spoken: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: languageSpoken, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Operating Hours: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: operatingHours, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Payment Methods: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: paymentMethod, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Special Offers: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: specialOffers, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                text: 'Verification Status: ', // The bold part
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Bold style
                ),
                children: [
                  TextSpan(
                    text: verificationStatus, // The non-bold part
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal, // Normal weight
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
