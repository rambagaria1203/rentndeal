import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentndeal/constants/consts.dart';

class FirestoreServices {
  static Stream<DocumentSnapshot> getUser(String uid) {
    return firestore.collection(usersCollection).doc(uid).snapshots();
  }

// Get products according to category

static getProducts(Category){
  return firestore.collection(productsCollection).where('product_category', isEqualTo: Category).snapshots();
}

//
static getSubCategoryProducts(title) {
  return firestore.collection(productsCollection).where('product_subcategory', isEqualTo: title).snapshots();

}

//Get all chat messgaes
static getChatMessages(docId){
  return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on', descending: false).snapshots();
}

//Get all wishlist products
static getWishlists(){
  return firestore.collection(productsCollection).where('product_wishlist', arrayContains: currentUser!.uid).snapshots();
}

// Get all messages
static getAllMessages(){
  return firestore.collection(chatsCollection).where('fromId', isEqualTo:currentUser!.uid).snapshots();
}

//Get product you own *********************************
static getYourProducts(){
  return firestore.collection(productsCollection).where('vendor_id', isEqualTo: currentUser!.uid).snapshots();
}

// Getting count of wishlist products for Profile Screen
static getCounts() async{
var res = await Future.wait([
  firestore.collection(productsCollection).where('product_wishlist', arrayContains: currentUser!.uid).get().then((value) {
    return value.docs.length;
  }),
  firestore.collection(productsCollection).where('vendor_id', isEqualTo: currentUser!.uid).get().then((value) {
    return value.docs.length;
  })
]);
  return res;

}

// Get all Products for Home Screen
static allProducts(){
  return firestore.collection(productsCollection).snapshots();
}

// Get SellersBest Product for Home Screen
static sellerBestProduct(){
  return firestore.collection(productsCollection).where('star_product', isEqualTo: true).get();
}

// Search Bar for Home Screen
static searchProducts(title){
  return firestore.collection(productsCollection).get();
}

// Vendor screen get products
static vendorGetProducts(uid) {
  return firestore.collection(productsCollection).where('vendor_id', isEqualTo: uid).snapshots();
}

// Get all vendors
static allVendors(){
  return firestore.collection(productsCollection).snapshots();
}

static getLocation(){
  return firestore.collection(usersCollection).get();
}

}