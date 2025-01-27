import 'package:rentndeal/constants/consts.dart';
//import 'package:rentndeal/features_ui/product/screens/all_products.dart';
import 'package:rentndeal/features/common_function/loaders/vertical_product_shimmer.dart';
import 'package:rentndeal/features/home/common_widget/home_app_bar.dart';
import 'package:rentndeal/features/home/common_widget/home_categories.dart';
import 'package:rentndeal/features/product/controller/product_controller.dart';
import 'package:rentndeal/features/product/screens/all_products.dart';

class HomeS extends StatelessWidget {
  const HomeS({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BackgroundScreen(
              child: Column(
                children: [
                  HomeAppBar(),
                  SizedBox(height: CSizes.spaceBtwItems),

                  // Search Bar 
                  SearchBarContainer(hintText: "Search in Store",),
                  SizedBox(height: CSizes.spaceBtwSections),

                  // Categories Heading
                  Padding(
                    padding: EdgeInsets.only(left: CSizes.defaultSpace), 
                    child: Column(
                      children: [
                        SectionHeading(title: "Popular Categories", showActionButton: false, textColor: Colors.white,),
                        SizedBox(height: CSizes.spaceBtwItems),

                        // Categories Containers & Name
                        HomeCategories()
                      ]
                  ),
                  ),
                  SizedBox(height: CSizes.spaceBtwSections),
                ],
              )
            ),

          //New Product Section
            Padding(
              padding: const EdgeInsets.only(left: CSizes.defaultSpace, right: CSizes.defaultSpace, bottom: CSizes.defaultSpace),
              child: Column(
              children:[
                SectionHeading(title: 'New Products', onPressed: () {}
                ),
                
                const SizedBox(height: CSizes.spaceBtwItems / 2),
                //const ImageSliderWidget(images: [CImages.imgSlider1, CImages.imgSlider2, CImages.imgSlider3, CImages.imgSlider4]),
                
                Obx(() {
                  if (controller.isLoading.value) return const VerticalProductShimmer();
                  if(controller.featuredProducts.isEmpty) {
                    return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                  }
                  return SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: controller.featuredProducts.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(width: CSizes.spaceBtwItems),
                      itemBuilder: (context, index) => ProductDetailHorizontal(product: controller.featuredProducts[index]),
                    ),
                  );
                }
                ),
                const SizedBox(height: CSizes.spaceBtwItems),

                // Heading of All Popular Category
                SectionHeading(title: 'All Products', onPressed: () => Get.to(() => AllProductScreen(
                  title: 'All Products',
                  futureMethod: controller.fetchAllFeaturedProducts(),
                ))),
                const SizedBox(height: CSizes.spaceBtwItems / 2),

                // All Popular Products.......
                Obx(() {
                  if (controller.isLoading.value) return const VerticalProductShimmer();
                  if(controller.featuredProducts.isEmpty) {
                    return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                  }
                  return GridViewLayout(itemCount: controller.featuredProducts.length, itemBuilder: (_, index) => ProductDetailsVertical(product: controller.featuredProducts[index]));
                } )
                
              ],
              ),
            )

          ]
        ),

      ),
    );
  }
}





















