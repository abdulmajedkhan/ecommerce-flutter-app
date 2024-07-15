
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nomishop/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:nomishop/data/repositries/categories/category_repositories.dart';

import '../../../../../data/repositries/Product/product_repository.dart';
import '../../../../Shop/controllers/dummy_data.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void uploadCategories() async {
      try {
        final categoryRepository = Get.put(CategoryRepository());
        await categoryRepository.uploadDummyData(NDummyData.categories);
        Get.snackbar('Success', 'Categories uploaded successfully');
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
    void uploadProducts() async {
      try {
        final productRepository = Get.put(ProductRepository());
        await productRepository.uploadDummyData(NDummyData.products);
        Get.snackbar('Success', 'Products uploaded successfully');
      } catch (e) {

        Get.snackbar('Error', e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            NSettingsMenuTile(
              title: 'Upload Categories',
              icon: Iconsax.document_upload,
              subTitle: '',
              trailing: const Icon(Icons.arrow_upward_sharp),
              onTap: uploadCategories,

            ),
            const NSettingsMenuTile(
              title: 'Upload Brands',
              icon: Iconsax.document_upload,
              subTitle: '',
              trailing: Icon(Icons.arrow_upward_sharp),

            ),
            NSettingsMenuTile(
              title: 'Upload Products',
              icon: Iconsax.document_upload,
              subTitle: '',
              trailing: const Icon(Icons.arrow_upward_sharp),
              onTap: uploadProducts,

            ),
            const NSettingsMenuTile(
              title: 'Upload Banners',
              icon: Iconsax.document_upload,
              subTitle: '',
              trailing: Icon(Icons.arrow_upward_sharp),

            )
          ],
        ),
      ),
    );
  }
}
