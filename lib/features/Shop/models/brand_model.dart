
class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productCounts;

  BrandModel(
      {required this.id,
      this.isFeatured,
      required this.image,
      this.productCounts,
      required this.name});

  /// Empty helper Function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  /// convert Model to json
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productCounts,
      'IsFeatured': isFeatured
    };
  }

  /// Map json oriented document snapshot from firebase to userModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? '',
        image: data['Image'] ?? '',
        name: data['Name'] ?? '',
        productCounts: data['ProductsCount']??''
    );
  }
}
