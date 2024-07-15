class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description,
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  /// Helper function to create an empty variation model
  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValues: {});

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Price': price,
      'Image': image,
      'Description': description,
      'SKU': sku,
      'Stock': stock,
      'AttributesValues': attributeValues,
      'SalePrice': salePrice,
    };
  }

  /// Map JSON to model
  factory ProductVariationModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      image: data['Image'] ?? '',
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      attributeValues: (data['AttributesValues'] != null && data['AttributesValues'] is Map)
          ? Map<String, String>.from(data['AttributesValues'])
          : {},
      description: data['Description'] ?? '',
    );
  }
}
