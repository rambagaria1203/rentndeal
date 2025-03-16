import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

//-------------------------------------------------FIREBASE NINSTANCE FOR DB INTERACTION----------------------------------------------------------//
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;


//-------------------------------------------------GET LIMITED FEATURED PRODUCTS--------------------------------------------------------------//
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('products').where('Available', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((product) => ProductModel.fromSnapshot(product)).toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


//-------------------------------------------------GET ALL FEATURED PRODUCTS------------------------------------------------------------------//
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('products').where('Available', isEqualTo: true).get();
      return snapshot.docs.map((product) => ProductModel.fromSnapshot(product)).toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


//-------------------------------------------------GET PRODUCTS BY QUERY-----------------------------------------------------------------------//
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      return productList;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


//-------------------------------------------------GET LIMITED FEATURED PRODUCTS----------------------------------------------------------//

  // Get products by query
  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
    try {
      final snapshot = await _db.collection('products').where(FieldPath.documentId, whereIn: productIds).get();
      return snapshot.docs.map((QuerySnapshot) => ProductModel.fromSnapshot(QuerySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }



//-------------------------------------------------GET PRODUCTS BY CATEGORY-------------------------------------------------------------------//
  Future<List<ProductModel>> getProductsForCategory({required String categoryName, int limit = -1}) async {
    try {
      final productsQuery = limit == -1
          ? await _db.collection('products').where('Category', isEqualTo: categoryName).get()
          : await _db.collection('products').where('Category', isEqualTo: categoryName).limit(limit).get();
      List<ProductModel> products = productsQuery.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      return products;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something wnt wrong. Please try again';
    }
  }


//-------------------------------------------------GET PRODUCTS BY SUBCATEGORY----------------------------------------------------------------//
  Future<List<ProductModel>> getProductsForSubCategory({required String subcategoryName, int limit = -1}) async {
    try {
      final productsQuery = limit == -1
          ? await _db.collection('products').where('Subcategory', isEqualTo: subcategoryName).get()
          : await _db.collection('products').where('Subcategory', isEqualTo: subcategoryName).limit(limit).get();
      List<ProductModel> products = productsQuery.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      return products;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something wnt wrong. Please try again';
    }
  }


//-------------------------------------------------UPLOAD PRODUCTS DETAILS TO FIRESTORE---------------------------------------------------------------//
  Future<void> uploadProduct(ProductModel product, List<XFile> selectedImages) async {
    try {
      List<String> imageUrls=[];
      if (selectedImages.isNotEmpty) {
        imageUrls = await _uploadImagesToStorage(selectedImages, product.productId);
        product.productImages = imageUrls;
      }
      await _db.collection('products').doc(product.productId).set(product.toJson(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to upload product: $e');
    }
  }


//-------------------------------------------------UPLOAD PRODUCT IMAGES TO STORAGE----------------------------------------------------------//
  Future<List<String>> _uploadImagesToStorage(List<XFile> images, String productId) async {
    try {
      List<Future<String>> uploadTasks = images.map((XFile image) async {
        File compressedFile = await _compressImage(File(image.path));
        String fileName = '${DateTime.now().millisecondsSinceEpoch}_${image.name}';
        Reference storageRef = _storage.ref().child('Products/$productId/$fileName');
        UploadTask uploadTask = storageRef.putFile(compressedFile);
        TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      }).toList();
      return await Future.wait(uploadTasks);
    } catch (e) {
      throw Exception('Error uploading images');
    }
  }


//-------------------------------------------------COMPRESS IMAGE FILE-------------------------------------------------------------------------//
  Future<File> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.path}/${basename(file.path)}_compressed.jpg';
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 70,
    );
    return File(result!.path);
  }


//-------------------------------------------------FETCH ALL PRODUCTS BASED ON USER ID----------------------------------------------------------//
  Stream<QuerySnapshot> getProductsByUserId (String userId) {
    try {
      return  _db.collection('products').where('Seller ID', isEqualTo: userId).snapshots();
      //return snapshot.docs.map((product) => ProductModel.fromSnapshot(product)).toList();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


//------------------------------------------------------------THE END---------------------------------------------------------------------------//
}