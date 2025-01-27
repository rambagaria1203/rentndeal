import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/product/widget/user_review.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-- App Bar
      appBar: const CustomAppBar(title: Text('Reviews & Ratings'), showBackArrow: true,),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const 
              Text('Reviews & Ratings are verified and are from people who use the same type of device that you use.'),
              const SizedBox(height: CSizes.spaceBtwItems,),

              /// Overall Product Rating
              Row(
                children: [
                  Expanded(flex: 3 ,child: Text('4.8', style: Theme.of(context).textTheme.displayLarge,)),
                  const Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        RatingProgressIndicator(text: '5', value: 1.0),
                        RatingProgressIndicator(text: '4', value: 0.8),
                        RatingProgressIndicator(text: '3', value: 0.6),
                        RatingProgressIndicator(text: '2', value: 0.4),
                        RatingProgressIndicator(text: '1', value: 0.2),
                      ],
                    ),
                  )
                ],
              ),
              /// ---------------------------
              const ProductRatingIndicator(rating: 3.5,),
              Text('12,611', style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: CSizes.spaceBtwSections),

              /// User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
            
            
          )

      ),
      )
    );
  }
}

class ProductRatingIndicator extends StatelessWidget {
  const ProductRatingIndicator({
    super.key, required this.rating
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: CColors.grey,
      itemBuilder: (_, __) => const Icon(Iconsax.star, color: CColors.primary,),
    );
  }
}

