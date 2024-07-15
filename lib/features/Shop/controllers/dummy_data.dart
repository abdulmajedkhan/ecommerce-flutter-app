import 'package:nomishop/features/Shop/models/brand_model.dart';
import 'package:nomishop/features/Shop/models/product_attribute_model.dart';
import 'package:nomishop/features/Shop/models/product_variation_model.dart';

import '../models/category_model.dart';
import '../models/poduct_model.dart';


class NDummyData {
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1',
        name: 'Sports',
        image: 'assets/images/logos/slippers.png',
        isFeatured: true),
    CategoryModel(
        id: '5',
        name: 'Shirt',
        image: 'assets/images/logos/tshirt.png',
        isFeatured: true),
    CategoryModel(
        id: '3',
        name: 'Cloth',
        image: 'assets/images/logos/tshirt.png',
        isFeatured: true),
    CategoryModel(
        id: '4',
        name: 'Shoes',
        image: 'assets/images/logos/slippers.png',
        isFeatured: true),
    CategoryModel(
        id: '2',
        name: 'Watch',
        image: 'assets/images/logos/gadgets.png',
        isFeatured: true),
    CategoryModel(
        id: '1',
        name: 'Mobile',
        image: 'assets/images/logos/gadgets.png',
        isFeatured: true),

    // Sub Categories
    CategoryModel(
        id: '8',
        name: 'Sports Shoes',
        image: 'assets/images/products/category-1.jpg',
        isFeatured: false,
        parentId: '1'),
    CategoryModel(
        id: '9',
        name: 'Track Suit',
        image: 'assets/images/products/category-1.jpg',
        isFeatured: false,
        parentId: '3'),
  ];

  static final List<ProductModel> products = [
    ProductModel(
      id: '001',
      title: 'Green Nike Shoes',
      stock: 15,
      price: 132.0,
      isFeatured: true,
      thumbnail: 'assets/images/products/product-5.jpg',
      description: 'Green Nike Shoes',
      brand: BrandModel(
          id: '1',
          image: 'assets/images/logos/nikeLogo1.png',
          name: 'Nike',
          productCounts: 265,
          isFeatured: true),
      sku: 'ABR456',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'White']),
        ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productType: 'Shoes',
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 34,
          price: 134.0,
          salePrice: 122.6,
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 124.0,
          salePrice: 122.6,
          attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
        ),
      ],
    ),
    ProductModel(
      id: '002',
      title: 'Adidas Shoes',
      stock: 20,
      price: 120.0,
      isFeatured: true,
      thumbnail: 'assets/images/products/product-6.jpg',
      description: 'Green Adidas Shoes',
      brand: BrandModel(
          id: '2',
          image: 'assets/images/logos/adidasLogo.png',
          name: 'Adidas',
          productCounts: 198,
          isFeatured: true),
      sku: 'ABR457',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Blue', 'Red']),
        ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      productType: 'Shoes',
    ),
    ProductModel(
      id: '003',
      title: 'Blue T-Shirt',
      stock: 10,
      price: 50.0,
      salePrice: 40.0,
      isFeatured: true,
      thumbnail: 'assets/images/products/product-7.jpg',
      description: 'Blue T-Shirt',
      brand: BrandModel(
          id: '3',
          image: 'assets/images/logos/nikeLogo1.png',
          name: 'Nike',
          productCounts: 265,
          isFeatured: true),
      sku: 'ABR458',
      categoryId: '5',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Blue', 'Green', 'Red']),
        ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L']),
      ],
      productType: 'Shirt',
    ),
  ];
}

