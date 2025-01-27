import 'package:rentndeal/constants/consts.dart';

Widget ourButton({onPress, color, textColor,String? title}) {

  return ElevatedButton(
    
    style: ElevatedButton.styleFrom(
      backgroundColor:color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed:onPress,
    child: title!.text.color(textColor).fontFamily(semibold).size(16).make());
}