import 'package:flutter/material.dart';
import 'package:project_lyca/constants.dart' as constants;

class CustomTheme {
  static ThemeData getThemeByName(String themeName,
      {TextStyle? textStyle, double? fontSize}) {
    switch (themeName) {
      case constants.blueThemeKey:
        return CustomTheme.blueTheme(textStyle, fontSize);
      case constants.whiteThemeKey:
        return CustomTheme.whiteTheme(textStyle, fontSize);
      case constants.darkThemeKey:
        return CustomTheme.darkTheme(textStyle, fontSize);
      case constants.grayThemeKey:
        return CustomTheme.grayTheme(textStyle, fontSize);
      case constants.pinkThemeKey:
        return CustomTheme.pinkTheme(textStyle, fontSize);
      default:
        return CustomTheme.blueTheme(textStyle, fontSize);
    }
  }

  static ThemeData blueTheme(TextStyle? textStyle, double? fontSize) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.white,
            fontStyle: textStyle?.fontStyle,
            fontFamily: textStyle?.fontFamily,
            fontSize: fontSize),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      buttonColor: Colors.white30,
      backgroundColor: Colors.blue,
    );
  }

  static ThemeData pinkTheme(TextStyle? textStyle, double? fontSize) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.white,
            fontStyle: textStyle?.fontStyle,
            fontFamily: textStyle?.fontFamily,
            fontSize: fontSize),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      buttonColor: Colors.white30,
      backgroundColor: Colors.pink,
    );
  }

  static ThemeData whiteTheme(TextStyle? textStyle, double? fontSize) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontStyle: textStyle?.fontStyle,
          fontFamily: textStyle?.fontFamily,
          fontSize: fontSize,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.black),
      buttonColor: Colors.black,
      backgroundColor: Colors.white,
    );
  }

  static ThemeData darkTheme(TextStyle? textStyle, double? fontSize) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontStyle: textStyle?.fontStyle,
          fontFamily: textStyle?.fontFamily,
          fontSize: fontSize,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      buttonColor: Colors.white30,
      backgroundColor: Colors.black,
    );
  }

  static ThemeData grayTheme(TextStyle? textStyle, double? fontSize) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontStyle: textStyle?.fontStyle,
          fontFamily: textStyle?.fontFamily,
          fontSize: fontSize,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      buttonColor: Colors.white30,
      backgroundColor: Colors.grey,
    );
  }
}
