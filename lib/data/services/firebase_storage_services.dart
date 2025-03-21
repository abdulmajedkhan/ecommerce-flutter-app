import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NFirebaseStorageServices extends GetxController {
  final _firebaseStorage = FirebaseStorage.instance;

  ///Upload local assets from IDE
  ///Returns a Uint8List containig image data
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw 'Error loading image data : $e';
    }
  }

  ///Upload image using ImageData on cloud firebase storage
  ///Returns the download URL of the uploaded image
  Future<String>  uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // handle exceptions grace fully
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception : ${e.message}';
      } else if (e is SocketException) {
        throw ' Socket Exception: ${e.message}';
      } else {
        throw 'Something went wrong! Please try again.';
      }
    }
  }

  ///Upload Image on cloud firestore storage
  ///Returns the download URL of the uploaded image.
  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref(path).child(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // handle exceptions grace fully
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception : ${e.message}';
      } else if (e is SocketException) {
        throw ' Network error: ${e.message}';
      } else {

        throw 'Something went wrong! Please try again.';
      }
    }
  }
}
