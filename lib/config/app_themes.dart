import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:derived_colors/derived_colors.dart';
import 'package:hybrid_assistance/utils/ui_utils.dart';
export 'package:derived_colors/derived_colors.dart';

const kPrimaryColor = Color(0xFF00599F);
const kSecondaryColor = Color(0xFFFF005A);
const kInfoColor = Color(0xFF00BCD4); //Cyan
const kSuccessColor = Color(0xFF00E676); //Green Secondary 400
const kErrorColor = Color(0xFFEF5350); //Red 400
const kWarningColor = Color(0xFFF57C00); //Orange 800
const kBackgroundColor = Color(0xFFF9F9F9);
const kSurfaceColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFFE8E8E8);
const kDarkColor = Color(0xFF979797);

class AppThemes {
  static ThemeData main = ThemeData(
    fontFamily: 'Poppins',
    colorScheme: ColorScheme(
      primary: kPrimaryColor,
      primaryVariant: kPrimaryColor.variants.dark,
      secondary: kSecondaryColor,
      secondaryVariant: kSecondaryColor.variants.dark,
      surface: kSurfaceColor,
      background: kBackgroundColor,
      error: kErrorColor,
      onPrimary: kPrimaryColor.onColor,
      onSecondary: kSecondaryColor.onColor,
      onSurface: kSurfaceColor.onColor,
      onBackground: kBackgroundColor.onColor,
      onError: kErrorColor.onColor,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 96, fontWeight: FontWeight.w300),
      headline2: TextStyle(fontSize: 60, fontWeight: FontWeight.w300),
      headline3: TextStyle(fontSize: 48, fontWeight: FontWeight.w400),
      headline4: TextStyle(fontSize: 34, fontWeight: FontWeight.w400),
      headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
      headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      button: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      overline: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
    ),
    dividerTheme: const DividerThemeData(color: kLightColor, thickness: 1),
    cardTheme: const CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: kRoundedBorder,
        side: BorderSide(color: kLightColor),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: kSurfaceColor,
      isDense: true,
      border: OutlineInputBorder(borderRadius: kRoundedBorder),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: kRoundedBorder),
        minimumSize: const Size(48, 48),
        elevation: 0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: kRoundedBorder),
        minimumSize: const Size(48, 48),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: kRoundedBorder),
        minimumSize: const Size(48, 48),
        primary: kSecondaryColor,
      ),
    ),
  );
}
