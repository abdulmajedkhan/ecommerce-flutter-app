import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nomishop/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:nomishop/features/Shop/screens/home/widgets/categories/categories.dart';
import 'package:nomishop/categories_page.dart';
import 'package:nomishop/common/widgets/layouts/grid_layout.dart';
import 'package:nomishop/common/widgets/products/productcards/vertical_product_card.dart';
import 'package:nomishop/discount_container.dart';
import 'package:nomishop/features/personilzation/controllers/user_controller.dart';
import 'package:nomishop/util/constants/sizes.dart';
import '../../../../common/widgets/custom_shapes/round-image/circular_image.dart';
import '../../controllers/product/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
       // leading: SizedBox(),
        toolbarHeight: 100,
     title: Container(

          margin: const EdgeInsets.only(top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, Welcome',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: Colors.grey)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Text(
                          controller.user.value.fullName,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image = networkImage.isNotEmpty
                        ? networkImage
                        : 'assets/images/user-1.png';
                    return NCircularImage(
                      image: image,
                      width: 80,
                      height: 80,
                      isNetworkImage: networkImage.isNotEmpty,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
      body: const NomiShop(),
    );
  }
}

class NomiShop extends StatelessWidget {
  const NomiShop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ProductController());
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          //TODO: this is the row fir search bar and Icon
          const SearchBar(),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              //TODO: Row for the slide discount Offers
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    DisountContainers(
                        title: 'New Collection',
                        descriptionOffers:
                            'Discount 50% for\nthe first transaction'),
                    DisountContainers(
                        title: 'New Collection',
                        descriptionOffers:
                            'Discount 50% for\nthe first transaction'),

                  ],
                ),
              ),
              //TODO: small circular Icons
              const SmallDots(),
              //TODO: Categories Section

              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Category',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAllCat()));
                      },
                      child: const Text(
                        'See All',
                        style:
                            TextStyle(color: Color(0xFF386B6F), fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              //TODO: Categories Avatars
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    NHomeCategories(),
                  ],
                ),
              ),
              //TODO: The second Text Categories
              // Container(
              //   margin: const EdgeInsets.all(8),
              //   child: const SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: [
              //         CatRow(catTitle: 'New'),
              //         CatRow(catTitle: 'Sales'),
              //         CatRow(catTitle: 'Men'),
              //         CatRow(catTitle: 'Women'),
              //         CatRow(catTitle: 'Kids'),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: NSizes.spaceBtwSections,
              ),
              //TODO: product Containers
              Obx(
                () {
                  if(controller.isLoading.value) return const NVerticalProductShimmer();
                  if(controller.featuredProducts.isEmpty){
                    return Center(
                      child: Text('No Data Found', style: Theme.of(context).textTheme.bodyMedium,),
                    );
                  }
                  return NGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) =>  NProductCardVertical(product: controller.featuredProducts[index],),
                    );

                  } )
            ],
          ),
        ],
      ),
    );
  }
}

class SmallDots extends StatelessWidget {
  const SmallDots({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF386B6F),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF386B6F),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF386B6F),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF386B6F),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF386B6F),
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'search',
                counterStyle: const TextStyle(fontSize: 40),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF386B6F),
            ),
            child: const Icon(
              size: 60,
              Icons.tune,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
