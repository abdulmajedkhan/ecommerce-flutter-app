import 'package:flutter/material.dart';
import 'package:nomishop/common/widgets/custom_shapes/round-image/rounded_images.dart';
import 'package:nomishop/common/widgets/products/productcards/horizontal_product_card.dart';
import 'package:nomishop/common/widgets/section_heading/section_heading.dart';
import 'package:nomishop/features/Shop/controllers/category_controller.dart';
import 'package:nomishop/features/Shop/models/category_model.dart';
import 'package:nomishop/util/helpers/n_cloud_helper_fucntions.dart';
import '../../../../util/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});
final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller=CategoryController.instance;
    return Scaffold(
        appBar: AppBar(
          title:  Text(category.name),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(NSizes.defaultSpacing),
            child: Column(
              children: [
                ///Banner
                const NRoundedImage(
                  width: double.infinity,
                  height: 250,
                  imageUrl: 'assets/images/products/category-1.jpg',
                  fit: BoxFit.cover,
                  applyImageRadius: true,
                ),
                const SizedBox(
                  height: NSizes.spaceBtwSections,
                ),

                /// Sub-categories
                FutureBuilder(
                  future: controller.getSubCategory(category.id),
                  builder: (context, snapshot){
                    // const loader=NHorizontalProductShimmer();
                    final widget =NCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if(widget!=null) return widget;


                    final subCategories=snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index){

                        final subCategory = subCategories[index];
                        return FutureBuilder(
                          future: controller.getCategoryProduct(categoryId: subCategory.id),
                          builder: (context, snapshot){

                             final widget =NCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if(widget!=null) return widget;


                    final products=snapshot.data!;
                            return Column(
                              children: [
                                ///heading
                                NSectionHeading(
                                  title: subCategory.name,
                                  // onPressed: () {},
                                ),
                                const SizedBox(
                                  height: NSizes.spaceBtwItems / 2,
                                ),
                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    itemBuilder: (context, index) =>
                                   NProductCardHorizontal(product:products[index]),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: products.length,
                                    separatorBuilder: (context, index) => const SizedBox(
                                      width: NSizes.spaceBtwItems,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },

                        );

                    }
                    );
                  },

                )
              ],
            ),
          ),
        ));
  }
}
