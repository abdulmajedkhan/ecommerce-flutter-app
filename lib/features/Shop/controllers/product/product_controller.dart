import 'package:get/get.dart';

import '../../../../data/repositries/Product/product_repository.dart';
import '../../../../util/constants/enums.dart';
import '../../../../util/popups/loaders.dart';
import '../../models/poduct_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      //show loader while loading the product
      isLoading.value = true;

      // fetch products
      final products = await productRepository.getFeaturedProducts();

      //Assign Products
      featuredProducts.assignAll(products);
    } catch (error) {
      NLoaders.errorSnackBar(title: 'oh Snap', message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get the product prices or range of the variations
  String getTheProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variations exist, return simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      // Calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        // Determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider =
        variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Update the smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // Format the price range or return the single price if all variations have the same price
      if (smallestPrice == largestPrice) {
        return smallestPrice.toString();
      } else {
        return '${smallestPrice.toStringAsFixed(2)} - ${largestPrice.toStringAsFixed(2)}';
      }
    }
  }


  /// Calculate the discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice){
    if(salePrice==null || salePrice<=0.0) return null;
    if(originalPrice<=0) return null;
    double percentage= ((originalPrice-salePrice)/originalPrice)*100;
    return percentage.toStringAsFixed(0);
  }
  String getProductStockStatus(int stock){
    return stock>0?'In stock': 'out of stock';
  }
}
