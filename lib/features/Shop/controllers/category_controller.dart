import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nomishop/data/repositries/Product/product_repository.dart';
import 'package:nomishop/data/repositries/categories/category_repositories.dart';
import 'package:nomishop/features/Shop/models/category_model.dart';

import '../../../util/popups/loaders.dart';
import '../models/poduct_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// --Load Category Data
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, etc.)
      final categories = await _categoryRepository.getAllCategories();

      //update the categories list
      allCategories.assignAll(categories);

      // filter featured categories list
      featuredCategories.assignAll(allCategories.where(
          (category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());
    } catch (e) {
      NLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value=false;
    }
  }

  /// --Load selected Category data
   Future<List<CategoryModel>> getSubCategory(String categoryId)async{
    try{
      final subCategories= await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e){
      NLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
      return [];
    }

   }


  ///  Get Category or sub_category products
 Future<List<ProductModel>> getCategoryProduct({required String categoryId, int limit=4}) async{
    try{
      final products=await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit:limit);
      return products;

    }catch (e){
      NLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
      return [];
    }

 }
}
