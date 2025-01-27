import 'package:cached_network_image/cached_network_image.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/favourite_icon/favourite_icon.dart';
import 'package:rentndeal/features/product/controller/images_controller.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = HHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return CurveWidget(
      child: Container(
        color: isDark ? CColors.darkerGrey : CColors.light,
        child: Stack(
          children: [
            SizedBox(height: 400, child: Padding(
              padding: const EdgeInsets.all(CSizes.productImageRadius * 2),
              child: Center(child: Obx(() {
                final image = controller.selectedProductImage.value;
                return GestureDetector(
                  onTap: () => controller.showEnlargedImage(image),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    progressIndicatorBuilder: (_, __, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress, color: CColors.primary,),
                    ),
                );
              }
              )),
            )),
    
            /// Image Slider
            Positioned(
              right: 0, bottom: 30, left: CSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(itemCount: images.length, shrinkWrap: true, scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(width: CSizes.spaceBtwItems), 
                itemBuilder: (_, index) => Obx(
                  () {
                    final imageSelected = controller.selectedProductImage.value == images[index];
                    return RoundedProductImages(
                    width: 80,
                    isNetworkImage: true,
                    backgroundColor: isDark ? CColors.dark : CColors.white,
                    onPressed: () => controller.selectedProductImage.value = images[index],
                    border: Border.all(color: imageSelected ? CColors.primary : Colors.transparent),
                    padding: const EdgeInsets.all(CSizes.sm),
                    imageUrl: images[index]
                  );
                  }
                )
                ),
              ),
            ),
            /// --- App Bar Icons
            CustomAppBar(showBackArrow: true, actions: [FavouriteIcon(productId: product.productId,)], )
          ],
        ),
      ),
    );
  }
}