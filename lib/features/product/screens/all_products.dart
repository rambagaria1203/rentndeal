import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/vertical_product_shimmer.dart';
import 'package:rentndeal/features/product/controller/all_products_controller.dart';
import 'package:rentndeal/features/product/widget/filter_products.dart';
import 'package:rentndeal/helpers/general_functions/cloud_helper_function.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final allProductsController = Get.put(AllProductsController());

    return Scaffold(
      appBar: CustomAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? allProductsController.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              // Check the state of the FutureBuilder snapshot
              const loader = VerticalProductShimmer();
              
              final widget = HCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
              if (widget != null) return widget;

              final products = snapshot.data!;
              return FilterProducts(products:products);
            }
          ),
        ),
      ),
    );
  }
}

