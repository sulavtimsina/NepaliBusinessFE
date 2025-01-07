import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nepaliapp/services/firestore_service_fav.dart';

class FavoriteController extends GetxController {
  final FirestoreServiceFav firestoreServiceFav = FirestoreServiceFav();
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  RxList<dynamic> favoriteItems = RxList([]);

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  void fetchFavorites() {
    firestoreServiceFav.getFavorites(userId).listen((items) {
      favoriteItems.value = items;
    });
  }

  void toggleFavorite(Map<String, dynamic> item) async {
    if (isFavorite(item['id'])) {
      await firestoreServiceFav.removeFromFavorites(userId, item['id']);
    } else {
      await firestoreServiceFav.addToFavorites(userId, item);
    }
  }

  bool isFavorite(String itemId) {
    return favoriteItems.any((item) => item['id'] == itemId);
  }
}
