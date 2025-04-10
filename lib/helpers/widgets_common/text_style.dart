import 'package:rentndeal/constants/consts.dart';
import 'package:velocity_x/velocity_x.dart';

Widget normalText({text, color = Colors.white, size = 13.0}) {
  return "$text".text.color(color).size(size).make();
}
Widget boldText({text, color = Colors.white, size = 14.0}) {
  return "$text".text.semiBold.color(color).size(size).make();
}