import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationController extends GetxController {
  Future<void> openGoogleMaps(String location) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps?q=${Uri.encodeComponent(location)}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not launch $url');
    }
  }
}
