import 'package:flutter/material.dart';

class TAppBarTheme {
  TAppBarTheme._();

// Customixable Light Text Theme
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black, size:24),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
  );

// Customixable Dark Text Theme
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size:24),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  );
}