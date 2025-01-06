import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
          'Name': doc['name'],
          'ImageUrl': doc['imageUrl'],
          'Category': doc['category'],
          'Rating': doc['rating'],
          'Location': doc['location'],
          'Description': doc['description'],
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
}
