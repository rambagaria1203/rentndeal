import 'package:readmore/readmore.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/product/screens/product_reviews.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(CImages.imgProfile2),),
                const SizedBox(width: CSizes.spaceBtwItems),
                Text('John Doe', style: Theme.of(context).textTheme.titleLarge,),
              ],
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems),

        ///---- Review
        Row(
          children: [
            const ProductRatingIndicator(rating: 4),
            const SizedBox(width: CSizes.spaceBtwItems),
            Text('01 Sep, 2024', style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems,),
        const ReadMoreText(
          'This is a review of a product. This is a review of a product. This is a review of a product. This is a review of a product. This is a review of a product.',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CColors.primary),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CColors.primary),
        ),
        const SizedBox(height: CSizes.spaceBtwItems,),

        /// --- Company Review Reply
        RoundedContainer(
          backgroundColor: dark? CColors.darkerGrey : CColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(CSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rentndeal', style: Theme.of(context).textTheme.titleMedium),
                    Text('01 Sep, 2024', style: Theme.of(context).textTheme.bodyMedium,),
                  ],
                ),
                const SizedBox(height: CSizes.spaceBtwItems,),
                const ReadMoreText(
                  'This is a review of a product. This is a review of a product. This is a review of a product. This is a review of a product. This is a review of a product.',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: 'show less',
                  trimCollapsedText: 'show more',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CColors.primary),
                  lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CColors.primary),
                ),
              ],
            ),),
        ),
        const SizedBox(height: CSizes.spaceBtwItems,),
      ],
    );
  }
}