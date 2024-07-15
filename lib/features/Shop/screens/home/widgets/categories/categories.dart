import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/common/widgets/shimmer/category_shimmer.dart';
import 'package:nomishop/features/Shop/controllers/category_controller.dart';
import 'package:nomishop/features/Shop/screens/sub_category/sub_categories.dart';
import '../../../../../../common/widgets/custom_shapes/n_vertical_image_text.dart';

class NHomeCategories extends StatelessWidget {
  const NHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) return const NCategoryShimmer();
      if (categoryController.featuredCategories.isEmpty) {
        return const Center(
            child: Text(
          'No Data Found',
        ));
      }

      return SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return NVerticalImageText(
              image: category.image,
              title: category.name,
              onPressed: () => Get.to(() =>  SubCategoriesScreen(category:category)),
            );
          },
        ),
      );
    });
  }
}
