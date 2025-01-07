import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/screen/dashboard%20UI/details%20UI/business_detail.dart';

class BusinessListItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String category;
  final String location;
  final String description;
  final int rating;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const BusinessListItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.location,
    required this.description,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(BusinessDetail(
            imageUrl: imageUrl,
            name: name,
            categoryBusiness: category,
            location: location,
            description: description,
            rating: rating));
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 80,
          height: 80,
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
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.grey,
        ),
        onPressed: onFavoriteToggle,
      ),
    );
  }
}
