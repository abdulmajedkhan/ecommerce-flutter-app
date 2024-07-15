import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/styles/shadows_style.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:nomishop/common/widgets/custom_shapes/round-image/rounded_images.dart';
import 'package:nomishop/common/widgets/texts/n_product_price_text.dart';
import 'package:nomishop/common/widgets/texts/product_title_texts.dart';
import 'package:nomishop/features/Shop/controllers/product/product_controller.dart';
import 'package:nomishop/features/Shop/models/poduct_model.dart';
import 'package:nomishop/features/Shop/screens/product_details/product_detail.dart';
import 'package:nomishop/util/constants/colors.dart';
import 'package:nomishop/util/constants/enums.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

import '../favorite_icon/favorite_icon.dart';
import 'add_to_cart_button.dart';

class NProductCardVertical extends StatelessWidget {
  const NProductCardVertical({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = NHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
            product: product,
          )),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [NShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(NSizes.productImageRadius),
          color: dark ? NColors.darkerGrey : Colors.white,
        ),
        child: Column(
          children: [
            NRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(1),
              backgroundColor: dark ? NColors.dark : NColors.light,
              child: Stack(
                children: [
                  //Thumbnail Image
                  Center(
                    child: NRoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
                  // Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: NRoundedContainer(
                        radius: NSizes.md,
                        backgroundColor: NColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: NSizes.sm, vertical: NSizes.xs),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: NColors.black),
                        ),
                      ),
                    ),
                  //Favorite Icon Button
                  Positioned(
                      right: 0,
                      top: 0,
                      child: NFavoriteIcon(
                        productId: product.id,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: NSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NProductTitleText(
                    title: product.title,
                    smallSize: true,
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwItems / 2,
                  ),

                  /// brand name with verified icon
                  Row(
                    children: [
                      Text(
                        product.brand!.name,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: NSizes.xs,
                      ),
                      const Icon(
                        Iconsax.verify5,
                        color: NColors.primary,
                        size: NSizes.iconsXs,
                      )
                    ],
                  ),

                  ///price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            if (product.productType ==
                                    ProductType.single.toString() &&
                                product.salePrice > 0)
                              Padding(
                                padding: EdgeInsets.only(left: NSizes.sm),
                                child: Text(
                                  product.price.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),

                                //. to add the discount [rice after here
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: NSizes.sm),
                              child: NProductPriceText(
                                price: controller.getTheProductPrice(product),
                                // isLarge: true,
                              ),
                            )
                          ],
                        ),
                      ),

                      /// Add to Cart
                      ProductAddToCartButton(
                        product: product,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
