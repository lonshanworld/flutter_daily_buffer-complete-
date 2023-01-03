import "package:flutter/material.dart";

import 'dimensions.dart';

class CustomTheme{
  static final lightTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    )
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      )
  );
}


TextStyle get CustomsubHeadingStyle{
  return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: Dimensions.oneUnitHeight * 22,
      color: Colors.grey,
      fontFamily: "RobotoCondensed",
    );
}

TextStyle get CustomHeadingStyle{
  return TextStyle(
    fontSize: Dimensions.oneUnitHeight * 26,
    fontFamily: "Cabin",
    fontWeight: FontWeight.bold,
  );
}

TextStyle get Customtitle{
  return TextStyle(
    fontSize: Dimensions.oneUnitHeight * 14,
    fontWeight: FontWeight.bold,
    fontFamily: "Cabin",
  );
}

TextStyle get Customsubtitle{
  return TextStyle(
      fontSize: Dimensions.oneUnitHeight * 14,
    fontFamily: "Cabin",
  );
}