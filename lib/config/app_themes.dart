import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:derived_colors/derived_colors.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
export 'package:derived_colors/derived_colors.dart';

const Color kPrimary = Color(0xFF00599F);
const Color kSecondary = Color(0xFFFF005A);
const Color kInfo = Color(0xFF00BCD4); //Cyan
const Color kSuccess = Color(0xFF00E676); //Green Secondary 400
const Color kError = Color(0xFFEF5350); //Red 400
const Color kWarning = Color(0xFFF57C00); //Orange 800
const Color kLight = Color(0xFFF5F5F5);
const Color kDark = Color(0xFF959595);

class AppThemes {
  static ThemeData main = ThemeData(
    primaryColor: kPrimary,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme(
      primary: kPrimary,
      primaryVariant: kPrimary.variants.dark,
      secondary: kSecondary,
      secondaryVariant: kSecondary.variants.dark,
      surface: Colors.white,
      background: kLight,
      error: kError,
      onPrimary: kPrimary.onColor,
      onSecondary: kSecondary.onColor,
      onSurface: Colors.white.onColor,
      onBackground: kLight.onColor,
      onError: kError.onColor,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 122, fontWeight: FontWeight.bold),
      headline2: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
      headline3: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
      headline4: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
      headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(fontSize: 16),
      subtitle2: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 14),
      caption: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
      button: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      overline: TextStyle(fontSize: 10),
    ),
    scaffoldBackgroundColor: kLight,
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(borderRadius: kRoundedBorder),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: kPrimary,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(fontSize: 16),
      filled: true,
      fillColor: kSecondary.variants.light,
      border: const UnderlineInputBorder(borderRadius: kRoundedBorder, borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(borderRadius: kRoundedBorder, borderSide: BorderSide(color: kPrimary)),
      errorBorder: const OutlineInputBorder(borderRadius: kRoundedBorder, borderSide: BorderSide(color: kError)),
      focusedErrorBorder: const OutlineInputBorder(borderRadius: kRoundedBorder, borderSide: BorderSide(color: kError)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: kRoundedBorder),
        minimumSize: const Size(44, 44),
        onPrimary: Colors.white,
        primary: kSecondary,
        elevation: 0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: kRoundedBorder),
        minimumSize: const Size(44, 44),
        primary: kSecondary,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: kRoundedBorder),
        minimumSize: const Size(44, 44),
        primary: kSecondary,
      ),
    ),
  );
}
