import 'package:rentndeal/backend_services/models/category_model.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/backend_services/repositories/category_repository.dart';
import 'package:rentndeal/backend_services/repositories/product_repository.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // Load Category data
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, ect.)
      final categories = await _categoryRepository.getAllCategories();

      // Update the categories List
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(4).toList());

    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }

  // Load selected Sub-category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try{
    final subCategories = await _categoryRepository.getSubCategories(categoryId);
    return subCategories;
  } catch (e) {
    Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    return [];
    }
  }

  // Get category or sub-category Products.
  Future<List<ProductModel>> getCategoryProducts({required String categoryName, int limit = 4}) async {
    try{
    final products = await ProductRepository.instance.getProductsForCategory(categoryName: categoryName, limit: limit);
    return products;
  } catch (e) {
    Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    return [];
    }
  }

  Future<List<ProductModel>> getSubCategoryProducts({required String categoryName, int limit = 4}) async {
    try{
    final products = await ProductRepository.instance.getProductsForSubCategory(categoryName: categoryName, limit: limit);
    return products;
  } catch (e) {
    Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    return [];
    }
  }
}