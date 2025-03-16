import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:rentndeal/backend_services/models/category_model.dart';
import 'package:rentndeal/backend_services/services/firebase_storage_service.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/helpers/exceptions/firebase_exceptions.dart';
import 'package:rentndeal/helpers/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // Varibale 
  final _db = FirebaseFirestore.instance;
  
  // Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try{
      final snapshot = await _db.collection('categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Get sub Categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      print("🔍 Querying Firestore: Looking for subcategories where ParentId = $categoryId");
      
      final snapshot = await _db.collection('categories').where('ParentId', isEqualTo: categoryId).get();
      if (snapshot.docs.isEmpty) {
      print("⚠️ No subcategories found for ParentId: $categoryId");
    } else {
      print("✅ Subcategories found: ${snapshot.docs.map((e) => e['Name']).toList()}");
    }
      final result = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;

    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Upload Categories to the cloud firebase

  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // upload all the categories along with their Images
      final storage = Get.put(FirebaseStorageService());

      // Loop through each category
      for (var category in categories) {

        // Upload the image to the cloud
        final file = await storage.getImageDataFromAssets(category.image);

        final url = await storage.uploadImageData('categories', file, category.name);
        category.image = url;

        // store category in firebase
        await _db.collection('categories').doc(category.id).set(category.tojson());
      }
    } on FirebaseException catch (e) {
      throw CustomFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CustomPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}