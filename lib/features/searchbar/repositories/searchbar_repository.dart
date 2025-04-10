import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/features/searchbar/interfaces/i_searchbar_repository.dart';

class SearchBarRepository implements ISearchBarRepository{


//-------------------------------------------------FIREBASE NINSTANCE FOR DB INTERACTION----------------------------------------------------------//
  final _db = FirebaseFirestore.instance;

//-------------------------------------------------PRODUCT SEARCH BAR----------------------------------------------------------//
  @override
  Future<List<ProductModel>> searchProducts(String query) async {
  try {
    final snapshot = await _db.collection('products').get();
    final filtered = snapshot.docs.where((doc) {
      final name = doc['Name'].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();
    return filtered.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  } catch (e) {
    throw 'Failed to search products: $e';
  }
}
//------------------------------------------------------------THE END---------------------------------------------------------------------------//

}
