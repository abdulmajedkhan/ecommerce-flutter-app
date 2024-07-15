import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nomishop/data/repositries/authentication/authentication_repository.dart';
import 'package:nomishop/features/authentication/views/email_verification/success_screen.dart';
import 'package:nomishop/util/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email Whenever Verify Screen appear and get timer auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      NLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please Check you inbox and verify email');
    } catch (e) {
      NLoaders.errorSnackBar(title: 'oh Snap!', message: e.toString());
    }
  }

  /// Timer to automatically redirect on Email Verification
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user =FirebaseAuth.instance.currentUser;
        if(user?.emailVerified?? false){
          timer.cancel();
          Get.off(()=>  SuccessScreen(onPressed: ()=> AuthenticationRepository.instance.screenRedirect,));

        }
      },
    );
  }

  /// Manually Check if Email Verified
  checkEmailVerificationStatus() async{
    final currentUser= FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.off(()=>SuccessScreen(onPressed: ()=> AuthenticationRepository.instance.screenRedirect(),));
    }

  }


}
