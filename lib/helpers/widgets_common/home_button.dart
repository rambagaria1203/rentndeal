import 'package:rentndeal/constants/consts.dart';

Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Column(
    children: [
      Image.asset(icon, width: 26,),
      15.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],).box.rounded.size(width, height).make();

}