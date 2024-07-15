import 'package:flutter/material.dart';
import 'package:nomishop/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:nomishop/util/device/device_utility.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final dark = NHelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: NDeviceUtils.getBottomNavigationBarHeight(),
        left: NSizes.defaultSpacing,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          count: 3,
          onDotClicked: controller.dotNavigationClick,
          effect: ExpandingDotsEffect(
              activeDotColor: dark ? Colors.white : Colors.black, dotHeight: 6),
        ));
  }
}
