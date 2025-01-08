import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxList<Map<String, dynamic>> favorites = <Map<String, dynamic>>[].obs;
  final favoriteList = <Map<String, dynamic>>[].obs;
  final filteredfavList = <Map<String, dynamic>>[].obs;
  Stream<QuerySnapshot> get favoriteStream => FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('favorites')
      .snapshots();

  String get userId => _auth.currentUser?.uid ?? '';
  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
    fetchFavoritesData();
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

  bool isFavorite(String name) {
    return favorites.any((item) => item['name'] == name);
  }

  void fetchFavoritesData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .listen((snapshot) {
      final favorites = snapshot.docs.map((doc) {
        return {
          'Name': doc['name'],
          'ImageUrl': doc['imageUrl'],
          'Category': doc['category'],
          'Rating': doc['rating'],
          'Location': doc['location'],
          'Description': doc['description'],
        };
      }).toList();

      favoriteList.value = favorites;
      filteredfavList.value = favorites;
    });
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
