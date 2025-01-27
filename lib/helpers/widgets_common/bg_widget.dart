import 'package:rentndeal/constants/consts.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(CImages.imgBackground), fit: BoxFit.fill)),
    child: child,
);
}