import 'package:get/get.dart';

import 'package:nomishop/features/Shop/controllers/cart_controller.dart';

import '../../models/poduct_model.dart';
import '../../models/product_variation_model.dart';
import 'image_controller.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  /// Select attribute and variation
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    // When attrbute is selected we will first add that specific attribute
    final selectedAttribute = Map<String, dynamic>.from(selectedAttributes);
    selectedAttribute[attributeName] = attributeValue;
    selectedAttributes[attributeName] = attributeValue;
    final selectedVariation = product.productVariations!.firstWhere(
        (variation) =>
            _isSameAttributeValue(variation.attributeValues, selectedAttribute),
        orElse: () => ProductVariationModel.empty());
    // show the selected variation image as a main image
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    // Show selected variation qauantity is already in the caart
    if(selectedVariation.id.isNotEmpty){
      final cartController=CartController.instance;
      cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(product.id, selectedVariation.id);
    }


    // Assign the selected variation
    this.selectedVariation.value = selectedVariation;

    // update selected variation status
    getProductVariationStockStatus();
  }

  /// Check if  selected attrbute matches any variation
  bool _isSameAttributeValue(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    // if Selected attribute contains 3 and current variation contains 2 then return
    if (variationAttributes.length != selectedAttributes.values) return false;

    /// if any attribute is different then return
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes) return false;
    }
    return true;
  }

  /// Check Attribute  availability / stock in variation
  Set<String?> getAttributeAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    final availableVariationAttributesValues = variations
        .where((variation) =>
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();
    return availableVariationAttributesValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  // check product variation status
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }
  /// -- Reset Selected Attributes
  void resetSelectedAttributes(){
    selectedAttributes.clear();
    variationStockStatus.value='';
    selectedVariation.value=ProductVariationModel.empty();
  }
}
