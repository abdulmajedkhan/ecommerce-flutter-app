import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nomishop/data/repositries/user/user_repository.dart';
import 'package:nomishop/data/services/netwotk_manager.dart';
import 'package:nomishop/features/personilzation/controllers/user_controller.dart';
import 'package:nomishop/features/personilzation/views/profile_screen/profile.dart';
import 'package:nomishop/util/popups/full_screen_loader.dart';

import '../../../util/popups/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  /// Variable
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when HomeScreen appears
  @override
  void onInit() {

    initializeName();
    updateUserName();
    super.onInit();
  }

  /// Fetch user Record
  Future<void> initializeName() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      NFullScreenLoader.openLoadingDialog('We are updating your information...',
          'assets/images/animations/docerAnimation.json');
      //check Connectivity
      final isConnected =await NetworkManager.instance.isConnected();
      if(!isConnected) return;

      // form Validation
      if(!updateUserNameFormKey.currentState!.validate()) {
        return;
      }


      // Update the user first name and last name
      Map<String , dynamic> name= {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};

      await userRepository.updateSingleField(name);

      // remove loader
      NFullScreenLoader.stopLoading();

      // Show Success message
      NLoaders.successSnackBar(title: 'Congratulations', message: 'Your name has been update');

      //Move to previous Screen
      Get.off(()=> const ProfileScreen());


    } catch (e){
      NFullScreenLoader.stopLoading();
      NLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


}