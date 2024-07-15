

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:nomishop/features/Shop/controllers/product/checkout_controller.dart';
import 'package:nomishop/features/Shop/models/payment_method_model.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';

class NPaymentTile extends StatelessWidget{
  const NPaymentTile({super.key, required this.paymentMethod, });
  final PaymentMethodModel paymentMethod;
  @override
  Widget build(BuildContext context) {
    final controller=CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: (){
        controller.selectedPaymentMethod.value=paymentMethod;
        Get.back();
      },
      leading: NRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: NHelperFunctions.isDarkMode(context)? NColors.light: NColors.white,
        padding: const EdgeInsets.all(NSizes.sm),
        child: Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain,),


      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),

    );
  }

}