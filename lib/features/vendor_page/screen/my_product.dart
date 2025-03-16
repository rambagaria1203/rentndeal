import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/backend_services/repositories/product_repository.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/category/controller/category_controller.dart';
import 'package:rentndeal/features/vendor_page/screen/product_details.dart';


class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var categoryController = Get.put(CategoryController());
    return Scaffold(
      appBar: CustomAppBar(title: Text('My Products', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)), backgroundColor: CColors.primary, showBackArrow: true,),
      // body: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Center(child: Text('No Products Available', style: Theme.of(context).textTheme.bodyLarge,))
      //   ]
      // ),

      // // Floating Button
      // floatingActionButton: FloatingActionButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return const UploadProductScreen();
      //   }));}, backgroundColor: CColors.primary, child: const Icon(Icons.add, color: whiteColor, size: 28,),),
      
      body: FutureBuilder(
        future: categoryController.fetchCategories(), // ✅ Fetch categories first
        builder: (context, categorySnapshot) {
          if (categorySnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
      return StreamBuilder(
        stream: ProductRepository.instance.getProductsByUserId(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return "No products yet!".text.color(darkFontGrey).makeCentered();
          }
          var data = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var product = data[index];
                var categoryName = categoryController.allCategories.firstWhereOrNull(
                    (cat) => cat.id == product['Category'],
                  )?.name ?? "Unknown Category";

                  // ✅ Fetch subcategory name from fetched subcategories
                  var subcategoryName = categoryController.allsubcategories.firstWhereOrNull(
                    (subcat) => subcat.id == product['Subcategory'],
                  )?.name ?? "Unknown Subcategory";

                return Card(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    onTap: () => Get.to(() => ProductDetails(data: product)),
                    leading: SizedBox(
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product['Images'][0],
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.3,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                      ),
                    ),
                    title: boldText(
                      text: product['Name'],
                      color: darkFontGrey,
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: normalText(
                            text: "$categoryName ($subcategoryName)",
                            color: darkFontGrey,
                          ),
                        ),
                        boldText(
                          text: product['Available'] == true ? "Available" : "Out of Stock",
                          color: product['Available'] == true ? green : Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
        }
      )
    );
  }
}