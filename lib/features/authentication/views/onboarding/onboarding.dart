import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/features/authentication/views/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:nomishop/features/authentication/views/onboarding/widgets/onboarding_next_btn.dart';
import 'package:nomishop/features/authentication/views/onboarding/widgets/onboarding_page.dart';
import 'package:nomishop/features/authentication/views/onboarding/widgets/onboarding_skip.dart';

import 'package:nomishop/util/constants/text_Strings.dart';
import '../../../../util/constants/image_strings.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: onboardingImage1,
                title: NTexts.onboardingTitle1,
                subtitle: NTexts.onboardingSubTitle1,
              ),
              OnBoardingPage(
                image: onboardingImage2,
                title: NTexts.onboardingTitle2,
                subtitle: NTexts.onboardingSubTitle2,
              ),
              OnBoardingPage(
                image: onboardingImage3,
                title: NTexts.onboardingTitle3,
                subtitle: NTexts.onboardingSubTitle3,
              )
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNext()
        ],
      ),
    );
  }
}
