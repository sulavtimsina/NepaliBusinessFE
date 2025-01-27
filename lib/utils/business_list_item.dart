import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/favorite_controller.dart';
import 'package:nepaliapp/routes/route_names.dart';

class BusinessListItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String category;
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

  const BusinessListItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.location,
    required this.description,
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
    final FavoriteController favoritesController =
        Get.put(FavoriteController());

    return ListTile(
      onTap: () {
        Get.toNamed(RouteNames.bussinesdetailScreen, arguments: {
          'imageUrl': imageUrl,
          'name': name,
          'categoryBusiness': category,
          'location': location,
          'description': description,
          'rating': rating,
          'ownerName': ownerName,
          'contactNumber': contactNumber,
          'emailAddress': emailAddress,
          'websiteURL': websiteURL,
          'facebook': facebook,
          'instagram': instagram,
          'city': city,
          'stateRegion': state,
          'zipcode': zipCode,
          'country': country,
          'languageSpoken': languageSpoken,
          'operatingHours': operatingHours,
          'paymentMethods': paymentMethod,
          'specialOffers': specialOffers,
          'verificationStatus': verificationStatus,
        });
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 80.w,
          height: 80.h,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category),
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
      trailing: Obx(() {
        final isFavorite = favoritesController.isFavorite(name);
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            if (isFavorite) {
              favoritesController.removeFromFavorites(name);
            } else {
              final businessData = {
                'name': name,
                'imageUrl': imageUrl,
                'category': category,
                'location': location,
                'description': description,
                'rating': rating,
                'ownerName': ownerName,
                'contactNumber': contactNumber,
                'emailAddress': emailAddress,
                'websiteURL': websiteURL,
                'facebook': facebook,
                'instagram': instagram,
                'city': city,
                'stateRegion': state,
                'zipcode': zipCode,
                'country': country,
                'languageSpoken': languageSpoken,
                'operatingHours': operatingHours,
                'paymentMethods': paymentMethod,
                'specialOffers': specialOffers,
                'verificationStatus': verificationStatus,
              };
              favoritesController.addToFavorites(businessData);
            }
          },
        );
      }),
    );
  }
}
