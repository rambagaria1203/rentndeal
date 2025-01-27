//import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/animation_loader.dart';
import 'package:rentndeal/features/common_function/loaders/vertical_product_shimmer.dart';
import 'package:rentndeal/features/product/controller/favourites_controller.dart';
import 'package:rentndeal/helpers/general_functions/cloud_helper_function.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  //final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          CircularIcon(icon: Iconsax.add, onPressed: () => Get.to(const HomeS())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                ()=> FutureBuilder(
                  future: controller.favouriteProducts(),
                  builder: (context, snapshot) {
                    // Nothing found Widget
                    final emptyWidget = AnimationLoaderWidget(
                      text: 'Whoops! Wishlist is Empty....', 
                      animation: CImages.icProduct,
                      showAction: true,
                      actionText: 'Let\'s add some',
                      onActionPressed: () => Get.off(() => const NavigationMenu()),
                      );
                    const loader = VerticalProductShimmer(itemCount: 6);
                    final widget = HCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
                    if(widget != null) return widget;
                
                    final products = snapshot.data!;
                    return GridViewLayout(itemCount: products.length, itemBuilder: (_, index) => ProductDetailsVertical(product: products[index]));
                  },
                ),
              )
            ],
          ),),
      ),
    );
  }
}