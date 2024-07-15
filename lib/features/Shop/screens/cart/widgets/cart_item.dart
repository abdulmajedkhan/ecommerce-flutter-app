import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nomishop/features/Shop/controllers/cart_controller.dart';

import '../../../../../common/widgets/products/cart/add_rmove_button.dart';
import '../../../../../common/widgets/products/cart/n_cart_item.dart';
import '../../../../../common/widgets/texts/n_product_price_text.dart';
import '../../../../../util/constants/sizes.dart';

class NCartItem extends StatelessWidget {
  const NCartItem({super.key, this.showAddRemoveButtons = true});
  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(() {
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) => Obx(() {
                final item = cartController.cartItems[index];
                return Column(
                  children: [
                    NCartItems(
                      cartItem: item,
                    ),
                    if (showAddRemoveButtons)
                      const SizedBox(
                        height: NSizes.spaceBtwSections,
                      ),
                    if (showAddRemoveButtons)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 70,
                              ),
                              NProductQuantityWithAddRemoveButton(
                                quantity: item.quantity,
                                add: () => cartController.addOneToCart(item),
                                remove: () =>
                                    cartController.removeOneFromCart(item),
                              ),
                            ],
                          ),
                          NProductPriceText(
                            price:
                                (item.price * item.quantity).toStringAsFixed(1),
                          ),
                        ],
                      ),
                  ],
                );
              }),
          separatorBuilder: (_, __) => const SizedBox(
                height: NSizes.spaceBtwSections,
              ),
          itemCount: cartController.cartItems.length);
    });
  }
}
