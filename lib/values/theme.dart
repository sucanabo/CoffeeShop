import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../values/color_theme.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: 'Quicksand',
    textTheme: textTheme(),
    splashColor: AppColors.primaryMediumColor,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: AppColors.primaryMediumColor,
    ),
    primaryColor: AppColors.primaryMediumColor,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
    scaffoldBackgroundColor: AppColors.primaryMediumColor,
    appBarTheme: appBarTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      toolbarTextStyle:
          TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 18.0))
              .bodyText2,
      titleTextStyle:
          TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 18.0))
              .headline6);
}

TextTheme textTheme() {
  return TextTheme(
      bodyText1: TextStyle(
        color: AppColors.textColor,
      ),
      bodyText2: TextStyle(color: AppColors.textColor));
}
