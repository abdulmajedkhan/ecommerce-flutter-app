import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nomishop/data/repositries/user/user_repository.dart';
import 'package:nomishop/features/authentication/views/email_verification/email_verification_screen.dart';
import 'package:nomishop/features/authentication/views/login/login_screen.dart';
import 'package:nomishop/features/authentication/views/onboarding/onboarding.dart';
import 'package:nomishop/navigation_menu.dart';
import 'package:nomishop/util/exceptions/platform_exception.dart';
import 'package:nomishop/util/local_storage/storage_utility.dart';

import '../../../util/exceptions/firebase_auth.dart';
import '../../../util/exceptions/firebase_excetpions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get the authenticated User data
  User? get authUser => _auth.currentUser;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        //initialize user specific storage
        await NLocalStorage.init(user.uid);

        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(EmailVerification(
          email: _auth.currentUser?.email,
        ));
      }
    } else {
      deviceStorage.write('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnboardingScreen());
    }
  }

  /* ---------------- Email and password Sign-in ---------------- */

  /// [EmailAuthentication] - Sign In
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw NFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong please try again';
    }
  }

  /// [EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw NFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong please try again';
    }
  }

  /// [EmailAuthentication] - ReAuthenticate Users

  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw NFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong please try again';
    }
  }

  /// [EmailVerification] - Mail Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw NFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong please try again';
    }
  }

  /// [EmailAuthentication] - Forget Passwords

/* ---------------- Federated identity and social login---------------- */
  /// [FacebookAuthentication] -Google

/* ---------------- ./end Federated identity and social login---------------- */
  /// [LogoutUser] - valid for authentication
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw NFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong please try again';
    }
  }

  /// DELETE USER  - Remove user auth and firebase account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw NFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong please try again';
    }
  }
}
