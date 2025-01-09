import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final RxList<String> categories = <String>[].obs;
  final RxList<String> filteredCategories = <String>[].obs;

  Stream<QuerySnapshot> get businessStream =>
      FirebaseFirestore.instance.collection('Business').snapshots();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() {
    businessStream.listen((snapshot) {
      final uniqueCategories = <String>{};
      for (var doc in snapshot.docs) {
        final category = doc['Category'] ?? "No Name";
        uniqueCategories.add(category);
      }
      categories.assignAll(uniqueCategories.toList());
      filteredCategories.assignAll(categories);
    });
  }

  void filterList(String query) {
    if (query.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      filteredCategories.assignAll(
        categories
            .where((category) =>
                category.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }
}
