import 'package:flutter/material.dart';
import 'package:rentndeal/constants/consts.dart';

class TCheckboxTheme {
  TCheckboxTheme._();

// Customixable Light Text Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states){
      if(states.contains(MaterialState.selected)){
        return Colors.white;
    }else {
      return Colors.black;
    }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.selected)){
        return Colors.blue;
        }else {
          return Colors.transparent;
        }
    })
  );

// Customizable Dark Text Theme
static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  checkColor: MaterialStateProperty.resolveWith((states) {
    if(states.contains(MaterialState.selected)){
      return Colors.white;
      }else {
        return Colors.black;
        }
        }),
        fillColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.selected)){
            return Colors.blue;
            }else {
              return Colors.transparent;
            }
          })
      );
}