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
          'Name': doc['Name'] ?? 'N/A',
          'ImageUrl': doc['ImageUrl'] ?? '',
          'Category': doc['Category'] ?? 'N/A',
          'Rating': doc['Rating'] ?? 0.0,
          'Location': doc['Location'] ?? 'N/A',
          'Description': doc['Description'] ?? 'N/A',
          'OwnerName': doc['OwnerName'] ?? 'N/A',
          'ContactNumber': doc['ContactNumber'] ?? 'N/A',
          'EmailAddress': doc['EmailAddress'] ?? 'N/A',
          'WebsiteURL': doc['WebsiteURL'] ?? '',
          'Facebook': doc['Facebook'] ?? '',
          'Instagram': doc['Instagram'] ?? '',
          'City': doc['City'] ?? 'N/A',
          'StateRegion': doc['StateRegion'] ?? 'N/A',
          'Zipcode': doc['Zipcode'] ?? 'N/A',
          'Country': doc['Country'] ?? 'N/A',
          'LanguageSpoken': doc['LanguageSpoken'] ?? 'N/A',
          'OperatingHours': doc['OperatingHours'] ?? 'N/A',
          'PaymentMethods': doc['PaymentMethods'] ?? 'N/A',
          'SpecialOffers': doc['SpecialOffers'] ?? 'N/A',
          'VerificationStatus': doc['VerificationStatus'] ?? 'N/A',
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
