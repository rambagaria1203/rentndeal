import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/backend_services/services/firebase_storage_service.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/helpers/exceptions/firebase_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();


  // Firebase instance for databse interaction
  final _db = FirebaseFirestore.instance;

  // Get Limited featured products
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

//
 // Get All Last Ten Dates Products
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


// Get products by query
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


  //  Get Product Category
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

  //
  Future<List<ProductModel>> getProductsForSubCategory({required String categoryName, int limit = -1}) async {
    try {
      final productsQuery = limit == -1
          ? await _db.collection('products').where('Subcategory', isEqualTo: categoryName).get()
          : await _db.collection('products').where('Subcategory', isEqualTo: categoryName).limit(limit).get();
      
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






  // Upload dummy data to the cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // upload all the products along with their images
      final storage = Get.put(FirebaseStorageService());

      // Loop through each product
      for (var product in products) {
        // Get image data link from local assets
        if (product.productImages != null && product.productImages!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.productImages!) {
            // Get image data link from local assests
            final assetImage = await storage.getImageDataFromAssets(image);

            // Upload image and get its URL
            final url = await storage.uploadImageData('Products/Images', assetImage, image);

            // Assign URl to product 
            imagesUrl.add(url);
          }
          product.productImages!.clear();
          product.productImages!.addAll(imagesUrl);
        }

        // Store product in firebase
        await _db.collection('products').doc(product.productId).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}