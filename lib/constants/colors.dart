import 'package:flutter/material.dart';

const Color textfieldGrey = Color.fromRGBO(209, 209, 209, 1);
const Color fontGrey = Color.fromRGBO(107, 115, 119, 1);
const Color darkFontGrey = Color.fromRGBO(62, 68, 71, 1);
const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
const Color lightGrey = Color.fromRGBO(239, 239, 239, 1);
const Color redColor = Color.fromRGBO(230, 46, 4, 1);
//const Color blueColor = Color.fromRGBO(0, 0, 128, 1);
const Color royalblueColor = Color.fromRGBO(65, 105, 225,1);
const Color greyColor = Color.fromRGBO(211, 211, 211, 1);
const Color golden = Color.fromRGBO(255, 168, 0, 1);
const Color black = Color.fromRGBO(0, 0, 0, 1);
const lightGolden = Color(0xfffEEAD1);
const green = Color.fromRGBO(52, 168, 83, 1.0);

class CColors {
  CColors._();

// App Basic Colors
  static const Color primary = Color(0xFF4b68ff);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);
  static const Color blueColor = Color.fromRGBO(0, 0, 128, 1);


// Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      ],
  );

  
// Text Colors
  static const textPrimary = Color(0xFF333333);
  static const textSecondary = Color(0xFF6C7570);
  static const textWhite = Colors.white;


// Background Colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);


// Background Container Colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = CColors.white.withOpacity(0.1);


// Button Colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);


// Border Colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);


// Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);


// Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkgrey = Color(0xFF939393);
  static const Color grey = Color(0xFFEDEDED);
  static const Color softgrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

}