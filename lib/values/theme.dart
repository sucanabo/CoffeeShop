import 'package:flutter/material.dart';
import '../values/color_theme.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: 'Quicksand',
    textTheme: textTheme(),
    primaryColor: primaryColor,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
    scaffoldBackgroundColor: primaryMediumColor,
    inputDecorationTheme: inputDecorationTheme(),
    appBarTheme: appBarTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    labelStyle: TextStyle(
        color: textColor, fontSize: 16.0, fontWeight: FontWeight.w500),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: textColor),
        gapPadding: 10.0),
    disabledBorder: (OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.grey[400]),
        gapPadding: 10.0)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: primaryColor),
        gapPadding: 10.0),
    helperStyle: TextStyle(color: Colors.red[300], fontWeight: FontWeight.w500),
    helperMaxLines: 1,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      brightness: Brightness.dark,
      elevation: 0,
      textTheme:
          TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 18.0)));
}

TextTheme textTheme() {
  return TextTheme(
      bodyText1: TextStyle(
        color: textColor,
      ),
      bodyText2: TextStyle(color: textColor));
}
