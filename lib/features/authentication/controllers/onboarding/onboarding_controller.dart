import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../views/login/login_screen.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  //Update current index when page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //Jump to specific dot selected pagge
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  //Update Current Index and jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage= GetStorage();
      storage.write('isFirstTime', false);
      Get.offAll(const LoginScreen());
    } else {
     double page = currentPageIndex.value + 1;
      pageController.jumpTo(page);
    }
  }

  //Update current Index and jum[ to last page

    void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
