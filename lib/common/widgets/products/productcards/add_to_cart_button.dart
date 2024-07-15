import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:nomishop/features/Shop/controllers/cart_controller.dart';
import 'package:nomishop/features/Shop/screens/product_details/product_detail.dart';
import 'package:nomishop/util/constants/enums.dart';

import '../../../../features/Shop/models/poduct_model.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';

class ProductAddToCartButton extends StatelessWidget {
  const ProductAddToCartButton({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else{
          Get.to(()=>ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart =
            cartController.getProductQuantityInCart(product.id);

        return Container(
          decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? NColors.primary : NColors.dark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(NSizes.cardRadiusMd),
                bottomRight: Radius.circular(NSizes.productImageRadius),
              )),
          child: SizedBox(
              width: NSizes.iconsLg * 1.2,
              height: NSizes.iconsLg * 1.2,
              child: Center(
                  child: productQuantityInCart > 0
                      ? Text(
                          productQuantityInCart.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: NColors.white),
                        )
                      : const Icon(
                          Iconsax.add,
                          color: NColors.white,
                        ))),
        );
      }),
    );
  }
}
