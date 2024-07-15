import 'package:flutter/material.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/constants/text_Strings.dart';

class NLoginHeader extends StatelessWidget {
  const NLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ClipRRect(
            child: Image(
              image: AssetImage(
                'assets/images/logos/lightlogo.png'
              ),
            )),
        Text(NTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: NSizes.sm),
        Text(
          NTexts.loginDescription,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: NSizes.spaceBtwSections,
        ),
      ],
    );
  }
}