import 'package:readmore/readmore.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/product/screens/product_reviews.dart';
import 'package:rentndeal/features/product/widget/chat_with_seller.dart';
import 'package:rentndeal/features/product/widget/product_location.dart';

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
                  RatingAndShare(product: product),
                  ProductMetaData(product: product),
                  const SizedBox(height: CSizes.spaceBtwItems / 2,),
                  // Row(
                  //   children: [
                  //     const Icon(Iconsax.check, size: 20, color: Colors.green),
                  //     const SizedBox(width: 6),
                  //     Text(product.productAvailable ? "Available" : "Not Available", style: TextStyle( color: product.productAvailable ? Colors.green : Colors.red, fontWeight: FontWeight.w600,),),
                  //   ],
                  // ),
                  const SizedBox(height: CSizes.spaceBtwItems,),
                  /// ---- Description
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
                  const Divider(),
                  const SizedBox(height: CSizes.spaceBtwItems,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.user, size: 24, color: Colors.blue),
                          const SizedBox(width: 10),
                          Text("Seller: ${product.productSeller}", style: Theme.of(context).textTheme.titleMedium,),
                        ],
                      ),
                    ],
                  ),
                  // const Divider(),
                  const SizedBox(height: CSizes.spaceBtwItems,),
                  // const SectionHeading(title: "Product Location", showActionButton: false),
                  // const SizedBox(height: CSizes.spaceBtwItems / 2),
                  // Row(
                  //   children: [
                  //     const Icon(Iconsax.location, size: 20, color: Colors.red),
                  //     const SizedBox(width: 8),
                  //     Flexible(
                  //       child: Text("Hinjewadi Pune Maharastra", maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium,),),
                  //   ],
                  // ),
                  const Divider(),
                  const ProductLocationProductDetails(latitude: 18.5780386, longitude: 73.6899744 , locationName: "Hinjewadi Pune Maharastra",),
                  const Divider(),
                  // -- Reviews
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
      /// Static Button at Bottom
      bottomNavigationBar: product.productSellerId == UserController.instance.user.value.id
          ? Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: Container(height: 55, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.center,
              child: Text("You are the owner of this product", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),),
              ), 
            )
          :  SellerChatButton(product: product, userId: UserController.instance.user.value.id),
    );
  }
}