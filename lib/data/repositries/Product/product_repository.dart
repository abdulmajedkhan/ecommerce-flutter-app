import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nomishop/data/services/firebase_storage_services.dart';

import '../../../features/Shop/models/poduct_model.dart';
import '../../../util/constants/enums.dart';
import '../../../util/exceptions/firebase_excetpions.dart';
import '../../../util/exceptions/platform_exception.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firestore instance for database interaction
  final _db = FirebaseFirestore.instance;

  /// Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {

      throw 'Something went wrong please try again';
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong please try again';
    }
  }

  /// Get Product Based on query
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapShot = await query.get();
      final List<ProductModel> productList = querySnapShot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong please try again';
    }
  }

  Future<List<ProductModel>> getFavoriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong please try again';
    }
  }

  /// upload dummy data to the cloud firebase



  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      final storage = Get.put(NFirebaseStorageServices());

      for (var product in products) {

        // Upload thumbnail image
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);
        final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());
        product.thumbnail = url; // Ensure 'url' is treated as String

        // Upload additional images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrl = [];
          for (var image in product.images!) {
            final assetImage = await storage.getImageDataFromAssets(image);
            final url = await storage.uploadImageData('Products/Images', assetImage, image);
            imageUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imageUrl);
        }

        // Upload variations' images if applicable
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            final assetImage = await storage.getImageDataFromAssets(variation.image);
            final url = await storage.uploadImageData('Products/Images', assetImage, variation.image);
            variation.image = url; // Ensure 'url' is treated as String
          }
        }

        // Print the product data before uploading to Firestore

        // Set product data in Firestore
        await _db.collection('Products').doc(product.id).set(product.toJson());

      }
    } catch (e) {
      // Handle exceptions and log the error
      throw e.toString();
    }
  }

  Future<List<ProductModel>> getProductsForCategory({required String categoryId, int limit=4}) async{
    try{
      QuerySnapshot productCategoryQuery=limit==-1
    ? await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).get()
    : await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).limit(limit).get();

      /// extract productids from documents
      List<String> productIds= productCategoryQuery.docs.map((doc)=>doc['productId'] as String).toList();

      //
      final productsQuery = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();

      // Extract bran names
      List<ProductModel> products= productsQuery.docs.map((doc)=> ProductModel.fromSnapshot(doc)).toList();
      return products;
    }on FirebaseException catch (e) {
      throw NFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw NPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong please try again';
    }
  }

  // Future<void> uploadDummyData(List<ProductModel> products) async {
  //   try {
  //     final storage = Get.put(NFirebaseStorageServices());
  //
  //     for (var product in products) {
  //       final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);
  //       final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());
  //       product.thumbnail = url; // Ensure 'url' is treated as String
  //
  //       if (product.images != null && product.images!.isNotEmpty) {
  //         List<String> imageUrl = [];
  //         for (var image in product.images!) {
  //           final assetImage = await storage.getImageDataFromAssets(image);
  //           final url = await storage.uploadImageData('Products/Images', assetImage, image);
  //           imageUrl.add(url);
  //         }
  //         product.images!.clear();
  //         product.images!.addAll(imageUrl);
  //       }
  //       await _db.collection('Products').doc(product.id).set(product.toJson());
  //       if (product.productType == ProductType.variable.toString()) {
  //         for (var variation in product.productVariations!) {
  //           final assetImage = await storage.getImageDataFromAssets(variation.image);
  //           final url = await storage.uploadImageData('Products/Images', assetImage, variation.image);
  //           variation.image = url; // Ensure 'url' is treated as String
  //         }
  //       }
  //
  //
  //     }
  //   } on FirebaseException catch (e) {
  //     throw NFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw NPlatformException(e.code).message;
  //   } catch (e) {
  //
  //     throw e.toString();
  //   }
  // }

}
