import 'dart:convert';

import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/backend_services/repositories/product_repository.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/loader.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  // variables
  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  // Method to initialize by reading from storage
  void initFavourites() {
    final json = LocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId) {
    if(!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouritesToStorage();
      Loaders.customToast(message: 'Product has been added to the Wishlist.');
      } else {
        LocalStorage.instance().removeData(productId);
        favourites.remove(productId);
        saveFavouritesToStorage();
        favourites.refresh();
        Loaders.customToast(message: 'Product has been removed from the Wishlist.');
    }
  }

  void saveFavouritesToStorage() {
    final encodedFavourites = json.encode(favourites);
    LocalStorage.instance().saveData('favourites', encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    return await ProductRepository.instance.getFavouriteProducts(favourites.keys.toList());
  }
}