import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemesLibrary {
  ThemesLibrary._();

  static const Color kColorDefaultPrimary = Color(0xFFFFA400);
  static const Color kColorDefaultOnPrimary = Color(0xFFFFFFFF);
  static const Color kColorDefaultPrimarySplashColor = Color(0xFFE65100);

  static const Color kColorDefaultBlack = Color(0xFF000000);
  static const Color kColorDefaultGrey = Color(0xFFF5F5F5);
  static const Color kColorDefaultRed = Color(0xFFB71C1C);
  static const Color kColorDefaultOrange = Color(0xFFFF9800);
  static const Color kColorDefaultGreen = Color(0xFF1B5E20);

  static const LinearGradient kBackgroundLinearGradientInterface = LinearGradient(
    colors: [
      Color(0xFF4CAF50),
      Color(0xFF64B5F6),
      Color(0xFF2196F3),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topLeft,
  );

  static const BoxShadow kBoxShadow = BoxShadow(
    color: Color(0x889E9E9E),
    spreadRadius: 1.0,
    blurRadius: 1.0,
    offset: Offset(0.0, 0.5),
  );

  static const TextStyle kTextStyleSubTitleDrawer = TextStyle(
    color: Color(0x89000000),
    fontSize: 13.0,
    fontStyle: FontStyle.italic,
  );

  static TextStyle kTextStyleInputDecoration = GoogleFonts.nunitoSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static final ButtonStyle kIconButtonCircle = IconButton.styleFrom(
    backgroundColor: kColorDefaultPrimary,
    foregroundColor: kColorDefaultOnPrimary,
    shape: const CircleBorder(
      side: BorderSide(
        color: kColorDefaultOnPrimary,
        width: 1.5,
      ),
    ),
  );

  static final ButtonStyle kFilledButton = FilledButton.styleFrom(
    backgroundColor: kColorDefaultPrimary,
    foregroundColor: kColorDefaultOnPrimary,
    textStyle: const TextStyle(fontWeight: FontWeight.w700),
  );

  static final ColorScheme _kColorScheme = ColorScheme.fromSeed(seedColor: kColorDefaultPrimary);
  static ThemeData kThemeData = ThemeData().copyWith(
    colorScheme: _kColorScheme,
    textTheme: GoogleFonts.poppinsTextTheme(),
    dividerTheme: const DividerThemeData(color: kColorDefaultPrimary),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
      backgroundColor: kColorDefaultPrimary,
      foregroundColor: kColorDefaultOnPrimary,
      splashColor: kColorDefaultPrimarySplashColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kColorDefaultOnPrimary,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9.0)),
      labelStyle: kTextStyleInputDecoration,
      hintStyle: kTextStyleInputDecoration,
      errorStyle: const TextStyle(color: kColorDefaultRed, fontWeight: FontWeight.bold),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: kColorDefaultOnPrimary,
    ),
  );
}
