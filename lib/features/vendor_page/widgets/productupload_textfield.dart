import 'package:rentndeal/constants/consts.dart';

Widget vendorTextField({String? title, String? hint, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(black).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        decoration: InputDecoration(
        hintStyle:const TextStyle(fontFamily:semibold,color: textfieldGrey, ),
        hintText: hint,  
        isDense: true,
        fillColor: whiteColor,
        filled: true,border:InputBorder.none,
        focusedBorder: const OutlineInputBorder(borderSide:BorderSide(color: CColors.blueColor) ) ),
      ),
      7.heightBox,
    ],
  );
}