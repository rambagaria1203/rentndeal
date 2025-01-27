import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/category/controller/category_controller.dart';
import 'package:rentndeal/features/common_function/loaders/category_shimmer.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if(categoryController.isLoading.value) return const CategoryShimmer();

      if(categoryController.featuredCategories.isEmpty){
        return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true, itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return VerticalImageText(image: category.image, title: category.name, onTap: () => Get.to(() => SubCategoriesScreen(category: category)),);
          },
        ),
      );
    } 
    );
  }
}