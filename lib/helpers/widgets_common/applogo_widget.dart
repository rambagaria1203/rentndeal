import 'package:flutter/cupertino.dart';
import 'package:rentndeal/constants/consts.dart';

Widget applogoWidget(){
  return Image.asset(CImages.icAppLogo).box.size(140, 140).padding(const EdgeInsets.all(0.5)).rounded.make();
}