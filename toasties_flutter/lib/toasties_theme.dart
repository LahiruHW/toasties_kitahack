
import 'package:flutter/material.dart';

class ToastiesTheme{

  ToastiesTheme();

  static Color blue1 = const Color.fromRGBO(0, 109, 170, 1.0);
  static Color blue2 = const Color.fromRGBO(3, 83, 164, 1.0);
  static Color blue3 = const Color.fromRGBO(6, 26, 64, 1.0);
  static Color blue4 = const Color.fromRGBO(185, 214, 242, 1.0);
  static Color grey1 = const Color.fromRGBO(189, 189, 189, 1.0);
  static Color grey2 = const Color.fromRGBO(103, 103, 103, 1.0);

  static ColorScheme colorScheme = ColorScheme.fromSwatch(
    primarySwatch: MaterialColor(0xFF006DAA, <int, Color>{
      50: blue1,
      100: blue2,
      200: blue3,
      300: blue4,
    }),
    accentColor: blue1,
    backgroundColor: blue4,
    errorColor: Colors.red,
    brightness: Brightness.light,
  );


}
