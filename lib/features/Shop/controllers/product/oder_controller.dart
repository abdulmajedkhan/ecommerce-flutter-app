

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nomishop/data/repositries/Product/order_repository.dart';
import 'package:nomishop/data/repositries/authentication/authentication_repository.dart';
import 'package:nomishop/features/Shop/controllers/cart_controller.dart';
import 'package:nomishop/features/Shop/controllers/product/checkout_controller.dart';
import 'package:nomishop/features/Shop/models/order_model.dart';
import 'package:nomishop/features/authentication/views/email_verification/success_screen.dart';
import 'package:nomishop/features/personilzation/controllers/address_controller.dart';
import 'package:nomishop/util/constants/enums.dart';
import 'package:nomishop/util/popups/full_screen_loader.dart';
import 'package:nomishop/util/popups/loaders.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variable
  final cartController = CartController.instance;
  final addressController=AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(  OrderRepository());


  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async{
    try{
      final userOrders= await orderRepository.fetchUserOrders();
      return userOrders;
    } catch(e){
      NLoaders.warningSnackBar(title: 'Oh snap', message: e.toString());
      return [];
    }
  }

  /// Add methods for order Processing
 void processOrder(double totalAmount) async{
    try{
      NFullScreenLoader.openLoadingDialog('Processing your order', 'assets/images/animations/docerAnimation.json');

      // Get user authentication id
      final userId=AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) return;

      // Add Details
      final order= OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        // set date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // save order repository
      await orderRepository.saveOrder(order, userId);

      // update the cart status
      cartController.clearCart();

      // Show success screen
      Get.off(()=>SuccessScreen());
    }catch(e){
      NLoaders.errorSnackBar(title: 'oh snap', message: e.toString());
    }
 }

}
