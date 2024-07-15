import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/rounded_container.dart';

import 'package:nomishop/common/widgets/products/cart/coupon_widget.dart';
import 'package:nomishop/features/Shop/controllers/cart_controller.dart';
import 'package:nomishop/features/Shop/screens/cart/widgets/cart_item.dart';
import 'package:nomishop/features/Shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:nomishop/features/Shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:nomishop/features/Shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';
import 'package:nomishop/util/helpers/pricing_calculator.dart';
import 'package:nomishop/util/popups/loaders.dart';

import '../../../../util/constants/colors.dart';
import '../../controllers/product/oder_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = NPricingCalculator.calculateTotalPrice(subTotal, 'US');
    final dark = NHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(NSizes.defaultSpacing),
              child: Column(
                children: [
                  ///Items in cart
                  const NCartItem(
                    showAddRemoveButtons: false,
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwSections,
                  ),

                  /// --Coupon TExtField
                  NCouponCode(dark: dark),
                  const SizedBox(
                    height: NSizes.spaceBtwSections,
                  ),
                  NRoundedContainer(
                    showBorder: true,
                    backgroundColor: dark ? NColors.black : NColors.white,
                    padding: const EdgeInsets.all(8),
                    child: const Column(
                      children: [
                        ///Pricing
                        NBillingAmountSection(),
                        SizedBox(
                          height: NSizes.spaceBtwItems,
                        ),

                        ///Divider
                        Divider(),
                        SizedBox(
                          height: NSizes.spaceBtwItems,
                        ),

                        ///Payment Methods
                        NBillingPaymentSection(),
                        SizedBox(
                          height: NSizes.spaceBtwItems,
                        ),

                        ///Address
                        NBillingAddressSection(),
                      ],
                    ),
                  )
                ],
              ))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(26.0),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => NLoaders.warningSnackBar(
                  title: 'Empty Cart',
                  message: 'Add items in the cart in order to proceed'),
          child: Text('Checkout \$t$totalAmount'),
        ),
      ),
    );
  }
}
