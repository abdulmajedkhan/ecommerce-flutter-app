import 'package:flutter/material.dart';
import 'package:nomishop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:nomishop/util/constants/colors.dart';

import '../../../../util/constants/sizes.dart';
class NCouponCode extends StatelessWidget {
  const NCouponCode({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return NRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? NColors.dark : NColors.white,
      padding: const EdgeInsets.only(
          top: NSizes.sm,
          bottom: NSizes.sm,
          right: NSizes.sm,
          left: NSizes.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'have promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  foregroundColor: dark? NColors.white.withOpacity(0.5): NColors.dark.withOpacity(0.5),
                  backgroundColor: Colors.grey,
                  side:BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                  )
              ),
              child: const Text('Apply'),
            ),
          )
        ],
      ),
    );
  }
}