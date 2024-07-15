import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nomishop/data/repositries/authentication/authentication_repository.dart';
import 'package:nomishop/features/personilzation/models/user_model.dart';

import '../../../util/exceptions/firebase_excetpions.dart';
import '../../../util/exceptions/format_exceptions.dart';
import '../../../util/exceptions/platform_exception.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// function to save user data to firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw NFormatException('Format Exception:  ');
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  /// Function to fetch the user details based on user Id
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw NFormatException('Format Exception:  ');
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  /// Function to update User data in Firestore
  Future<void> updateUserData(UserModel updatedUser) async {
    try {
      await _db
          .collection("users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw NFormatException('Format Exception:  ');
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  ///Update a single field of User
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw NFormatException('Format Exception:  ');
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  /// Function to remove user data from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw NFormatException('Format Exception:  ');
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  /// Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref =
          FirebaseStorage.instance.ref(path).child(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw NFormatException('Format Exception:  ');
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }
}
