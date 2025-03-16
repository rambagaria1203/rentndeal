import 'package:rentndeal/backend_services/models/category_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/category/controller/category_controller.dart';
//import 'package:rentndeal/features_ui/category/widget/subcategory_products.dart';
import 'package:rentndeal/features/common_function/loaders/horizontal_product_shimmer.dart';
import 'package:rentndeal/features/product/screens/all_products.dart';
import 'package:rentndeal/helpers/general_functions/cloud_helper_function.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Scaffold(
      appBar: CustomAppBar(title: Text(category.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),

          child: FutureBuilder(
            future: controller.getSubCategories(category.id),
            builder: (context, snapshot) {

              const loader = HorizontalProductShimmer();
              final widget = HCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
              if (widget != null) return widget;

              final subCategories = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: subCategories.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
              
                  final subCategory = subCategories[index];

                  return Column(
                    children: [
                      SectionHeading(title: subCategory.name, onPressed: ()=> Get.to(
                        ()=> AllProductScreen(
                          title: subCategory.name,
                          futureMethod: controller.getSubCategoryProducts(categoryName: subCategory.id, limit: -1)
                        ),
                      )),
                      const SizedBox(height: CSizes.spaceBtwItems / 2),
                          
              
                  FutureBuilder(
                    future: controller.getSubCategoryProducts(categoryName: subCategory.id),
                    builder: (context, snapshot) {
                      final widget = HCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;
              
                      final products = snapshot.data!;
              
                      
                          return SizedBox(
                            height: 120,
                            child: ListView.separated(
                              itemCount: products.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) => const SizedBox(width: CSizes.spaceBtwItems),
                              itemBuilder: (context, index) => ProductDetailHorizontal(product: products[index]),
                            ),
                          );
                    },
                  ),
                          const SizedBox(height: CSizes.spaceBtwSections),
                        ]
                      );
                    }
                  );
                }
              ),
              
                /// -- Sub Category
                  //SubCatrgoryProducts(),
                  //SizedBox(height: CSizes.spaceBtwSections / 1.5,),
                  //SubCatrgoryProducts(),
                  //SizedBox(height: CSizes.spaceBtwSections / 1.5,),
                  //SubCatrgoryProducts(),
                  //SizedBox(height: CSizes.spaceBtwSections / 1.5,),
                  //SubCatrgoryProducts()
                  
        )
          ),
        );
  }
}

