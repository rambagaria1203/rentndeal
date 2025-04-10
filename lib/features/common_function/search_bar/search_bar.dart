import 'package:rentndeal/constants/consts.dart';

class SearchBarContainer extends StatelessWidget {
  const SearchBarContainer({
    super.key,
    required this.hintText,
    this.showBackground = true,
    this.showBorder = true,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.borderColor = CColors.grey,
    this.padding = const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
  });

  final String hintText;
  final Color borderColor;
  final GestureTapCallback? onTap;
  final bool showBackground, showBorder, readOnly;
  final ValueChanged<String>? onChanged; // Callback to handle input changes
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = HHelperFunctions.isDarkMode(context);

    return Padding(
      padding: padding,
      child: TextField(
        readOnly: readOnly,
        onTap: readOnly ? onTap : null,
        onChanged: onChanged, // Handle input
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search, color: CColors.darkerGrey),
          filled: showBackground,
          fillColor: dark ? CColors.dark : CColors.light,
          border: showBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CSizes.cardRadiusLg),
                  borderSide: BorderSide(color: borderColor),
                )
              : InputBorder.none,
          enabledBorder: showBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CSizes.cardRadiusLg),
                  borderSide: BorderSide(color: borderColor),
                )
              : InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(CSizes.cardRadiusLg),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
