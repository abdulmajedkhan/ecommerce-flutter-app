import 'package:cloud_firestore/cloud_firestore.dart';

import 'product_attribute_model.dart';
import 'product_variation_model.dart';
import 'brand_model.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.stock,
    this.sku,
    required this.price,
    required this.title,
    this.date,
    this.salePrice = 0.0,
    required this.thumbnail,
    this.isFeatured,
    this.description,
    required this.categoryId,
    this.images,
    required this.productType,
    this.productAttributes,
    this.brand,
    this.productVariations,
  });

  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  /// Empty helper function
  static ProductModel empty() => ProductModel(
    id: '',
    stock: 0,
    sku: '',
    price: 0.0,
    title: '',
    thumbnail: '',
    categoryId: '',
    productType: '',
  );

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand?.toJson(),
      'Description': description,
      'ProductType': productType,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) return ProductModel.empty();

    return ProductModel(
      id: document.id,
      stock: data['Stock'] ?? 0,
      sku: data['SKU'] ?? '',
      price: data['Price']?.toDouble() ?? 0.0,
      title: data['Title'] ?? '',
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      productType: data['ProductType'] ?? '',
      isFeatured: data['IsFeatured']?? false,
      description: data['Description']??'',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList()
          : [],
    );
  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: document.id,
      stock: data['Stock'] ?? 0,
      sku: data['SKU'] ?? '',
      price: data['Price']?.toDouble() ?? 0.0,
      title: data['Title'] ?? '',
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      productType: data['ProductType'] ?? '',
      isFeatured: data['IsFeatured'],
      description: data['Description'],
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList()
          : [],
    );
  }
}
