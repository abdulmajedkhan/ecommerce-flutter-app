import 'dart:convert';

import 'package:get/get.dart';

import 'package:nomishop/util/local_storage/storage_utility.dart';
import 'package:nomishop/util/popups/loaders.dart';

import '../../../../data/repositries/Product/product_repository.dart';
import '../../models/poduct_model.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  /// Observable map to store favorite product IDs
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  /// Method to initialize favorites by reading from storage
  Future<void> initFavorites() async {
    final json = await NLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  /// Check if a product is marked as favorite
  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  /// Toggle the favorite status of a product
  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoriteToStorage();
      NLoaders.customToasts(message: 'Product has been added to the Wishlist.');
    } else {
      NLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoriteToStorage();
      NLoaders.customToasts(
          message: 'Product has been removed from the Wishlist.');
    }
  }

  /// Save current favorites to local storage
  void saveFavoriteToStorage() {
    final encodedFavorites = json.encode(favorites);
    NLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  /// Fetch favorite products from Firestore
  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance
        .getFavoriteProducts(favorites.keys.toList());
  }
}
