import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/favourite_icon/favourite_icon.dart';
import 'package:rentndeal/features/common_function/widgets/texts/product_price_text.dart';

class ProductDetailHorizontal extends StatelessWidget {
  const ProductDetailHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: ()=> Get.to(()=> ProductDetail(product: product,)),
      child: Container(
          width: 300,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CSizes.productImageRadius),
            color: dark ? CColors.darkerGrey : CColors.softgrey,
          ),
          child: Row(
            children: [
              //--- Thumnail
              RoundedContainer(
                height: 120,
                padding: const EdgeInsets.all(CSizes.sm),
                backgroundColor: dark ? CColors.dark : CColors.light,
                child: Stack(
                  children: [
                    // -- Thumbnail Image
                    SizedBox(height: 120, width: 120, child: RoundedProductImages(imageUrl: product.productImages![0], applyImageRadius: true, isNetworkImage: true,)),
                    // -- Favorite Icon
                    Positioned(top: 0, right: 0, child: FavouriteIcon(productId: product.productId,)),
                  ],
                ),
              ),
              //--- Product Details
      
              SizedBox(
                width: 162, /// This value is calculated based on container width.
                child: Padding(
                  padding: const EdgeInsets.only(top: CSizes.sm, left: CSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductTitleText(title: product.productName, smallSize: true,),
                          const SizedBox(height: CSizes.spaceBtwItems / 1.5),
                          ProductLocationInWidget(location: product.productLocation.isNotEmpty ? product.productLocation : "Pune, Maharashtra, India"),
                        ],
                      ),
                      const SizedBox(height: CSizes.spaceBtwItems / 2,),
      
                      const Spacer(),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                ProductPriceText(price: product.productRent),
                                 // New Added line --- From here
                                const SizedBox(width: 1),
                                const Text('/'),
                                const SizedBox(width: 1),
                                Flexible(child: Text(product.productRentPeriod, style: Theme.of(context).textTheme.titleLarge,overflow: TextOverflow.ellipsis,maxLines: 1)),
                                // Till here
                              ],
                            ),
                          ),
      
                          // -- Chat with Seller
                          Container(
                            decoration: const BoxDecoration(
                              color: CColors.dark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(CSizes.cardRadiusMd),
                                bottomRight: Radius.circular(CSizes.productImageRadius),
                              ),
                            ),
                            child: const SizedBox(width: CSizes.iconLg * 1.1, height: CSizes.iconLg * 1.1 ,child: Center(child: Icon(Iconsax.message_2, color: CColors.white,))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}