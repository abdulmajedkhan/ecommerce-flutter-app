import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:nomishop/common/widgets/list_tiles/animation_loader.dart';
import 'package:nomishop/util/helpers/helper_functions.dart';

import '../constants/colors.dart';

class NFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: NHelperFunctions.isDarkMode(Get.context!)
                  ? NColors.dark
                  : NColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 250,
                  ),
                  NAnimationLoaderWidget(text: text, animation: animation),
                ],
              ),
            )));
  }

  /// Stop the currently open Loading dialogue
  /// This method does not return any thing
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
