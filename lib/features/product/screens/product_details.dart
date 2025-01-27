import 'package:readmore/readmore.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/product/screens/product_reviews.dart';



class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // final isDark = HHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Product Image Sliders
            ProductImageSlider(product: product,),
            
            /// --- Product Details
            Padding(
              padding: const EdgeInsets.only(right: CSizes.defaultSpace, left: CSizes.defaultSpace, bottom: CSizes.defaultSpace),
              child: Column(
                children: [
                  /// --- Rating & Share Button
                  RatingAndShare(product: product),
                  /// Price Button
                  ProductMetaData(product: product),
                  
                  const SizedBox(height: CSizes.spaceBtwItems,),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){},
                      child: Padding(
                        padding: const EdgeInsets.only(left: CSizes.defaultSpace / 1.5, right: CSizes.defaultSpace / 1.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product.productSeller, style: Theme.of(context).textTheme.headlineSmall),
                            const Icon(Iconsax.message, color: black, size: 35)
                          ],),
                      )
                      ),
                  ),
                  /// ---- Description
                  const SizedBox(height: CSizes.spaceBtwSections),
                  const SectionHeading(title: 'Description', showActionButton: false,),
                  const SizedBox(height: CSizes.spaceBtwItems),
                  ReadMoreText(
                    product.productDesc,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  // -- Reviews
                  const Divider(),
                  const SizedBox(height: CSizes.spaceBtwItems,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      SectionHeading(title: 'Reviews (200)', onPressed: (){},showActionButton: false,),
                      IconButton(onPressed: () => Get.to(() => const ProductReviews()), icon: const Icon(Iconsax.arrow_right_3, size: 18)),
                    ]
                  ),
                  const SizedBox(height: CSizes.spaceBtwSections,),
                ],
              ),
              )
          ],
        ),
      ),
    );
    
  }
}



