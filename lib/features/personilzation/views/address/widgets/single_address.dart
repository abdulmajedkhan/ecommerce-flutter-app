import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:nomishop/features/personilzation/controllers/address_controller.dart';
import 'package:nomishop/features/personilzation/models/address_model.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.onTap, required this.address});
  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = NHelperFunctions.isDarkMode(context);
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: NRoundedContainer(
          showBorder: true,
          padding: const EdgeInsets.all(NSizes.md),
          width: double.infinity,
          backgroundColor: selectedAddress
              ? NColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? NColors.darkerGrey
                  : NColors.grey,
          margin: const EdgeInsets.only(bottom: NSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle : null,
                  color: selectedAddress
                      ? dark
                          ? NColors.light
                          : NColors.dark
                      : null,
                ),
              ),
              Column(
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: NSizes.sm / 2,
                  ),
                  Text(
                    address.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: NSizes.sm / 2,
                  ),
                  Text(
                    address.toString(),
                    softWrap: true,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
