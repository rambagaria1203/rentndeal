import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/searchbar/controllers/searchbar_controller.dart';

class SearchBarScreen extends StatelessWidget {
  const SearchBarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchBarController(repository: Get.find()));
    final dark = HHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? CColors.black : CColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: Text("Search"), showBackArrow: true,),
            Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace/4),
              child: SearchBarContainer(hintText: "Search products...", showBorder: true, onChanged: (value) => controller.updateQuery(value),),
            ),
            Expanded(
              child: Obx(() {
                if (controller.query.isEmpty) {
                  return const Center(child: Text('Search for a product'));
                }
                if (controller.searchedProducts.isEmpty) {
                  return const Center(child: Text('No products found.'));
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
                  child: GridViewLayout(
                    itemCount: controller.searchedProducts.length,
                    itemBuilder: (_, index) => ProductDetailsVertical(product: controller.searchedProducts[index],),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
