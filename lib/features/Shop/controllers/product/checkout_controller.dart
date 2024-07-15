import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/common/widgets/section_heading/section_heading.dart';
import 'package:nomishop/features/Shop/models/payment_method_model.dart';

import '../../../../util/constants/sizes.dart';
import '../../screens/checkout/widgets/payments_tile.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance=> Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod=PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    selectedPaymentMethod.value= PaymentMethodModel(
      name: 'Paypal',image: 'assets/images/payment_methods/paypal.png',
    );
    super.onInit();
  }
  Future<dynamic> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(context: context, builder: (_)=>SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(NSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NSectionHeading(title: 'Select Payment Method', showActionButton: false,),
              const SizedBox(height: NSizes.spaceBtwSections,),
              NPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: 'assets/images/payment_methods/paypal.png'),),
              const SizedBox(height: NSizes.spaceBtwItems/2,),
              NPaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: 'assets/images/payment_methods/paypal.png'),),
              const SizedBox(height: NSizes.spaceBtwItems/2,),
              NPaymentTile(paymentMethod: PaymentMethodModel(name: 'Apple Pay', image: 'assets/images/payment_methods/paypal.png'),),
              const SizedBox(height: NSizes.spaceBtwItems/2,),
              NPaymentTile(paymentMethod: PaymentMethodModel(name: 'VISA', image: 'assets/images/payment_methods/paypal.png'),),
              const SizedBox(height: NSizes.spaceBtwItems/2,),
              NPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: 'assets/images/payment_methods/paypal.png'),),
              const SizedBox(height: NSizes.spaceBtwItems/2,),
              NPaymentTile(paymentMethod: PaymentMethodModel(name: 'Cash on Delivery', image: 'assets/images/payment_methods/paypal.png'),),
              const SizedBox(height: NSizes.spaceBtwItems/2,),
              SizedBox(height: NSizes.spaceBtwSections,)

            ],
        ),

      ),
    ));
  }

}