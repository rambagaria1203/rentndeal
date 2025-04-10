import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';
import 'package:rentndeal/features/searchbar/interfaces/i_searchbar_repository.dart';

class SearchBarController extends GetxController {
  static SearchBarController get instance => Get.find();

  final ISearchBarRepository repository;
  SearchBarController({required this.repository});
  final RxString query = ''.obs;
  final RxList<ProductModel> searchedProducts = <ProductModel>[].obs;
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 300));

//--------------------------------------------------------------UPDATED QUERY-------------------------------------------------------------------------------//
  void updateQuery(String newQuery) {
    query.value = newQuery;
    _debouncer.run(() => searchProducts(newQuery));
  }

//--------------------------------------------------------------SEARCH PRODUCTS-------------------------------------------------------------------------------//
  Future<void> searchProducts(String query) async {
    try {
      if (query.trim().isEmpty) {
        searchedProducts.clear();
        return;
      }
      final products = await repository.searchProducts(query);
      searchedProducts.assignAll(products);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Search Failed', message: e.toString());
    }
  }
}

//--------------------------------------------------------------DEBOUCER CLASS-------------------------------------------------------------------------------//
class Debouncer {
  final Duration delay;
  Timer? _timer;
  Debouncer({required this.delay});
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}

//-----------------------------------------------------------------END------------------------------------------------------------------------------//
