import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:nomishop/common/widgets/section_heading/section_heading.dart';
import 'package:nomishop/features/Shop/controllers/product/checkout_controller.dart';
import 'package:nomishop/features/Shop/screens/checkout/widgets/payments_tile.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
class NBillingPaymentSection extends StatelessWidget {
  const NBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CheckoutController());
    final dark=NHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        NSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: ()=>controller.selectPaymentMethod(context), ),
        const SizedBox(
          height: NSizes.spaceBtwItems,
        ),
        Obx(
          ()=> Row(
            children: [
              NRoundedContainer(
                width: 60,
                height: 22,
                backgroundColor: dark? NColors.light: NColors.white,
                child: Image(image: AssetImage(controller.selectedPaymentMethod.value.image, ), fit: BoxFit.contain,),

              ),
              const SizedBox(width: NSizes.spaceBtwItems/2,),
              Text(controller.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge,)
            ],
          ),
        )
      ],
    );
  }
}
