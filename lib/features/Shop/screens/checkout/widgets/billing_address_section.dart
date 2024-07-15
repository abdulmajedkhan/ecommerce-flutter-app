import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/common/widgets/section_heading/section_heading.dart';
import 'package:nomishop/features/personilzation/controllers/address_controller.dart';

import '../../../../../util/constants/sizes.dart';

class NBillingAddressSection extends StatelessWidget {
  const NBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),
        addressController.selectedAddress.value.id.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Noman Ayaz',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwItems / 2,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(
                        width: NSizes.spaceBtwItems,
                      ),
                      Text(
                        '+92 341 159317',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: NSizes.spaceBtwItems / 2,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_history,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(
                        width: NSizes.spaceBtwItems,
                      ),
                      Expanded(
                        child: Text(
                          'Malakand division, KpK, Pakistan',
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Text('Select Address',
                style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}
