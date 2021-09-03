import 'package:flutter/material.dart';
import 'package:project_lyca/constants.dart' as constants;

class CustomTheme {
  static ThemeData getThemeByName(String themeName, {TextStyle? textStyle, int? fontSize}) {
    switch (themeName) {
      case constants.blueThemeKey:
        return CustomTheme.blueTheme(textStyle);
      case constants.whiteThemeKey:
        return CustomTheme.whiteTheme(textStyle);
      case constants.darkThemeKey:
        return CustomTheme.darkTheme(textStyle);
      case constants.grayThemeKey:
        return CustomTheme.grayTheme(textStyle);
      case constants.pinkThemeKey:
        return CustomTheme.pinkTheme(textStyle);
      default:
        return CustomTheme.blueTheme(textStyle);
    }
  }

  static ThemeData blueTheme(TextStyle? textStyle) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontStyle: textStyle?.fontStyle,
          fontFamily: textStyle?.fontFamily,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.blue,
    );
  }

  static ThemeData pinkTheme(TextStyle? textStyle) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontStyle: textStyle?.fontStyle,
          fontFamily: textStyle?.fontFamily,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.pink,
    );
  }

  static ThemeData whiteTheme(TextStyle? textStyle) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontStyle: textStyle?.fontStyle,
          fontFamily: textStyle?.fontFamily,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.white,
    );
  }

  static ThemeData darkTheme(TextStyle? textStyle) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontStyle: textStyle?.fontStyle,
          fontFamily: textStyle?.fontFamily,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
    );
  }

  static ThemeData grayTheme(TextStyle? textStyle) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontStyle: textStyle?.fontStyle,
          fontFamily: textStyle?.fontFamily,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.grey,
    );
  }
}
