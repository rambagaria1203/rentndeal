import 'package:rentndeal/backend_services/models/category_model.dart';
import 'package:rentndeal/constants/images.dart';

class DummyData {

  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', name: 'Appliances', image: CImages.imgS5, isFeatured: true),
    CategoryModel(id: '2', name: 'Electronics', image: CImages.imgS4, isFeatured: true),
    CategoryModel(id: '3', name: 'Furnitures', image: CImages.imgS3, isFeatured: true),
    CategoryModel(id: '4', name: 'Vehicles', image: CImages.imgS6, isFeatured: true),

    // SubCategories

    //Appliance
    CategoryModel(id: '11', name: 'Air Conditioner', image: CImages.imgS5, parentId: '1', isFeatured: false),
    CategoryModel(id: '12', name: 'Air Cooler', image: CImages.imgS5, parentId: '1', isFeatured: false),
    CategoryModel(id: '13', name: 'Microwave Oven', image: CImages.imgS5, parentId: '1', isFeatured: false),
    CategoryModel(id: '14', name: 'Refrigerator', image: CImages.imgS5, parentId: '1', isFeatured: false),
    CategoryModel(id: '15', name: 'Television', image: CImages.imgS5, parentId: '1', isFeatured: false),
    CategoryModel(id: '16', name: 'Washing Machine', image: CImages.imgS5, parentId: '1', isFeatured: false),
    CategoryModel(id: '17', name: 'Water Purifier', image: CImages.imgS5, parentId: '1', isFeatured: false),

    // Electronics
    CategoryModel(id: '21', name: 'Mobile', image: CImages.imgS5, parentId: '1', isFeatured: false),
    CategoryModel(id: '22', name: 'Tab', image: CImages.imgS5, parentId: '2', isFeatured: false),
    CategoryModel(id: '23', name: 'Laptop', image: CImages.imgS5, parentId: '2', isFeatured: false),
    CategoryModel(id: '24', name: 'Speaker', image: CImages.imgS5, parentId: '2', isFeatured: false),
    CategoryModel(id: '25', name: 'Watch', image: CImages.imgS5, parentId: '2', isFeatured: false),

    // Furnitures
    CategoryModel(id: '31', name: 'Bed', image: CImages.imgS5, parentId: '3', isFeatured: false),
    CategoryModel(id: '32', name: 'Chair', image: CImages.imgS5, parentId: '3', isFeatured: false),
    CategoryModel(id: '33', name: 'Table', image: CImages.imgS5, parentId: '3', isFeatured: false),
    CategoryModel(id: '34', name: 'Sofa', image: CImages.imgS5, parentId: '3', isFeatured: false),
    CategoryModel(id: '35', name: 'Wardrobe', image: CImages.imgS5, parentId: '3', isFeatured: false),

    // Vehicle
    CategoryModel(id: '41', name: 'Bicycle', image: CImages.imgS5, parentId: '4', isFeatured: false),
    CategoryModel(id: '42', name: 'Scooter', image: CImages.imgS5, parentId: '4', isFeatured: false),
    CategoryModel(id: '43', name: 'Bike', image: CImages.imgS5, parentId: '4', isFeatured: false),
    CategoryModel(id: '44', name: 'Car', image: CImages.imgS5, parentId: '4', isFeatured: false),

  ];
}