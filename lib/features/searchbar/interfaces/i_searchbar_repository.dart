import 'package:rentndeal/backend_services/models/product_model.dart';

abstract class ISearchBarRepository {
  Future<List<ProductModel>> searchProducts(String query);
}