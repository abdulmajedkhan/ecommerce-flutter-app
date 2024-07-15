import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:nomishop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:nomishop/common/widgets/custom_shapes/round-image/rounded_images.dart';
import 'package:nomishop/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:nomishop/common/widgets/texts/n_product_price_text.dart';
import 'package:nomishop/common/widgets/texts/product_title_texts.dart';
import 'package:nomishop/features/Shop/models/poduct_model.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';
import '../../../../features/Shop/controllers/product/product_controller.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';

class NProductCardHorizontal extends StatelessWidget {
  const NProductCardHorizontal({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = NHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(NSizes.productImageRadius),
        color: dark ? NColors.darkerGrey : NColors.softGrey,
      ),
      child: Row(
        children: [
          ///ThumbNails
          NRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(NSizes.sm),
            backgroundColor: dark ? NColors.dark : NColors.light,
            child: Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
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
                        '25%',
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

          ///Details
          SizedBox(
            width: 172,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: NSizes.sm, left: NSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NProductTitleText(
                        title: product.title,
                        smallSize: true,
                      ),
                      SizedBox(
                        height: NSizes.spaceBtwItems / 2,
                      ),
                      Text(product.brand!.name),
                    ],
                  ),
                ),
                const SizedBox(
                  height: NSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Flexible(child: NProductPriceText(price: product.price.toString())),
                    Container(
                      decoration: const BoxDecoration(
                          color: NColors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(NSizes.cardRadiusMd),
                            bottomRight:
                                Radius.circular(NSizes.productImageRadius),
                          )),
                      child: const SizedBox(
                          width: NSizes.iconsLg * 1.2,
                          height: NSizes.iconsLg * 1.2,
                          child: Center(
                              child: Icon(
                            Iconsax.add,
                            color: NColors.white,
                          ))),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
