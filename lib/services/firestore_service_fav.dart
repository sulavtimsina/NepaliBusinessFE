import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiceFav {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addToFavorites(
      String userId, Map<String, dynamic> itemData) async {
    final favoriteDoc = _db.collection('Favorites').doc(userId);
    await favoriteDoc.set({
      'FavoriteItems': FieldValue.arrayUnion([itemData])
    }, SetOptions(merge: true));
  }

  Future<void> removeFromFavorites(String userId, String itemId) async {
    final favoriteDoc = _db.collection('Favorites').doc(userId);
    final snapshot = await favoriteDoc.get();
    if (snapshot.exists) {
      final currentFavorites =
          List<Map<String, dynamic>>.from(snapshot['FavoriteItems']);
      currentFavorites.removeWhere((item) => item['id'] == itemId);

      await favoriteDoc.update({'FavoriteItems': currentFavorites});
    }
  }

  Stream<List<dynamic>> getFavorites(String userId) {
    return _db.collection('Favorites').doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        return doc.data()?['FavoriteItems'] ?? [];
      }
      return [];
    });
  }
}
