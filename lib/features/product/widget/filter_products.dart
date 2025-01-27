import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/product/controller/all_products_controller.dart';
//import 'package:rentndeal/features_ui/product/controller/product_controller.dart';

class FilterProducts extends StatelessWidget {
  const FilterProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final allProductsController = AllProductsController();
    allProductsController.assignProducts(products);
    //final productController = ProductController.instance;
    return Column(
      children: [
        // --- Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: allProductsController.selectedFilterOption.value,
          onChanged: (value) {
            allProductsController.filterProducts(value!);
          },
          items: ['Name', 'Higher Price', 'Rating']
          .map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
        ),
        const SizedBox(height: CSizes.spaceBtwSections,),
        // --- Products List
        Obx(() => GridViewLayout(itemCount: allProductsController.products.length, itemBuilder: (_, index) => ProductDetailsVertical(product: allProductsController.products[index])))
      ],
    );
  }
}