
import 'package:get/get.dart';
import 'package:nomishop/data/services/netwotk_manager.dart';
import 'package:nomishop/features/Shop/controllers/product/checkout_controller.dart';
import 'package:nomishop/features/Shop/controllers/product/variation_controller.dart';
import 'package:nomishop/features/personilzation/controllers/address_controller.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
   Get.put(NetworkManager());
   Get.put(VariationController());
   Get.put(AddressController());
   Get.put(CheckoutController());
  }

}