import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
class NRatingAndCategory extends StatelessWidget {
  const NRatingAndCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'category Type',
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: NColors.darkGrey),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.yellow,
              size: 24,
            ),
            const SizedBox(
              width: NSizes.spaceBtwItems/2,
            ),
            Text.rich(TextSpan(
                children:[
                  TextSpan(text: '5.0', style: Theme.of(context).textTheme.bodyLarge),
                  const TextSpan(text: ('(199)'))
                ]
            ))

          ],
        ),
      ],
    );
  }
}