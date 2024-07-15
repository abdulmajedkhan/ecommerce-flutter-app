import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:nomishop/common/widgets/section_heading/section_heading.dart';
import 'package:nomishop/features/Shop/models/poduct_model.dart';
import 'package:nomishop/features/Shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:nomishop/features/Shop/screens/product_details/widgets/product_attributes.dart';
import 'package:nomishop/features/Shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:nomishop/features/Shop/screens/product_details/widgets/rating_category.dart';
import 'package:nomishop/util/constants/enums.dart';
import 'package:nomishop/util/constants/sizes.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/custom_shapes/round-image/rounded_images.dart';


class ProductDetailScreen extends StatelessWidget {

  const ProductDetailScreen({super.key, required this.product,


  });
final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 8),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              radius: 80,
              child: Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ),
        ),
        title: const Text('Product Details'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: NFavoriteIcon(productId: product.id,),
          )
        ],
      ),
      bottomNavigationBar:  NBottomAddToCart(product:product),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
                height: 400,
                child: Center(child:NRoundedImage(
                  imageUrl: product.thumbnail,
                  applyImageRadius: true,
                  isNetworkImage: true,
                ), )),
            Container(
              margin: const EdgeInsets.all(15),
              ///Product Details
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Product category and ratings
                  const NRatingAndCategory(),
                  /// - price, Title, Brand
                 NProductMetaData(product: product,),
                  if(product.productType==ProductType.variable.toString()) NProductAttributes(product: product,),
                  if(product.productType==ProductType.variable.toString()) const SizedBox(height: NSizes.spaceBtwItems,),
                  /// CheckOUt Button
                  SizedBox( width:double.infinity,child: ElevatedButton(child: const Text('Check Out'), onPressed: (){},)),
                  const SizedBox(height: NSizes.spaceBtwItems,),
                  /// Description
                  const NSectionHeading(title: 'Description', showActionButton: false,),
                 ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// Reviews
                  const Divider(),
                  const SizedBox(height: NSizes.spaceBtwItems,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    NSectionHeading(title: 'Reviews(199', onPressed: (){}, showActionButton: true,),
                    IconButton(icon:const Icon(Iconsax.arrow_right_3, size: 18,) , onPressed: (){},)
                  ],),
                  const SizedBox(height: NSizes.spaceBtwItems,),





                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}





class DressSize extends StatelessWidget {
  const DressSize({super.key,
    required this.dressSize
  });
  final String dressSize;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)

          ),
          constraints: const BoxConstraints(
              minWidth: 40
          ),
          child: Center(
            child: Text(dressSize, style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400
                ,color: Colors.white
            ),),
          ),
        )
      ],

    );
  }
}

