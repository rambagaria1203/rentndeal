import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  DateTime? date;
  String productId;
  String productName;
  String productDesc;
  String productCategory;
  String productSubcategory;
  String productRent;
  String productPrice;
  String productRentPeriod;
  String productRating;
  String productSeller;
  String productSellerId;
  bool productAvaliable;
  List<String>? productImages;

  ProductModel({
    this.date,
    required this.productId,
    required this.productName,
    required this.productDesc,
    required this.productCategory,
    required this.productSubcategory,
    required this.productRent,
    required this.productPrice,
    required this.productRentPeriod,
    required this.productRating,
    required this.productSeller,
    required this.productSellerId,
    this.productAvaliable = true,
    this.productImages,
  });

  // Create Empty func for clean code
  static ProductModel empty() => ProductModel(productId: '', productName: '', productDesc: '', productCategory: '', productSubcategory: '', productRent: '', productPrice: '', productRentPeriod: '', productRating: '', productSeller: '', productSellerId: '',);

  // Json Format
  toJson() {
    return {
    'Date':date,
    'ID':productId,
    'Name':productName,
    'Description':productDesc,
    'Category':productCategory,
    'Subcategory':productSubcategory,
    'Rent': productRent,
    'Price': productPrice,
    'Rent Period': productRentPeriod,
    'Rating': productRating,
    'Seller': productSeller,
    'Seller ID': productSellerId,
    'Images': productImages ?? [],
    'Available': productAvaliable
    };
  }

  // Map Json oriented document snapshot from firebase to Model
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
      //date: data['Date'],
      date: data['Date'] != null ? (data['Date'] as Timestamp).toDate() : null,
      productId: data['ID'] ?? '',
      productName: data['Name'] ?? '',
      productDesc: data['Description'] ?? '',
      productCategory: data['Category'] ?? '',
      productSubcategory: data['Subcategory'] ?? '',
      productRent: data['Rent'] ?? '',
      productPrice: data['Price'] ?? '',
      productRentPeriod: data['Rent Period'] ?? '',
      productRating: data['Rating'] ?? '',
      productSeller: data['Seller'] ?? '',
      productSellerId: data['Seller ID'] ?? '',
      productAvaliable: data['Available'] ?? '',
      productImages: data['Images']!= null ? List<String>.from(data['Images']) : []
    );
  }

  // Map
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      //date: data['Date'],
      date: data['Date'] != null ? (data['Date'] as Timestamp).toDate() : null,
      productId: data['ID'] ?? '',
      productName: data['Name'] ?? '',
      productDesc: data['Description'] ?? '',
      productCategory: data['Category'] ?? '',
      productSubcategory: data['Subcategory'] ?? '',
      productRent: data['Rent'] ?? '',
      productPrice: data['Price'] ?? '',
      productRentPeriod: data['Rent Period'] ?? '',
      productRating: data['Rating'] ?? '',
      productSeller: data['Seller'] ?? '',
      productSellerId: data['Seller ID'] ?? '',
      productImages: data['Images']!= null ? List<String>.from(data['Images']) : []
    );
  }

  








}