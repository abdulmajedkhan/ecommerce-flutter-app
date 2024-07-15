import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/widgets/icons/n_circular_icon.dart';
import 'package:nomishop/features/Shop/controllers/cart_controller.dart';
import 'package:nomishop/features/Shop/models/poduct_model.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';

class NBottomAddToCart extends StatelessWidget {
  const NBottomAddToCart({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = NHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: NSizes.defaultSpacing / 2,
          horizontal: NSizes.defaultSpacing),
      decoration: BoxDecoration(
          color: dark ? NColors.darkerGrey : NColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(NSizes.cardRadiusLg),
            bottomRight: Radius.circular(NSizes.cardRadiusLg),
          )),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                NCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: NColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: NColors.white,
                  onPressed: () => controller.productQuantityInCart.value > 0
                      ? controller.productQuantityInCart.value -= 1
                      : null,
                ),
                const SizedBox(
                  width: NSizes.spaceBtwItems,
                ),
                Text(
                  controller.productQuantityInCart.value.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  width: NSizes.spaceBtwItems,
                ),
                NCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: NColors.darkerGrey,
                  width: 40,
                  height: 40,
                  color: NColors.white,
                  onPressed: () => controller.productQuantityInCart.value += 1,
                ),
              ],
            ),
            ElevatedButton(
              onPressed:
                controller.productQuantityInCart.value < 1
                    ? null
                    : () => controller.addToCart(product),

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(NSizes.sm),
                  backgroundColor: NColors.black,
                  side: const BorderSide(color: NColors.black)),
              child: const Text('Add to Cart'),
            )
          ],
        ),
      ),
    );
  }
}
