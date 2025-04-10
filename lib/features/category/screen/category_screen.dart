import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/category/controller/category_controller.dart';
import 'package:rentndeal/features/searchbar/bindings/searchbar_binding.dart';
import 'package:rentndeal/features/searchbar/screens/searchbar_ui.dart';

class CategoryS extends StatelessWidget {
  const CategoryS({super.key});


  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text('Category', style: Theme.of(context).textTheme.headlineMedium),
        ),
        body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: HHelperFunctions.isDarkMode(context) ? CColors.black : CColors.white,
              //expandedHeight: 440,
              expandedHeight: 150,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(CSizes.defaultSpace/4),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: CSizes.spaceBtwItems),
                    SearchBarContainer(hintText: "Search in Store",readOnly: true, onTap: () => Get.to(() => const SearchBarScreen(), binding: SearchBarBinding()),),
                    const SizedBox(height: CSizes.spaceBtwSections),
      
                    /// Featured Brands
                    // SectionHeading(title: 'Featured Brands', onPressed: (){}),
                    // const SizedBox(height: CSizes.spaceBtwItems / 2),
                    // ///
                    // /// Containers for featured Products
                    // GridViewLayout(itemCount: 4, mainAxisExtent: 80, itemBuilder: (_, index){
                    //   return const BrandCard(showBorder: true,);
                    // })
                    
                  ],
                )
              ),
              
              /// Tabs -- 
              bottom: CustomTabBar(
                tabs: categories.map((category) => Tab(child: Text(category.name))).toList()),
              )
          ];
        }, 
        
        
        body: TabBarView(
          children: categories.map((category) => CategoryTab(category: category)).toList(),
        )
        
        ) ,
      ),
    );
  }
}





