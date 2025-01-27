import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/shimmer_effect.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key, this.itemCount = 3});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: CSizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: CSizes.spaceBtwItems / 2),

              // Text
              ShimmerEffect(width: 55, height: 8),
            ]
          );
        }, 
      ),
    );
  }
}