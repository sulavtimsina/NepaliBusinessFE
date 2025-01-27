import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxList<Map<String, dynamic>> favorites = <Map<String, dynamic>>[].obs;
  final favoriteList = <Map<String, dynamic>>[].obs;
  final filteredfavList = <Map<String, dynamic>>[].obs;
  StreamSubscription? _favoriteSubscription;

  String get userId {
    final id = _auth.currentUser?.uid ?? '';
    print('Current User ID: $id');
    return id;
  }

  @override
  void onInit() {
    super.onInit();
    _initializeUserListeners();
  }

  @override
  void onClose() {
    _favoriteSubscription?.cancel();
    super.onClose();
  }

  void _initializeUserListeners() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        clearData();
        fetchFavorites();
        fetchFavoritesData();
      } else {
        clearData();
      }
    });
  }

  Future<void> addToFavorites(Map<String, dynamic> business) async {
    if (userId.isEmpty) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }
    try {
      favorites.add(business);
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .add(business);

      Get.snackbar('Success', 'Added to favorites');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(String name) async {
    if (userId.isEmpty) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      favorites.removeWhere((item) => item['name'] == name);
      final QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .where('name', isEqualTo: name)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      Get.snackbar('Success', 'Removed from favorites');
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove from favorites: $e');
    }
  }

  Future<void> fetchFavorites() async {
    if (userId.isEmpty) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .get();

      favorites.value = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch favorites: $e');
    }
  }

  void fetchFavoritesData() {
    _favoriteSubscription?.cancel();
    _favoriteSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .listen((snapshot) {
      final favorites = snapshot.docs.map((doc) {
        return {
          'Name': doc['name'] ?? 'N/A',
          'ImageUrl': doc['imageUrl'] ?? 'N/A',
          'Category': doc['category'] ?? 'N/A',
          'Rating': doc['rating'] ?? 0,
          'Location': doc['location'] ?? 'N/A',
          'Description': doc['description'] ?? 'N/A',
          'OwnerName': doc['ownerName'] ?? 'N/A',
          'ContactNumber': doc['contactNumber'] ?? 'N/A',
          'EmailAddress': doc['emailAddress'] ?? 'N/A',
          'WebsiteURL': doc['websiteURL'] ?? '',
          'Facebook': doc['facebook'] ?? '',
          'Instagram': doc['instagram'] ?? '',
          'City': doc['city'] ?? 'N/A',
          'StateRegion': doc['stateRegion'] ?? 'N/A',
          'Zipcode': doc['zipcode'] ?? 'N/A',
          'Country': doc['country'] ?? 'N/A',
          'LanguageSpoken': doc['languageSpoken'] ?? 'N/A',
          'OperatingHours': doc['operatingHours'] ?? 'N/A',
          'PaymentMethods': doc['paymentMethods'] ?? 'N/A',
          'SpecialOffers': doc['specialOffers'] ?? 'N/A',
          'VerificationStatus': doc['verificationStatus'] ?? 'N/A',
        };
      }).toList();

      favoriteList.value = favorites;
      filteredfavList.value = favorites;
    });
  }

  void clearData() {
    favorites.clear();
    favoriteList.clear();
    filteredfavList.clear();
    _favoriteSubscription?.cancel();
  }

  bool isFavorite(String name) {
    return favorites.any((item) => item['name'] == name);
  }

  void filterList(String query) {
    if (query.isEmpty) {
      filteredfavList.value = favoriteList;
    } else {
      filteredfavList.value = favoriteList
          .where((business) =>
              business['Name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              business['Category']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
  }
}
