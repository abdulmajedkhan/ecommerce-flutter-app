import 'package:flutter/material.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/device/device_utility.dart';
import 'package:nomishop/features/authentication/controllers/onboarding/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: NDeviceUtils.getAppBarHeight(),
      right: NSizes.defaultSpacing,
      child: TextButton(
        onPressed: () => OnboardingController.instance.skipPage(),
        child: const Text('Skip'),
      ),
    );
  }
}
