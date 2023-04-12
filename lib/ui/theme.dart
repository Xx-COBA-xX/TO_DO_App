import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData.light().copyWith(
    colorScheme: ColorScheme(
        background: white,
        brightness: Brightness.light,
        error: Colors.red,
        onBackground: Get.isDarkMode ? darkGreyClr : primaryClr,
        onError: Colors.red,
        onPrimary: white,
        onSecondary: darkGreyClr,
        primary: Colors.grey,
        onSurface: primaryClr,
        secondary: Colors.pink,
        surface: Colors.black),
  );
  static final dark = ThemeData.light().copyWith(
    colorScheme: const ColorScheme(
          background: darkGreyClr,
          brightness: Brightness.dark,
          error: Colors.red,
          onBackground: Colors.black,
          onError: Colors.red,
          onPrimary: white,
          onSecondary: darkGreyClr,
          onSurface: Colors.black,
          primary: primaryClr,
          secondary: darkHeaderClr,
          surface: Colors.white,
        ),
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 24, 
      color: white,
      fontWeight:FontWeight.bold
    ),
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 18, 
      color:white,
      fontWeight:FontWeight.w500
    ),
  );
}

TextStyle get descStyle{
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16, 
      color: white,
      fontWeight:FontWeight.w400
    ),
  );
}


