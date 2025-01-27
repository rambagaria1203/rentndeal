import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/product/controller/favourites_controller.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => CircularIcon(
        icon: controller.isFavourite(productId) ? Iconsax.heart : Iconsax.heart,
        color: controller.isFavourite(productId) ? CColors.error : null,
        onPressed: () => controller.toggleFavouriteProduct(productId),
      )
    );
  }
}