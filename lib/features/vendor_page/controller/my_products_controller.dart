import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/backend_services/repositories/category_repository.dart';
import 'package:rentndeal/backend_services/repositories/product_repository.dart';
import 'package:rentndeal/constants/consts.dart';

class MyProductsController extends GetxController {
  static MyProductsController get instance => Get.find();

  final isLoading = false.obs;
  var products = <ProductModel>[].obs;
  final Map<String, String> categoryMap = {};
  final _categoryRepository = Get.find<CategoryRepository>();



  Future <void> fetchMyProducts(String userId) async{
    try {
      isLoading.value = true;
      List<ProductModel> productList = await ProductRepository.instance.getProductsByUserId(userId);
      await replaceCategorySubcategoryIdsWithNames(productList);
      products.assignAll(productList);
    } catch (e) {
      print("❌ Error fetching products: $e");
    }
    finally {
      isLoading.value = false;
    }
  }


  // 
  Future<void> replaceCategorySubcategoryIdsWithNames(List<ProductModel> productList) async {
    try {
      final allCategories = await _categoryRepository.getAllCategories();
      for (var category in allCategories) {
        categoryMap[category.id] = category.name;
      }
      for (var product in productList) {
        product.productCategory = categoryMap[product.productCategory] ?? "Loading...";
        product.productSubcategory = categoryMap[product.productSubcategory] ?? "Loading...";
      }
    } catch (e) {
      print("Error processing categories: $e");
    }
  }

  // Function to delete Product
  Future<void> deleteProduct(ProductModel product) async {
    try {
      isLoading.value = true;

      // ✅ Call the repository function to delete product from Firestore & Storage
      await  ProductRepository.instance.deleteProduct(product.productId, product.productImages ?? []);

      // ✅ Remove the product from the UI List
      products.removeWhere((p) => p.productId == product.productId);

      Get.snackbar("Success", "Product deleted successfully!", backgroundColor: Colors.green, colorText: Colors.white);
      Get.back(); // Close Product Details Screen
    } catch (e) {
      Get.snackbar("Error", "Failed to delete product: $e", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }



}