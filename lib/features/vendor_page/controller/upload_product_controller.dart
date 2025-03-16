import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/backend_services/repositories/product_repository.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/Authentication/controller/user_controller.dart';
import 'package:rentndeal/features/category/controller/category_controller.dart';

class UploadProductController extends GetxController {
  static UploadProductController get instance => Get.find();

  final ImagePicker _picker = ImagePicker();
  final ProductRepository productRepo = Get.put(ProductRepository());
  final UserController userController = Get.put(UserController());
  final CategoryController categoryController = Get.put(CategoryController());

  final RxList<XFile> selectedImages = <XFile>[].obs;
  final RxBool forSale = false.obs;
  final RxBool productAvailable = true.obs;
  final RxBool useCurrentLocation = true.obs;
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController securityDepositController = TextEditingController();
  final TextEditingController deliveryFeeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxString rentPeriod = "Per Month".obs;

  Future<void> pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      if (selectedImages.length + images.length > 6) {
        Get.snackbar("Error", "Maximum 6 photos can be uploaded", backgroundColor: Colors.red, colorText: Colors.white);
        selectedImages.addAll(images.take(6 - selectedImages.length));
      } else {
        selectedImages.addAll(images.take(6 - selectedImages.length));
      }
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> saveProduct() async {
    try {
      isLoading.value = true;
      ProductModel newProduct = ProductModel(
        productId: DateTime.now().millisecondsSinceEpoch.toString(),
        productName: nameController.text.trim(),
        productDesc: descController.text.trim(),
        productCategory: categoryController.selectedCategory.value,
        productSubcategory: categoryController.selectedSubcategory.value,
        productRent: rentController.text.trim(),
        productPrice: priceController.text.trim(),
        productSecurityDeposit: securityDepositController.text.trim(),
        productDeliveryFee: deliveryFeeController.text.trim(),
        productSeller: userController.user.value.fullName, 
        productSellerId: userController.user.value.id,
        productLocation: useCurrentLocation.value ? userController.user.value.location.toString() : "User Entered Location",
        productGeoPoints:  useCurrentLocation.value ? (userController.user.value.locationGeopoint ?? const GeoPoint(40.7128, -74.0060)) : const GeoPoint(40.7128, -74.0060), 
        productAvailable: productAvailable.value,
        productImages: [],
        date: DateTime.now(),
        productRentedFromDate: null,
        productRentedTillDate: null, 
        productRentPeriod: rentPeriod.value,
        productRating: '3'
      );
      await productRepo.uploadProduct(newProduct, selectedImages);
      isLoading.value = false;
      Get.back();
      Get.snackbar("Success", "Product uploaded successfully!", backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to upload product: $e", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
