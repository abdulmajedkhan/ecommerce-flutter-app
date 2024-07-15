import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nomishop/data/repositries/authentication/authentication_repository.dart';
import 'package:nomishop/data/repositries/user/user_repository.dart';
import 'package:nomishop/data/services/netwotk_manager.dart';
import 'package:nomishop/features/authentication/views/login/login_screen.dart';
import 'package:nomishop/features/personilzation/views/profile_screen/widgets/re_authenticate_login_form.dart';
import 'package:nomishop/util/popups/full_screen_loader.dart';
import 'package:nomishop/util/popups/loaders.dart';

import '../../../util/constants/sizes.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // final profileLoading=false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  ///fetch User Record
  Future<void> fetchUserRecord() async {
    try {
      // profileLoading.value=true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      // profileLoading.value=false;
    }
  }

  /// save user record from any Registiration form
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // first update RX user and then check if user data is already stored if not store new data
      await fetchUserRecord();

      // if no record already existed
      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          // convert Name into firstName and LasName
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? '');
          final username = UserModel.generateUserName(
              userCredential.user?.displayName ?? '');

          // MapData
          final user = UserModel(
              id: userCredential.user!.uid,
              firstName: nameParts[0],
              lastName:
                  nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              username: username,
              email: userCredential.user!.email ?? '',
              phoneNumber: userCredential.user!.phoneNumber ?? '',
              profilePicture: userCredential.user!.photoURL ?? '');
          // save User Data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      NLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in you profile');
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(NSizes.sm),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: NSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel')),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      NFullScreenLoader.openLoadingDialog(
          'Processing', 'assets/images/animations/docerAnimation.json');

      /// First re-authenticate User
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re verify auth Email
        if (provider == 'password') {
          NFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthenticateLoginForm());
        }
      }
    } catch (e) {
      NFullScreenLoader.stopLoading();
      NLoaders.warningSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  /// Re Authenticate before deleting
  Future<void> reAuthenticateWithEmailAndPasswordUser() async {
    try {
      NFullScreenLoader.openLoadingDialog(
          'Processing', 'assets/images/animations/docerAnimation.json');
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;
      if (!reAuthFormKey.currentState!.validate()) return;

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      NFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      NFullScreenLoader.stopLoading();
      NLoaders.warningSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  /// Upload profile Image
  uploadUserProfilePicture() async {
try{
  final image= await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
  if(image!=null){
    // Upload Image
    final imageUrl= await userRepository.uploadImage('users/images/profile', image);

    // Update User Image Record
    Map<String, dynamic> json={'ProfilePicture': imageUrl};
    await userRepository.updateSingleField(json);

    user.value.profilePicture=imageUrl;
    NLoaders.successSnackBar(title: 'Congratulations', message: 'Your profile picture has been updated!');


  }
}catch(e){
  NLoaders.errorSnackBar(title: 'Og Snap!', message: 'Something went wrong: $e');
}
  }
}
