import 'package:cached_network_image/cached_network_image.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  // Variables 
  RxString selectedProductImage = ''.obs;

  // Get all images from products
  List<String> getAllProductImages(ProductModel product) {
    // Using set to add unique images only
    Set<String> images = {};

    // Load thumbnail image
    images.add(product.productImages![0]);

    // Assign thumbnail as selected Images
    selectedProductImage.value = product.productImages![0];

    // Get all images from the product model if not null
    if(product.productImages != null) {
      images.addAll(product.productImages!);
    }
    return images.toList();
  }

  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: CSizes.defaultSpace * 2, horizontal: CSizes.defaultSpace),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(CSizes.productImageRadius), border: Border.all(color: Colors.black, width: 1)),
                child: ClipRRect(borderRadius: BorderRadius.circular(CSizes.productImageRadius) , child: CachedNetworkImage(imageUrl: image))),
            ),
            const SizedBox(height: CSizes.spaceBtwSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(width: 150, child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),),
            )
          ]
        ),
      )
    );
  }
}