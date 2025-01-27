import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/backend_services/repositories/product_repository.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedFilterOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

// Fetch Products by Query
  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if(query == null) return [];

      final products = await repository.fetchProductsByQuery(query);
      return products;

    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }


// Filter products
  void filterProducts (String filterOption) {
    selectedFilterOption.value = filterOption;

    switch (filterOption){
      case 'Name' : 
        products.sort((a, b) => a.productName.compareTo(b.productName));
        break;
      case 'Lower Rent':
        products.sort((a, b) => a.productRent.compareTo(b.productRent));
        break;
      case 'Rating':
        products.sort((a, b) => b.productRating.compareTo(a.productRating));
        break;
      default:
        products.sort((a, b) => a.productName.compareTo(b.productName));
    }
  }

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    filterProducts('Name');
  }

  
}