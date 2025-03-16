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
        ProductTitleText(title: product.productName),
        const SizedBox(height: CSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ProductPriceText(price: product.productRent, isLarge: true),
            const SizedBox(width: 6),
            Text("/ ${product.productRentPeriod.replaceFirst('Per ', '')}", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 2),
        if (product.productPrice.isNotEmpty)
          Row(
            children: [
              const Icon(Iconsax.tag, size: 20, color: Colors.green),
              const SizedBox(width: 6),
              Text("Available for Purchase:", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black,),),
              const SizedBox(width: 6),
              ProductPriceText(price: product.productPrice, isLarge: false)
            ],
          ),
        const SizedBox(height: CSizes.spaceBtwItems / 1.5),
        Column(
          children: [
              Row(
                children: [
                const Icon(Iconsax.security_user, size: 20, color: Colors.amber),
                const SizedBox(width: 6),
                Text("Security Deposit: ", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 6),
                ProductPriceText(price: product.productSecurityDeposit.isNotEmpty && product.productSecurityDeposit != "0" ? product.productSecurityDeposit : "0 Deposite", isLarge: false),
              ],
            ),
            const SizedBox(height: CSizes.spaceBtwItems / 1.5),
            Row(
              children: [
                const Icon(Iconsax.truck, size: 20, color: Colors.green),
                const SizedBox(width: 6),
                Text("Delivery Fee: ", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 6),
                ProductPriceText(price: product.productDeliveryFee.isNotEmpty ? product.productDeliveryFee : "Free Delivery", isLarge: false),
              ],
            ),
          ],
        ),
      ],
    );
  }
}