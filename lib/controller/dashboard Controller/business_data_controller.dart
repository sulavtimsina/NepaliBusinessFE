import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BusinessDataController extends GetxController {
  final businessStream =
      FirebaseFirestore.instance.collection('Business').snapshots();
}
