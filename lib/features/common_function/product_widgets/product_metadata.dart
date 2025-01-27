import 'package:rentndeal/backend_services/models/product_model.dart';
import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/common_function/widgets/texts/product_price_text.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        ProductTitleText(title: product.productName),
        const SizedBox(height: CSizes.spaceBtwItems),

        /// Price & Sale Price
        Row(
          children: [
            ProductPriceText(price: product.productRent, isLarge: true),
            const SizedBox(width: 8),
            Text(product.productRentPeriod, style: Theme.of(context).textTheme.headlineSmall,),
          ],
          ),
          const SizedBox(height: CSizes.spaceBtwItems / 2),
          Row(
            children: [
              Text('Expected Selling Price - ', style: Theme.of(context).textTheme.bodyMedium,),
              const SizedBox(width: 8),
              ProductPriceText(price: product.productPrice, isLarge: false),
            ]
          ),
          const SizedBox(height: CSizes.spaceBtwItems / 1.5),
      ],
    );
  }
}