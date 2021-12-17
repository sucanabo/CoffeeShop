part of values;

class AppColors {
  static Color redColor = Colors.red[500];
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color transparentColor = Colors.transparent;
  //Main color
  static Color primaryColor = Color(0xffE98024);
  static Color primaryMediumColor = Color(0xffEDAB54);
  static Color primaryLightColor = Color(0xffFFEBDA);
  static Color darkColor = Color(0xff8E4D00);
  static Color textColor = Color(0xff444444);
  static Color mutedColor = Color(0xff777A7A);
  static LinearGradient primaryGradientColor = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
      colors: [primaryColor, darkColor]);
}
