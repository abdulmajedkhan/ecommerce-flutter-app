import 'package:get/get.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  // Reactive variable to store the selected product image URL
  RxString selectedProductImage = RxString('');

  // Method to update the selected product image
  void updateSelectedProductImage(String imageUrl) {
    selectedProductImage.value = imageUrl;
  }

// Other image-related methods can be added here as per your application's requirements
}
