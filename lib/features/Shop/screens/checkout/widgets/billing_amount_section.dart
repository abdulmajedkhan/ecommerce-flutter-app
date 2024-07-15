import 'package:flutter/material.dart';
import 'package:nomishop/features/Shop/controllers/cart_controller.dart';
import 'package:nomishop/util/helpers/pricing_calculator.dart';

import '../../../../../util/constants/sizes.dart';
class NBillingAmountSection extends StatelessWidget {
  const NBillingAmountSection({super.key});


  @override
  Widget build(BuildContext context) {
    final cartController= CartController.instance;
    final subTotal=cartController.totalCartPrice.value;

    return Column(
      children: [
        ///Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$$subTotal', style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        const SizedBox(
          height: NSizes.spaceBtwItems/2,
        ),
        ///ShippingFee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${NPricingCalculator.calculateShippingCost(subTotal, 'US')}', style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        const SizedBox(
          height: NSizes.spaceBtwItems/2,
        ),
        ///TaxFee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${NPricingCalculator.calculateTax(subTotal, 'US')}', style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        const SizedBox(
          height: NSizes.spaceBtwItems/2,
        ),
        /// order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${NPricingCalculator.calculateTotalPrice(subTotal, 'US')}', style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
      ],
    );
  }
}
