import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:nomishop/common/widgets/texts/n_product_price_text.dart';
import 'package:nomishop/common/widgets/texts/product_title_texts.dart';
import 'package:nomishop/features/Shop/controllers/product/product_controller.dart';
import 'package:nomishop/features/Shop/models/poduct_model.dart';
import 'package:nomishop/util/constants/enums.dart';

import 'package:nomishop/util/constants/sizes.dart';

import '../../../../../util/constants/colors.dart';
class NProductMetaData extends StatelessWidget {
  const NProductMetaData({
    super.key, required this.product,

  });

final ProductModel product;


  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: NSizes.spaceBtwItems,),
        ///Sale tag
        Row(
          children: [
            NRoundedContainer(
              radius: NSizes.sm,
              backgroundColor: NColors.secondary,
              padding: const EdgeInsets.symmetric(horizontal: NSizes.sm, vertical: NSizes.xs),
              child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: NColors.black),),
            ),
            const SizedBox(width: NSizes.spaceBtwItems,),
            ///Price
             if(product.productType ==ProductType.single.toString() && product.salePrice>0 )
                 Text('\$${product.price}', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
            if(product.productType ==ProductType.single.toString() && product.salePrice>0 ) const SizedBox(width: NSizes.spaceBtwItems,),
                 NProductPriceText(price: controller.getTheProductPrice(product), isLarge: true,)
          ],
        ),
        const SizedBox(
         height: NSizes.spaceBtwItems/2,
        ),
        ///title
        NProductTitleText(title: product.title,),

        ///Stock Status
        Row(children: [
          const NProductTitleText(title: 'Status'),
          const SizedBox(width: NSizes.spaceBtwItems,),
          Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium,)
        ],),
        const SizedBox(height: NSizes.spaceBtwItems/2,),

        ///Brand Name
        Row(
          children: [
            Text(product.brand!=null ? product.brand!.name:''),
            const SizedBox(width: NSizes.spaceBtwItems,),
            const Icon(Iconsax.verify),


          ],
        ),
        const Column(
          children: [

          ],
        ),



        const SizedBox(height: NSizes.spaceBtwItems,),

      ],

    );
  }
}
