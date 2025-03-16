import 'dart:io';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/category/controller/category_controller.dart';
import 'package:rentndeal/features/vendor_page/controller/upload_product_controller.dart';
import 'package:rentndeal/features/vendor_page/widgets/custom_dropdown.dart';
import 'package:rentndeal/features/vendor_page/widgets/productupload_textfield.dart';

class UploadProductScreen extends StatelessWidget {
  const UploadProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UploadProductController controller = Get.put(UploadProductController());
    final CategoryController categoryController = Get.put(CategoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: CColors.white)),
        actions: [
          TextButton(
            onPressed: controller.saveProduct, child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
        backgroundColor: CColors.primary,
      ),
      body: Obx(()=> controller.isLoading.value 
        ? const Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //categoryDropdown('Category', ['Electronics', 'Appliance', 'Vehicles', 'Furniture']),
                Obx(() => CustomDropdown(
                title: "Select Category",
                items: categoryController.featuredCategories.map((e) => e.name).toList(),
                selectedValue: categoryController.selectedCategory.value.isNotEmpty ? categoryController.featuredCategories.firstWhereOrNull((e) => e.id == categoryController.selectedCategory.value)?.name : null,
                onChanged: (newCategoryName) {
                  final selectedCategory = categoryController.featuredCategories.firstWhere((category) => category.name == newCategoryName);
                  categoryController.selectedCategory.value = selectedCategory.id;
                  categoryController.fetchSubcategories(selectedCategory.id); 
                },
              )),
                const SizedBox(height: 10),

                //categoryDropdown('Sub Category', ['Subcategory A', 'Subcategory B', 'Subcategory C', 'Subcategory D']),
                Obx(() => CustomDropdown(
                title: categoryController.selectedCategory.isEmpty ? "Select Subcategory" : "Select Subcategory",
                items: categoryController.selectedCategory.isEmpty ? ["Please select a category first"] : categoryController.subcategories.map((e) => e.name).toList(),
                selectedValue: categoryController.selectedSubcategory.value.isNotEmpty ? categoryController.subcategories.firstWhereOrNull((e) => e.id == categoryController.selectedSubcategory.value) ?.name : null,
                onChanged: (newSubcategoryName) {
                  final selectedSubcategory = categoryController.subcategories.firstWhere((subcategory) => subcategory.name == newSubcategoryName); 
                  categoryController.selectedSubcategory.value = selectedSubcategory.id;
                },
              )),
                const SizedBox(height: 10),
                vendorTextField(controller: controller.nameController, hint: "eg. BMW", title: "Product Name", isPass: false),
                const SizedBox(height: 10),
                vendorTextField(controller: controller.descController, hint: "eg. Nice product", title: "Description", isPass: false),
                const SizedBox(height: 10),
                //vendorTextField(controller: controller.rentController, hint: "eg. \$300/Month", title: "Rent", isPass: false),
                Row(children: [
                  Expanded(child: vendorTextField(controller: controller.rentController, hint: "eg. 300", title: "Rent Price", isPass: false)),
                  const SizedBox(width: 10),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Rent Period", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      CustomDropdown(
                          title: "Rent Period",
                          items: const ["Per Hour", "Per Day", "Per Week", "Per Month", "Per Year"],
                          selectedValue: controller.rentPeriod.value,
                          onChanged: (newValue) {controller.rentPeriod.value = newValue;},
                      ),
                    ],
                  ) )
                ],),
                const SizedBox(height: 10),
                vendorTextField(controller: controller.priceController, hint: "eg. \$1000.00", title: "Sell Price (Optional)", isPass: false),
                const SizedBox(height: 10),
                vendorTextField(controller: controller.securityDepositController, hint: "Enter Security Deposit", title: "Security Deposit", isPass: false),
                const SizedBox(height: 10),
                vendorTextField(controller: controller.deliveryFeeController, hint: "Enter Delivery Fee", title: "Delivery Fee", isPass: false),
                const SizedBox(height: 10),
                const Text("Location", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Obx(
                  ()=> Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("My Current Location", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Switch(
                        activeColor: CColors.primary,
                        value: controller.useCurrentLocation.value,
                        onChanged: (value) {controller.useCurrentLocation.value = value;},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(()=> controller.useCurrentLocation.value ? const SizedBox.shrink() : vendorTextField(controller: controller.locationController, hint: "Enter Product Location", title: "Location", isPass: false)),
                const SizedBox(height: 10),
                Obx(()=> Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Product Available", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    Switch(
                      activeColor: CColors.primary,
                      value: controller.productAvailable.value,
                      onChanged: (value) {controller.productAvailable.value = value;},
                    )
                  ]
                )),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.pickImages,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(14),
                    ),
                    child: const Text('Add Images', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                Obx(()=> controller.selectedImages.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: controller.selectedImages.asMap().entries.map((entry) => Padding(
                              padding: const EdgeInsets.all(CSizes.defaultSpace / 4),
                              child: Stack(
                                  children: [
                                    Container(
                                      width: 100, height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: CColors.black, width: 1.5),borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(File(entry.value.path),width: 100, height: 100, fit: BoxFit.cover,),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4, right: 4, child: GestureDetector(
                                        onTap: ()=> controller.removeImage(entry.key),
                                        child: Container(width: 18, height: 18, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.close, size: 16,)),
                                      )
                                    )
                                  ],
                                ),
                            )).toList(),
                          )
                        )
                        : const Center(child: Text("Please upload Product Images", style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),),),
                      )
              ]
            )
          )
        ),
      )
    );
  }
  }