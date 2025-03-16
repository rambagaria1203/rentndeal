import 'package:rentndeal/constants/consts.dart';

class ProductLocationInWidget extends StatelessWidget {
  const ProductLocationInWidget({
    super.key,
    this.textColor,
    this.maxLines = 1,
    required this.location,
    this.iconColor = CColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String location;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Iconsax.location, color: CColors.primary, size: CSizes.iconXS),
        const SizedBox(width: CSizes.xs),
        Flexible(
          child: Text(
            location,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis, // ✅ Truncate if too long
            textAlign: textAlign,
            style: TextStyle(
              fontSize: 12,
              color: textColor ?? Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        
      ],
    );
  }
}