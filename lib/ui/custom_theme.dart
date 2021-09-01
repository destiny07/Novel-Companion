import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get blueTheme {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.blue,
    );
  }

  static ThemeData get pinkTheme {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.pink,
    );
  }

  static ThemeData get whiteTheme {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
    );
  }

  static ThemeData get grayTheme {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.grey,
    );
  }
}
