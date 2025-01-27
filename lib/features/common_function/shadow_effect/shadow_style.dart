import 'package:rentndeal/constants/consts.dart';

class ShadowStyle{

  static final verticalProductShadow = BoxShadow(
    color: CColors.darkerGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)

  );


  static final horizontalProductShadow = BoxShadow(
    color: CColors.darkerGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(2, 0)
  );
}