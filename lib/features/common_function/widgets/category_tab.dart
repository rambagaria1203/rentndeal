//import 'package:flutter/widgets.dart';
import 'package:rentndeal/backend_services/models/category_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/category/controller/category_controller.dart';
import 'package:rentndeal/features/common_function/loaders/vertical_product_shimmer.dart';
//import 'package:rentndeal/features/product/controller/product_controller.dart';
import 'package:rentndeal/features/product/screens/all_products.dart';
import 'package:rentndeal/helpers/general_functions/cloud_helper_function.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    //final productController = ProductController.instance;
    final categoryController = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          children: [
            /// Brands
            //const CategoryShowCase(images: [CImages.icProduct, CImages.imgP2, CImages.imgFc2]),
            //const CategoryShowCase(images: [CImages.icProduct, CImages.imgP2, CImages.imgFc2]),
           // const SizedBox(height: CSizes.spaceBtwItems),
            /// -- Products
            FutureBuilder(
              future: categoryController.getCategoryProducts(categoryName: category.id),
              builder: (context, snapshot) {
                // Helper function - Handle Loader, No Record or  Error
                final response = HCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const VerticalProductShimmer());
                if (response != null) return response;

                // Record Found
                final products = snapshot.data!;
                return Column(
                  children: [
                    SectionHeading(title: 'You might like', onPressed: () => Get.to(AllProductScreen(
                      title: category.name,
                      futureMethod: categoryController.getCategoryProducts(categoryName: category.id, limit: -1), ))),
                    const SizedBox(height: CSizes.spaceBtwItems),
                    GridViewLayout(itemCount: products.length, itemBuilder: (_, index) => ProductDetailsVertical(product: products[index]))
                      
                  ],
                );
              }
            ),
            
            
            ],
        ),
      ),
    ]
    );
  }
}