import 'package:get/get.dart';
import 'package:nomishop/features/Shop/controllers/product/variation_controller.dart';
import 'package:nomishop/features/Shop/models/cart_model.dart';
import 'package:nomishop/features/Shop/models/poduct_model.dart';
import 'package:nomishop/util/constants/enums.dart';
import 'package:nomishop/util/local_storage/storage_utility.dart';
import 'package:nomishop/util/popups/loaders.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();
  CartController() {
    loadCartItems();
  }

  // Variable
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  // add items in the cart
  void addToCart(ProductModel product) {
    if (productQuantityInCart.value < 1) {
      NLoaders.customToasts(message: 'Select Quantity');
      return;
    }

    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      NLoaders.customToasts(message: 'Select Variation');
      return;
    }

    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        NLoaders.warningSnackBar(
            title: 'Oh Snap!', message: 'Selected Variation is out of stock');
        return;
      } else {
        if (product.stock < 1) {
          NLoaders.warningSnackBar(
              title: 'Oh Snap!', message: 'Selected product is out of stock');
          return;
        }
      }
    }

    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);
    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }
    updateCart();
    NLoaders.customToasts(message: 'Your product has been added to the cart.');
  }

  /// This function convert a productModel to CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Reset Variation in case of single product
      variationController.resetSelectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;
    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      variationId: variation.id,
      selectedVariation: isVariation ? variation.attributeValues : null,
      brandName: product.brand != null ? product.brand!.name : '',
      image: isVariation ? variation.image : product.thumbnail,
      price: product.price,
      title: product.title,
    );
  }

  /// Update the cart Values
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialogue(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void updateCartTotals() {
    double calculatedPrice = 0.0;
    int calculatedNoOfItems = 0;
    for (var item in cartItems) {
      calculatedPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculatedPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemString = cartItems.map((item) => item.toJson()).toList();
    NLocalStorage.instance().writeData('cartItems', cartItemString);
  }

  void loadCartItems() {
    final cartItemStrings =
        NLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);

    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );

    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  void removeFromCartDialogue(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        NLoaders.customToasts(message: 'Product removed from the cart.');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  /// Initialize already added Item's count in the cart
  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // get selected variation if any....
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
}
