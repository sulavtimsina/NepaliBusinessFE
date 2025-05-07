import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/controller/dashboard%20Controller/favorite_controller.dart';
import 'package:nepaliapp/model/business.dart';
import 'package:nepaliapp/routes/route_names.dart';
import 'package:nepaliapp/utils/login_dialog.dart';

import '../controller/authcontroller/auth_controller_state.dart';

class BusinessListItem extends StatelessWidget {
  final Business business;

  const BusinessListItem({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoritesController =
        Get.put(FavoriteController());
    final AuthControllerState authController = Get.put(AuthControllerState());

    return ListTile(
      onTap: () {
        Get.toNamed(RouteNames.bussinesdetailScreen,
            arguments: business.toJson());
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: CachedNetworkImage(
          imageUrl: business.imageUrl,
          width: 80.w,
          height: 80.h,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Text(business.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(business.category),
          Row(
            children: List.generate(5, (index) {
              if (index < business.rating.floor()) {
                // Full star
                return const Icon(Icons.star, color: Colors.amber);
              } else if (index < business.rating) {
                // Half star
                return const Icon(Icons.star_half, color: Colors.amber);
              } else {
                // Empty star
                return const Icon(Icons.star_border, color: Colors.amber);
              }
            }),
          )
        ],
      ),
      trailing: Obx(() {
        final isFavorite = favoritesController.isFavorite(business.name);
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            if (authController.firebaseUser.value != null) {
              if (isFavorite) {
                favoritesController.removeFromFavorites(business.name);
              } else {
                favoritesController.addToFavorites(business);
              }
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) => const LoginDialog(),
              );
            }
          },
        );
      }),
    );
  }
}
