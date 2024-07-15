import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomishop/features/Shop/models/category_model.dart';

import '../../../util/exceptions/firebase_auth.dart';
import '../../../util/exceptions/firebase_excetpions.dart';
import '../../../util/exceptions/platform_exception.dart';
import '../../services/firebase_storage_services.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variable
  final _db = FirebaseFirestore.instance;

  /// GEt All categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapShot = await _db.collection('Categories').get();
      final list = snapShot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
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

  /// Get Sub Categories

  Future<List<CategoryModel>> getSubCategories(String categoryId) async{
    try {
      final snapShot = await _db.collection('Categories').where(
          'ParentId', isEqualTo: categoryId).get();
      final result = snapShot.docs.map((e) => CategoryModel.fromSnapshot(e))
          .toList();
      return result;
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
  /// Upload Categories to firestore
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // Upload all the Categories along with their images
      final storage = Get.put(NFirebaseStorageServices());

      // Loop
      for (var category in categories) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // Upload Image and Get its URL
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        // Assign URL to category.image
        category.image = url;
        // Store  Category in FireStore
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
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
