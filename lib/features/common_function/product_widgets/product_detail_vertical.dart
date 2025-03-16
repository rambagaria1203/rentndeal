import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/favourite_icon/favourite_icon.dart';
import 'package:rentndeal/features/common_function/widgets/texts/product_price_text.dart';

class ProductDetailsVertical extends StatelessWidget {
  const ProductDetailsVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: ()=> Get.to(()=> ProductDetail(product: product,)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(CSizes.productImageRadius),
          color: dark ? CColors.darkerGrey : CColors.white,
        ),
        child: Column(
          children: [
      
            // Thumbnail, wishlist Button, Discount Tag
            RoundedContainer(
              height: 180, width: 180,
              padding: const EdgeInsets.all(CSizes.sm),
              backgroundColor: dark ? CColors.dark : CColors.light,
              child: Stack(
                children: [
                  // Thumbnail Image
      
                  Center(child: RoundedProductImages(imageUrl: product.productImages![0], applyImageRadius: true, isNetworkImage: true,)),
      
                  // Sale Tags
                  
                  //Positioned(
                    //top: 12,
                    //child: RoundedContainer(
                     // radius: CSizes.sm,
                     // backgroundColor: CColors.secondary.withOpacity(0.8),
                     // padding: const EdgeInsets.symmetric(horizontal: CSizes.sm, vertical: CSizes.xs),
                      //child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: CColors.black)),
                    
                    //),
                  //),
                  // Favourite Icon Button
                  Positioned(top: 0, right: 0, child: FavouriteIcon(productId: product.productId,)),
                ],
              )
            ),
      
            // Products Details
            Padding(
              padding: const EdgeInsets.only(left: CSizes.sm),
              child: Column(
                children: [
                  ProductTitleText(title: product.productName, smallSize: true),
                  const SizedBox(height: CSizes.spaceBtwItems / 1.5),
                  ProductLocationInWidget(location: product.productLocation.isNotEmpty ? product.productLocation : "Pune, Maharashtra, India"),
                ],
              )
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Product Price
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: CSizes.sm),
                    child: Row(
                      children: [
                        ProductPriceText(price: product.productRent),
                        // New Added line --- From here
                        const SizedBox(width: 1),
                        const Text('/'),
                        const SizedBox(width: 1),
                        Flexible(child: Text(product.productRentPeriod, style: Theme.of(context).textTheme.titleLarge,overflow: TextOverflow.ellipsis, maxLines: 1,)),
                        // Till here
                      ],
                    )),
                ),

                  //-- Chat with Seller
                  Container(
                  decoration: const BoxDecoration(
                    color: CColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(CSizes.cardRadiusMd),
                      bottomRight: Radius.circular(CSizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(width: CSizes.iconLg * 1.1, height: CSizes.iconLg * 1.1 ,child: Center(child: Icon(Iconsax.message_2, color: CColors.white,))),
                )
              ],
            )
            
          ],
        ),
      
      ),
    );
  }
}

