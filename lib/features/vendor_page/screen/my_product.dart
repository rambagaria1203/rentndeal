import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/vendor_page/controller/my_products_controller.dart';
import 'package:rentndeal/features/vendor_page/screen/product_details.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MyProductsController());
    var screenWidth = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMyProducts(currentUser!.uid);
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('My Products', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
        backgroundColor: CColors.primary,
        showBackArrow: true,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.products.isEmpty) {
          return Center(child: Text("No products yet!", style: Theme.of(context).textTheme.bodyLarge));
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            ProductModel product = controller.products[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ✅ Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                        child: product.productImages!.isNotEmpty
                            ? Image.network(
                                product.productImages![0],
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported, color: Colors.grey),
                              )
                            : const Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
                    ),

                    const SizedBox(width: 14),

                    // ✅ Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Product Name & Available Status in Same Row
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  product.productName,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // ✅ "Available" Status on Right Side
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: product.productAvailable ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  product.productAvailable ? "Available" : "Out of Stock",
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),

                          // 🔹 Category & Subcategory
                          Text(
                            "${product.productCategory} (${product.productSubcategory})",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: CColors.darkerGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).onTap(() => Get.to(() => ProductDetails(product: product,)));
          },
        );
      }),
    );
  }
}
