import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

import '../constants/colors.dart';

class NLoaders{
  static hideSnackBar()=>ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToasts({required message}){
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
          elevation: 0,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: NHelperFunctions.isDarkMode(Get.context!)? NColors.darkerGrey.withOpacity(0.9) : NColors.grey.withOpacity(0.9)
            ),
            child: Center(
              child: Text(message, style: Theme.of(Get.context!).textTheme.labelLarge,),
            ),

          ))


    );
  }

  static successSnackBar({required title, message='', duration=3}){
    Get.snackbar(title, message,
    isDismissible: true,
      shouldIconPulse: true,
      colorText: NColors.white,
      backgroundColor: NColors.primary,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(20),
      icon:const Icon(Iconsax.check, color: NColors.white,)
    );
  }
  static warningSnackBar({required title, message='', duration=3}){
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: NColors.white,
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(20),
        icon:const Icon(Iconsax.warning_2, color: NColors.white,)
    );
  }
  static errorSnackBar({required title, message='', duration=3}){
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: NColors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(20),
        icon:const Icon(Iconsax.warning_2, color: NColors.white,)
    );
  }
}
