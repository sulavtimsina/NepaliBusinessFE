import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../model/business.dart';

class FavoriteController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxList<Business> favorites = <Business>[].obs;
  final favoriteList = <Business>[].obs;
  final filteredfavList = <Business>[].obs;

  StreamSubscription? _favoriteSubscription;

  String get userId {
    final id = _auth.currentUser?.uid ?? '';
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

  Future<void> addToFavorites(Business business) async {
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
          .add(business.toJson());

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
      favorites.removeWhere((item) => item.name == name);

      final QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .where('Name', isEqualTo: name)
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
          .map((doc) => Business.fromJson(doc.data() as Map<String, dynamic>))
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
      final favs = snapshot.docs.map((doc) {
        return Business.fromJson(doc.data());
      }).toList();

      favoriteList.value = favs;
      filteredfavList.value = favs;
    });
  }

  void clearData() {
    favorites.clear();
    favoriteList.clear();
    filteredfavList.clear();
    _favoriteSubscription?.cancel();
  }

  bool isFavorite(String name) {
    return favorites.any((item) => item.name == name);
  }

  void filterList(String query) {
    if (query.isEmpty) {
      filteredfavList.value = favoriteList;
    } else {
      filteredfavList.value = favoriteList.where((business) {
        return business.name.toLowerCase().contains(query.toLowerCase()) ||
            business.category.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}
