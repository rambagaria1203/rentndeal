import 'package:cached_network_image/cached_network_image.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/shimmer_effect.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({super.key, required this.image, required this.title, this.textColor = CColors.white, this.isNetworkImage = true, this.backgroundColor, this.onTap});

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap:()=> Get.to(()=> const SubCategoriesScreen()),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: CSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              //width: 56, height: 56, padding: const EdgeInsets.all(CSizes.sm),
              width: 84, height: 56, padding: const EdgeInsets.all(CSizes.sm),
              decoration: BoxDecoration(color: backgroundColor ?? (HHelperFunctions.isDarkMode(context) ? CColors.black : CColors.white), borderRadius: BorderRadius.circular(100)),
              child: Center(child: isNetworkImage
                ? CachedNetworkImage(
                  fit: BoxFit.cover, imageUrl: image,
                  progressIndicatorBuilder: (context, url, downloadProgress) => const ShimmerEffect(width: 55, height: 55),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
                : Image(fit: BoxFit.cover, image: AssetImage(image),
              ),
              ), 
            ),
            const SizedBox(height: CSizes.spaceBtwItems / 2),
            SizedBox(width: 68, child: Text(title, style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),maxLines: 1, overflow: TextOverflow.ellipsis,)),
        
          ],
        ),
      ),
    );
  }
}