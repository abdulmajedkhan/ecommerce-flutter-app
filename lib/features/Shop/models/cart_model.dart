class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, dynamic>?
      selectedVariation; // just for the safety i have changed to the dynamic but if it gives error I have to change it to <String, String>

  CartItemModel({
    this.title = '',
    required this.productId,
    this.price = 0.0,
    this.image,
    this.brandName,
    required this.quantity,
    this.selectedVariation,
    this.variationId = '',
  });
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  /// convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Price': price,
      'Image': image,
      'BrandName': brandName,
      'Quantity': quantity,
      'SelectedVariation': selectedVariation,
      'VariationId': variationId,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        productId: json['ProductId'],
        price: json['Price'].toDouble(),
        image: json['Image'],
        brandName: json['BrandName'],
        quantity: json['Quantity'],
        selectedVariation: json['SelectedVariation'] != null
            ? Map<String, dynamic>.from(json['SelectedVariation'])
            : null,
        variationId: json['VariationId']);
  }
}
