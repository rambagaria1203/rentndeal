import 'package:rentndeal/constants/consts.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    this.onTap,
    required this.showBorder,
  });

  final bool showBorder;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    final isDark = HHelperFunctions.isDarkMode(context);

    return GestureDetector(
    onTap: () {},
    child: RoundedContainer(
      padding: const EdgeInsets.all(CSizes.sm),
      showBorder: showBorder,
      backgroundColor: Colors.transparent,
      child: Row(
        children: [
          Flexible(child: CircularImage(isNetworkImage: false, image: CImages.icProduct, backgroundColor: Colors.transparent, overlayColor: isDark ? CColors.black : CColors.white,)),
          const SizedBox(width: CSizes.spaceBtwItems / 2),
    
          // Text
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BrandTitleWithVerifiedIcon(title: 'Nike', brandTextSize: TextSizes.large),
                Text('256 Products', overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelMedium)
              ],
            ),
          )
        ]
        ///
        
      ),
    ),
                      );
  }
}