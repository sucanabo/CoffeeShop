
part of values;
class AppStyles{
  static const double textSize14 = 14;
  static const double textSize15 = 15;
  static const double textSize16 = 16;
  static const double textSize17 = 17;
  static const double textSize18 = 18;
  static const double textSize19 = 19;
  static const double textSize20 = 20;
  static const double textSize21 = 21;
  static const double textSize22 = 22;
  static const double textSize23 = 23;
  static const double textSize24 = 24;
}
final otpInputDecoration = InputDecoration(
    contentPadding:
        EdgeInsets.symmetric(vertical: getWidth(15.0)),
    enabledBorder: otpOulineInputBorder(),
    focusedBorder: otpOulineInputBorder(),
    border: otpOulineInputBorder()
    );

OutlineInputBorder otpOulineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(color: AppColors.textColor),
      
      );
}
