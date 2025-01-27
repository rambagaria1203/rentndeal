import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/backend_services/repositories/product_repository.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  final RxString selectedFilterOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }


// Fetch 5 Available Products
  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getFeaturedProducts();

      // Assign Products
      featuredProducts.assignAll(products);

    } catch (e){
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


// Fetch All Available Products
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      // Fetch Products
      final products = await productRepository.getAllFeaturedProducts();
      return products;
      // Assign Products

    } catch (e){
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    } 
  }


}