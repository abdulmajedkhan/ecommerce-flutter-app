import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String price;
  final String description;
  final double rating;
  final ImageProvider img;
  final String title;

  const ProductDetailScreen({
    super.key,
    required this.price,
    required this.description,
    required this.rating,
    required this.img,
    required this.title,
  });

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
            child: const CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.favorite,
                )),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade100,
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 18),
              child: Column(
                children: [
                  const Text('Total Price'),
                  Text(
                    price,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => CartScreen(
            //                   title: title,
            //                   img: img,
            //                   price: price,
            //                 )));
            //   },
            //   child: Container(
            //     width: 250,
            //     height: 70,
            //     decoration: BoxDecoration(
            //         color: const Color(0xFF386B6F),
            //         borderRadius: BorderRadius.circular(30)),
            //     child: const Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.shopping_cart,
            //           color: Colors.white,
            //         ),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Text(
            //           'Add to Cart',
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 25,
            //               fontWeight: FontWeight.w400),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 400, child: Center(child: Image(image: img))),
            Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'category Type',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade500),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$rating',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Product Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DressSize(dressSize: 'S'),
                      DressSize(dressSize: 'M'),
                      DressSize(dressSize: 'L'),
                      DressSize(dressSize: 'XL'),
                      DressSize(dressSize: 'XXL'),
                      DressSize(dressSize: 'XXXL'),
                    ],
                  )
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
  const DressSize({super.key, required this.dressSize});
  final String dressSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          constraints: const BoxConstraints(minWidth: 40),
          child: Center(
            child: Text(
              dressSize,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
