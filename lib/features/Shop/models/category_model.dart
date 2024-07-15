import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  ///Empty helper functions
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  ///convert model to Json structure so that you can store the data in firebase
  Map<String,
          dynamic> /* here is this '?' mark if there is an any issue i will have to update*/
      toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  ///Map in Json oriented document snapshot from firebase to User Model
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    if (data != null) {
      final String id = document.id;
      final String name = data['Name'] ?? '';
      final String image = data['Image'] ?? '';
      final bool isFeatured = data['IsFeatured'] ?? false;
      final String parentId = data['ParentId'] ?? '';

      return CategoryModel(
          id: id,
          name: name,
          image: image,
          isFeatured: isFeatured,
          parentId: parentId);
    } else {
      // Handle the case where data is null gracefully
      return CategoryModel.empty();
    }
  }
}
