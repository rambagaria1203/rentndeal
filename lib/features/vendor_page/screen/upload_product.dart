import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/vendor_page/widgets/dropdown_category.dart';
import 'package:rentndeal/features/vendor_page/widgets/productupload_textfield.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

// Pick image function
  Future<void> pickImages() async {
    if (_selectedImages.length < 6) {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          // Add only the remaining slots up to 6 images
          final remainingSlots = 6 - _selectedImages.length;
          _selectedImages.addAll(images.take(remainingSlots));
        });
      }
    }
  }

// Remove an image
  void removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// App Bar
      appBar: const CustomAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Add Product"),
            Spacer(),
            Text('Save'),
          ],
        ),
        showBackArrow: true,
      ),

// Body
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Vendor text fields
              vendorTextField(hint: "eg. BMW", title: "Product Name", isPass: false),
              const SizedBox(height: 10),
              vendorTextField(hint: "eg. Nice product", title: "Description", isPass: false),
              const SizedBox(height: 10),
              vendorTextField(hint: "eg. \$300/Month", title: "Rent", isPass: false),
              const SizedBox(height: 10),
              vendorTextField(hint: "eg. Week or Month or Year", title: "Rent Period", isPass: false),
              const SizedBox(height: 10),
              vendorTextField(hint: "eg. \$1000.00", title: "Estimate Selling Price", isPass: false),
              const SizedBox(height: 10),
              categoryDropdown('Category', ['Electronics', 'Appliance', 'Vehicles', 'Furnitures']),
              const SizedBox(height: 10),
              categoryDropdown('Sub Category', ['Subcategory A', 'Subcategory B', 'Subcategory C', 'Subcategory D']),
              const SizedBox(height: 10),

// Upload Images for Product
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _selectedImages.length < 6 ? pickImages : null,
                  child: const Text('Add Images'),
                ),
              ),
              const SizedBox(height: 10),

              // Image display
              _selectedImages.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ..._selectedImages.asMap().entries.map((entry) {
                            int index = entry.key;
                            XFile image = entry.value;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 100,height: 100,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1),borderRadius: BorderRadius.circular(12),),
                                    child: ClipRRect(borderRadius: BorderRadius.circular(12),child: Image.file(File(image.path),width: 100,height: 100,fit: BoxFit.cover,),),
                                  ),
// Cross button to remove image
                                  Positioned(
                                    top: 4, right: 4,
                                    child: GestureDetector(
                                      onTap: () => removeImage(index),
                                      child: Container(
                                        width: 20, height: 20,
                                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle,),
                                        child: const Icon(Icons.close,color: Colors.white,size: 16,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),

                          // Add More Box (if less than 6 images)
                          if (_selectedImages.length < 6)
                            GestureDetector(
                              onTap: pickImages,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 100, height: 100,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(12), color: Colors.grey[200],),
                                  child: const Center(child: Text('+ Add More', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : const Text("Please upload Product Images", style: TextStyle(color: Colors.grey),),
            ],
          ),
        ),
      ),
    );
  }
}
