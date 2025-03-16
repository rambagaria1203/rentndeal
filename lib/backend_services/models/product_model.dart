import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  DateTime? date;
  String productId;
  String productName;
  String productDesc;
  String productCategory;
  String productSubcategory;
  String productSecurityDeposit;
  String productDeliveryFee;
  DateTime? productRentedFromDate;
  DateTime? productRentedTillDate;
  String productRent;
  String productPrice;
  String productRentPeriod;
  String productRating;
  String productSeller;
  String productSellerId;
  bool productAvailable;
  String productLocation;
  GeoPoint productGeoPoints;
  List<String>? productImages;

  ProductModel({
    this.date,
    required this.productId,
    required this.productName,
    required this.productDesc,
    required this.productCategory,
    required this.productSubcategory,
    required this.productRent,
    required this.productLocation,
    required this.productPrice,
    required this.productRentPeriod,
    required this.productRating,
    required this.productSeller,
    required this.productSellerId,
    required this.productRentedFromDate,
    required this.productRentedTillDate,
    required this.productDeliveryFee,
    required this.productSecurityDeposit,
    required this.productGeoPoints,
    this.productAvailable = true,
    this.productImages,
  });

  static ProductModel empty() => ProductModel(
        productId: '',
        productName: '',
        productDesc: '',
        productCategory: '',
        productSubcategory: '',
        productRent: '',
        productPrice: '',
        productRentPeriod: '',
        productRating: '',
        productSeller: '',
        productSellerId: '',
        productDeliveryFee: '',
        productSecurityDeposit: '',
        productLocation: '',
        productGeoPoints: const GeoPoint(0, 0),
        productRentedFromDate: null,
        productRentedTillDate: null,
      );

  Map<String, dynamic> toJson() {
    return {
      'Date': date,
      'ID': productId,
      'Name': productName,
      'Description': productDesc,
      'Category': productCategory,
      'Subcategory': productSubcategory,
      'Rent': productRent,
      'Price': productPrice,
      'Rent Period': productRentPeriod,
      'Rating': productRating,
      'Seller': productSeller,
      'Seller ID': productSellerId,
      'Images': productImages ?? [],
      'Available': productAvailable,
      'Security Deposit': productSecurityDeposit,
      'Delivery Fee': productDeliveryFee,
      'Rented From': productRentedFromDate,
      'Rented Till': productRentedTillDate,
      'Location': productLocation,
      'GeoPoints': productGeoPoints,
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
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
      productAvailable: (data['Available'] as bool?) ?? true,
      productImages: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productSecurityDeposit: data['Security Deposit'] ?? '',
      productDeliveryFee: data['Delivery Fee'] ?? '',
      productRentedFromDate: data['Rented From'] != null ? (data['Rented From'] as Timestamp).toDate() : null,
      productRentedTillDate: data['Rented Till'] != null ? (data['Rented Till'] as Timestamp).toDate() : null,
      productLocation: data['Location'] ?? '',
      productGeoPoints: data['GeoPoints'] != null ? data['GeoPoints'] as GeoPoint : const GeoPoint(0, 0),
    );
  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
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
      productAvailable: (data['Available'] as bool? )?? true,
      productImages: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productSecurityDeposit: data['Security Deposit'] ?? '',
      productDeliveryFee: data['Delivery Fee'] ?? '',
      productRentedFromDate: data['Rented From'] != null ? (data['Rented From'] as Timestamp).toDate() : null,
      productRentedTillDate: data['Rented Till'] != null ? (data['Rented Till'] as Timestamp).toDate() : null,
      productLocation: data['Location'] ?? '',
      productGeoPoints: data['GeoPoints'] != null ? data['GeoPoints'] as GeoPoint : const GeoPoint(0, 0),
    );
  }
}
