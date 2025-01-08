import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Category: $categoryBusiness',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Location
            InkWell(
              onTap: () {
                controller.openGoogleMaps(location);
              },
              child: Text(
                'Location: $location',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),

            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),

            // Rating
            Row(
              children: [
                const Text(
                  'Rating:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
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
