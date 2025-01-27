import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';

class RatingAndShare extends StatelessWidget {
  const RatingAndShare({
    super.key, required this.product
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(
      children: [
        const Icon(Iconsax.star, color: Colors.amber, size: 24),
        const SizedBox(width: CSizes.spaceBtwItems / 2),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: product.productRating, style: Theme.of(context).textTheme.bodyLarge),
              const TextSpan(text: '(199)'),
            ]))
      ]
      ),
      IconButton(onPressed: (){}, icon: const Icon(Icons.share, size: CSizes.iconMd,))
      ],
    );
  }
}