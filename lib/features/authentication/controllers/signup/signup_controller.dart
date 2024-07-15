import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nomishop/data/repositries/authentication/authentication_repository.dart';
import 'package:nomishop/data/repositries/user/user_repository.dart';
import 'package:nomishop/data/services/netwotk_manager.dart';
import 'package:nomishop/features/authentication/views/email_verification/email_verification_screen.dart';
import 'package:nomishop/features/personilzation/models/user_model.dart';
import 'package:nomishop/util/popups/full_screen_loader.dart';
import 'package:nomishop/util/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// SIGNUP
  Future<void> signup() async {
    try {
      //Start Loading

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      //Form Validation
      if (!signupFormKey.currentState!.validate()) return;

      //Privacy Policy Check
      if (!privacyPolicy.value) {
        NLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account you must have to read and accept the privacy policy and terms of use.');
        return;
      }
      NFullScreenLoader.openLoadingDialog(
          'We are processing your information...',
          'assets/images/animations/docerAnimation.json');
      //Register User in the firebase Authentication and save user data in the firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // save Authenticated user data in the firebase firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // remove loader
      NFullScreenLoader.stopLoading();

      // Show Success
      NLoaders.successSnackBar(
          title: 'Congratulation',
          message: 'YOur Account has been created! Verify email to continue');

      // Move to verify email screen
      Get.to(() => EmailVerification(
            email: email.text.trim(),
          ));
    } catch (e) {
      // Show Some Generic Error to the user
      NLoaders.errorSnackBar(title: 'oh snap!', message: e.toString());
    } finally {
      // Remove loader
      // NFullScreenLoader.stopLoading();
    }
  }
}
