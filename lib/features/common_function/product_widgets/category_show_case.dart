import 'package:rentndeal/constants/consts.dart';

class CategoryShowCase extends StatelessWidget {
  const CategoryShowCase({
    super.key,
    required this.images,
  });

  final List<String>images;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      showBorder: true,
      borderColor: CColors.darkgrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(CSizes.md),
      margin: const EdgeInsets.only(bottom: CSizes.spaceBtwItems),
      child: Column(
        children: [
          /// Brand with Product count
          //const BrandCard(showBorder: false),
    
          /// Brand Top 3 Product Images
          Row(children: images.map((image) => categoryTopProductImageWidget(image, context)).toList()),
          
        ]
    
      ),
    );
  }

  Widget categoryTopProductImageWidget (String image, context) {
    return Expanded(
      child: RoundedContainer(
        height: 100,
        backgroundColor: HHelperFunctions.isDarkMode(context) ? CColors.darkerGrey : CColors.light,
        margin: const EdgeInsets.only(right: CSizes.sm),
        padding: const EdgeInsets.all(CSizes.md),
        child: Image(fit: BoxFit.contain, image: AssetImage(image)),
      ),
    );
  }
}