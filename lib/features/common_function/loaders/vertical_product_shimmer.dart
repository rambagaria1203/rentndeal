import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/loaders/shimmer_effect.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridViewLayout(
      itemCount: itemCount, 
      itemBuilder: (_,__) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ShimmerEffect(width: 180, height: 180),
            SizedBox(height: CSizes.spaceBtwItems),

            // Text
            ShimmerEffect(width: 160, height: 15),
            SizedBox(height: CSizes.spaceBtwItems / 2),
            ShimmerEffect(width: 110, height: 15),
          ],
        ),
      )
    );
  }
}