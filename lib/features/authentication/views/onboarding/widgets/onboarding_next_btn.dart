import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/device/device_utility.dart';
import 'package:nomishop/features/authentication/controllers/onboarding/onboarding_controller.dart';

class OnBoardingNext extends StatelessWidget {
  const OnBoardingNext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: NDeviceUtils.getBottomNavigationBarHeight(),
        right: NSizes.defaultSpacing,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
          ),
          child: const Icon(Iconsax.arrow_right_3),
          onPressed: () => OnboardingController.instance.nextPage(),
        ));
  }
}
