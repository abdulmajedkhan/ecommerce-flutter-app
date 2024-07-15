import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/common/widgets/list_tiles/animation_loader.dart';
import 'package:nomishop/features/Shop/controllers/cart_controller.dart';
import 'package:nomishop/features/Shop/screens/cart/widgets/cart_item.dart';
import 'package:nomishop/features/Shop/screens/checkout/checkout.dart';
import 'package:nomishop/navigation_menu.dart';

import '../../../../util/constants/sizes.dart';

class CartScreen extends StatelessWidget {
 CartScreen({super.key});
  final controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const Text(''),
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Obx(() {
        final emptyWidget = NAnimationLoaderWidget(
          text: 'Whoops! Cart is Empty.',
          animation: 'assets/images/animations/docerAnimation.json',
          showAction: true,
          actionText: 'Let\'s  fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );
        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(NSizes.defaultSpacing),
              child: NCartItem(),
            ),
          );
        }
      }),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : ElevatedButton(
              child: Obx(
                  () => Text('Checkout \$${controller.totalCartPrice.value}')),
              onPressed: () => Get.to(() => const CheckoutScreen()),
            ),
    );
  }
}
