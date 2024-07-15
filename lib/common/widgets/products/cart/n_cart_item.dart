import 'package:flutter/material.dart';
import 'package:nomishop/features/Shop/models/cart_model.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';


import '../../custom_shapes/round-image/rounded_images.dart';
import '../../texts/product_title_texts.dart';

class NCartItems extends StatelessWidget {
  const NCartItems({
    super.key, required this.cartItem,
  });
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NRoundedImage(
          imageUrl: cartItem.image ??'',
          isNetworkImage: true,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(NSizes.sm),
          backgroundColor: NHelperFunctions.isDarkMode(context)? NColors.darkerGrey : NColors.light,
        ),
        const SizedBox(width: NSizes.spaceBtwItems,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cartItem.brandName??''),
              NProductTitleText(title: cartItem.title,maxLines: 1,),
              Text.rich(
                  TextSpan(
                      children: (cartItem.selectedVariation ?? {}).entries.map((e)=>TextSpan(
                        children: [
                          TextSpan(text: e.key, style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: e.value, style: Theme.of(context).textTheme.bodyLarge),

                        ]
                      )).toList()
                  )
              )

            ],
          ),
        )
      ],
    );
  }
}