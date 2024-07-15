import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../data/repositries/authentication/authentication_repository.dart';
import '../../../../data/services/netwotk_manager.dart';
import '../../../../util/popups/full_screen_loader.dart';
import '../../../../util/popups/loaders.dart';

 class LoginController extends GetxController{

  /// Variables

  final rememberMe=false.obs;
  final hidePassword=true.obs;
  final localStorage= GetStorage();
  final email =TextEditingController();
  final password=TextEditingController();
  GlobalKey<FormState> loginFormKey =GlobalKey<FormState>();



  @override
  void onInit() {

    final rememberedEmail = localStorage.read("REMEMBER_ME_EMAIL");
    final rememberedPassword = localStorage.read("REMEMBER_ME_PASSWORD");
    if (rememberedEmail != null) {
      email.text = rememberedEmail;
    }
    if (rememberedPassword != null) {
      password.text = rememberedPassword;
    }
    super.onInit();


  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      //Start Loading


      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      //Form Validation
      if (!loginFormKey.currentState!.validate()) return;

      //Remember me ===> save DAta
     if(rememberMe.value){
       localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
       localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
     }
      NFullScreenLoader.openLoadingDialog(
          'We are processing your information...',
          'assets/images/animations/docerAnimation.json');
      //Register User in the firebase Authentication and save user data in the firebase
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(
          email.text.trim(), password.text.trim());



      // remove loader
      NFullScreenLoader.stopLoading();

      // Show Success
      NLoaders.successSnackBar(title: 'Logged In', );

      // Redirect
     AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Show Some Generic Error to the user
      NFullScreenLoader.stopLoading();
      NLoaders.errorSnackBar(title: 'oh snap!', message: e.toString());
    }
    finally {
      // Remove loader
      // NFullScreenLoader.stopLoading();
    }
  }

}