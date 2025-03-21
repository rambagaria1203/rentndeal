import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/vendor_page/controller/my_products_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});
  
  

  @override
  Widget build(BuildContext context) {
    var _pageController = PageController();
    
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: CColors.primary, // ✅ Better contrast
        title: Text(
          product.productName,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          // 🔹 3-Dot Menu with Edit, Toggle Availability, and Delete
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: PopupMenuButton<int>(
              onSelected: (value) {
                if (value == 1) {
                  // Toggle availability
                } else if (value == 2) {
                  // Edit product
                } else if (value == 3) {
                  showDeleteConfirmationDialog(context, product.productId);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(product.productAvailable ? Icons.visibility_off : Icons.visibility, color: Colors.black),
                      const SizedBox(width: 8),
                      Text(product.productAvailable ? "Mark as Unavailable" : "Mark as Available"),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.black),
                      SizedBox(width: 8),
                      Text("Edit Product"),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.black),
                      SizedBox(width: 8),
                      Text("Delete Product"),
                    ],
                  ),
                ),
              ],
              child: const Icon(Icons.more_vert, color: Colors.white), // ✅ White for better visibility
            ),
          ),
        ],
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16), // ✅ Better spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Product Image Carousel
              // ✅ Image Slider with Rounded Corners
SizedBox(
  height: 350,
  child: PageView.builder(
    controller: _pageController,
    itemCount: product.productImages?.length ?? 0,
    itemBuilder: (context, index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16), // ✅ Rounded Corners
        child: Stack(
          alignment: Alignment.center,
          children:  [
            const Center(child: CircularProgressIndicator(),),
            Image.network(
              product.productImages![index],
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child; // ✅ Image fully loaded, show it
                return const Center(child: CircularProgressIndicator()); // ✅ Show loader while loading
              },
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ],
        ),
      );
    },
  ),
),
const SizedBox(height: 10),

// ✅ Smooth Page Indicator for Image Slider
Center(
  child: SmoothPageIndicator(
    controller: _pageController,
    count: product.productImages?.length ?? 0,
    effect: const ExpandingDotsEffect(
      activeDotColor: royalblueColor,
      dotHeight: 8,
      dotWidth: 8,
      spacing: 6,
    ),
  ),
),
10.heightBox,

              const SizedBox(height: 16),

              // 🔹 Product Name
              Text(
                product.productName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: darkFontGrey),
              ),
              const SizedBox(height: 6),

              // 🔹 Category & Subcategory
              Row(
                children: [
                  const Icon(Icons.category, color: darkFontGrey, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    "${product.productCategory}   ${product.productSubcategory}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: darkFontGrey),
                  ),
                ],
              ),

              const Divider(thickness: 1, height: 24),

              // 🔹 Price, Rent & Fees Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoBox("Rent", "₹${product.productRent} / ${product.productRentPeriod.replaceAll('Per ', '')}", CColors.blueColor),
                  const SizedBox(width: 8),
                  _infoBox("Price", "₹${product.productPrice}", Colors.green),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoBox("Security Deposit", product.productSecurityDeposit.isNotEmpty ? "₹${product.productSecurityDeposit}" : "No Deposit", Colors.orange),
                  const SizedBox(width: 8),
                  _infoBox("Delivery Fee", product.productDeliveryFee.isNotEmpty ? "₹${product.productDeliveryFee}" : "Free", Colors.purple),
                ],
              ),

              const Divider(thickness: 1, height: 24),

              // 🔹 Product Location
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.red, size: 22),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      product.productLocation,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: darkFontGrey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Divider(thickness: 1, height: 24),

              // 🔹 Description Section
              Text(
                "Description",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: darkFontGrey),
              ),
              const SizedBox(height: 6),
              Text(product.productDesc, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: darkFontGrey)),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Reusable Info Box for Rent, Price, Deposit, etc.
  Widget _infoBox(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  /// ✅ Shows Confirmation Dialog for Deleting a Product
  void showDeleteConfirmationDialog(BuildContext context, String productId) {
    final _controller = Get.put(MyProductsController());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Product"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("90% of vendors keep their products active for more sales."),
            SizedBox(height: 10),
            Text("Do you want to delete this product?"),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              _controller.deleteProduct(product);
              Get.back(); // Close dialog
              Get.back();
              Get.snackbar(
              "Success",
              "Product deleted successfully!",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
