import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:math';

import '../../model/business.dart';

class BusinessDataController extends GetxController {
  Stream<QuerySnapshot> get businessStream =>
      FirebaseFirestore.instance.collection('Business').snapshots();
  final businessList = <Business>[].obs;
  final filteredList = <Business>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBusinessData();
  }

  void fetchBusinessData() {
    try {
      FirebaseFirestore.instance
          .collection('Business')
          .snapshots()
          .listen((snapshot) {
        final businesses = snapshot.docs.map((doc) {
          final data = doc.data();
          return Business.fromJson(data);
        }).toList();
        businessList.value = businesses;
        filteredList.value = businesses;
      });
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void filterList(String query) {
    if (query.isEmpty) {
      filteredList.value = businessList;
    } else {
      filteredList.value = businessList.where((business) {
        return business.name.toLowerCase().contains(query.toLowerCase()) ||
            business.category.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  List<Business> getRandomBusinesses(int count) {
    final shuffled = List<Business>.from(filteredList);
    shuffled.shuffle(Random());
    return shuffled.take(count).toList();
  }
}
