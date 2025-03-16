import 'package:rentndeal/backend_services/models/category_model.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/backend_services/repositories/category_repository.dart';
import 'package:rentndeal/backend_services/repositories/product_repository.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();


//----------------------------------------------VARIABLES (HOME & CATEGORY SCREEN)& INSTANCE CALLING----------------------------------------------------------//
  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;


//-------------------------------------------------VARIABLES (UPLOAD PRODUCT SCREEN)----------------------------------------------------------//
  RxString selectedCategory = "".obs;
  RxString selectedSubcategory = "".obs;
  RxList<CategoryModel> subcategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }


//----------------------------------------------------------FETCH CATEGORIES---------------------------------------------------------------------//
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(4).toList());
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


//----------------------------------------------FETCH SUBCATEGORIES BASED ON CATEGORY ID----------------------------------------------------------//
  Future<void> fetchSubcategories(String categoryId) async{
    try {
      selectedCategory.value = categoryId;
      final subCategoriesList = await _categoryRepository.getSubCategories(categoryId);
      subcategories.assignAll(subCategoriesList);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
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


//----------------------------------------------------GET CATEGORY PRODUCTS--------------------------------------------------------------------//
  Future<List<ProductModel>> getCategoryProducts({required String categoryName, int limit = 4}) async {
    try{
    final products = await ProductRepository.instance.getProductsForCategory(categoryName: categoryName, limit: limit);
    return products;
  } catch (e) {
    Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    return [];
    }
  }


//----------------------------------------------------GET SUB CATEGORY PRODUCTS---------------------------------------------------------------//
  Future<List<ProductModel>> getSubCategoryProducts({required String categoryName, int limit = 4}) async {
    try{
    final products = await ProductRepository.instance.getProductsForSubCategory(subcategoryName: categoryName, limit: limit);
    return products;
  } catch (e) {
    Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    return [];
    }
  }
}
