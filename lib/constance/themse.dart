// ignore_for_file: deprecated_member_use, unused_element, duplicate_ignore, prefer_ubuntupolation_to_compose_strings, prefer_const_constructors, depend_on_referenced_packages, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:esalesapp/constance/globle.dart' as globals;

class CoustomTheme {
  static ThemeData getThemeData() {
    if (globals.isLight) {
      return lightTheme();
    } else {
      return darkTheme();
    }
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline6: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: base.headline6!.color,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle1: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: base.subtitle1!.color,
          fontSize: 16,
        ),
      ),
      subtitle2: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: base.subtitle2!.color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      bodyText2: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: base.bodyText2!.color,
          fontSize: 16,
        ),
      ),
      bodyText1: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          fontSize: 14,
          color: HexColor("#112950"),
        ),
      ),
      button: GoogleFonts.ubuntu(
        textStyle: TextStyle(
            color: base.button!.color,
            fontSize: 14,
            fontWeight: FontWeight.w600),
      ),
      caption: GoogleFonts.ubuntu(
        textStyle: TextStyle(color: base.caption!.color, fontSize: 12),
      ),
      headline4: GoogleFonts.ubuntu(
        textStyle: TextStyle(color: base.headline4!.color, fontSize: 34),
      ),
      headline3: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: base.headline3!.color,
          fontSize: 16,
        ),
      ),
      headline2: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: base.headline2!.color,
          fontSize: 60,
        ),
      ),
      headline1: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: base.headline1!.color,
          fontSize: 96,
        ),
      ),
      headline5: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: base.headline5!.color,
          fontSize: 24,
        ),
      ),
      overline: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: base.overline!.color,
          fontSize: 10,
        ),
      ),
    );
  }

  static ThemeData lightTheme() {
    Color primaryColor = HexColor(globals.primary);
    Color secondaryColor = HexColor(globals.secondary);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );

    final ThemeData base = ThemeData.light();
    return base.copyWith(
      appBarTheme: const AppBarTheme(color: Colors.white),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      splashColor: Colors.white.withOpacity(0.1),
      hoverColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.transparent,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: HexColor("#0065FF"),
      backgroundColor: Colors.white,
      errorColor: Colors.red,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      indicatorColor: primaryColor,
      disabledColor: HexColor("#D5D7D8"),
      dividerColor: Colors.black.withOpacity(0.8),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }

  static ThemeData darkTheme() {
    Color primaryColor = HexColor(globals.primary);
    Color secondaryColor = HexColor(globals.secondary);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      popupMenuTheme: const PopupMenuThemeData(color: Colors.black),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      ),
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      platform: TargetPlatform.iOS,
      dividerColor: Colors.white.withOpacity(0.8),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0.5)),
      dialogBackgroundColor: Colors.black,
      dialogTheme: DialogTheme(
          titleTextStyle: GoogleFonts.sourceSans3(
            color: Colors.white,
            fontSize: 10,
          ),
          contentTextStyle: GoogleFonts.sourceSans3(
            color: Colors.white,
            fontSize: 10,
          ),
          backgroundColor: Colors.black),
    );
  }

  // ignore: unused_element
  static ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    );
  }

  static DialogTheme _dialogTheme() {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  static CardTheme _cardTheme() {
    return CardTheme(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 8,
      margin: EdgeInsets.all(0),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
