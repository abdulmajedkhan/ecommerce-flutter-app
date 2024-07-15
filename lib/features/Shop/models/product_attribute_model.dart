class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Values': values ?? [],
    };
  }

  /// Map JSON Oriented document snapshot from Firebase to Model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
      name: data['Name'] ?? '',
      values: data['Values'] != null ? List<String>.from(data['Values']) : [],
    );
  }
}
