import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:math';

class BusinessDataController extends GetxController {
  Stream<QuerySnapshot> get businessStream =>
      FirebaseFirestore.instance.collection('Business').snapshots();
  final businessList = <Map<String, dynamic>>[].obs;
  final filteredList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBusinessData();
  }

  void fetchBusinessData() {
    FirebaseFirestore.instance
        .collection('Business')
        .snapshots()
        .listen((snapshot) {
      final businesses = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'Name': doc['Name'],
          'ImageUrl': doc['ImageUrl'],
          'Category': doc['Category'],
          'Rating': doc['Rating'],
          'Location': doc['Location'],
          'Description': doc['Description'],
        };
      }).toList();

      businessList.value = businesses;
      filteredList.value = businesses;
    });
  }

  void filterList(String query) {
    if (query.isEmpty) {
      filteredList.value = businessList;
    } else {
      filteredList.value = businessList
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

  List<Map<String, dynamic>> getRandomBusinesses(int count) {
    final shuffled = List<Map<String, dynamic>>.from(filteredList);
    shuffled.shuffle(Random());
    return shuffled.take(count).toList();
  }
}
