import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/features/Shop/controllers/cart_controller.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../icons/n_circular_icon.dart';
class NProductQuantityWithAddRemoveButton extends StatelessWidget {

  const NProductQuantityWithAddRemoveButton({
    super.key, required this.quantity, this.add, this.remove,
  });
final int quantity;
final VoidCallback? add, remove;
  @override
  Widget build(BuildContext context) {
    final cartController=CartController.instance;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        NCircularIcon(icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: NSizes.md,
          color: NHelperFunctions.isDarkMode(context)? NColors.white : NColors.black,
          backgroundColor: NHelperFunctions.isDarkMode(context)? NColors.darkerGrey: NColors.light,
          onPressed: remove,
        ),
        const SizedBox(width: NSizes.spaceBtwItems/2,),
        Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall,),
        const SizedBox(width: NSizes.spaceBtwItems/2,),
       NCircularIcon(icon: Iconsax.add,
          width: 32,
          height: 32,
          size: NSizes.md,
          color: NColors.white,
          backgroundColor: NColors.primary,
          onPressed: add,
        ),

      ],);
  }
}