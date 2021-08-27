import 'dart:convert';
import 'dart:io';

import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

//decode image base64
MemoryImage base64StringToImage(String base64String) {
  return MemoryImage(base64Decode(base64String));
}

String imageToBase64String(File image) {
  if (image != null) {
    return base64Encode(image.readAsBytesSync());
  }
  return null;
}

//Convert to hex color function
int hexColor(String color) {
  //add prefix
  String newColor = '0xff' + color;
  //remove #
  newColor = newColor.replaceAll('#', '');
  //convert it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}

//caculatePrice
double caculatePrice({discount, price}) {
  return price * ((100 - discount) / 100);
}

//Convert VND currency
String convertVND(double price) {
  return NumberFormat.currency(locale: "vi", symbol: 'đ').format(price);
}

//show SnackBar Message
void showMess({@required BuildContext context, @required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

//Capital String
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

//date formart
String formartDate(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

//greeting
Widget greeting(String userName) {
  var hour = DateTime.now().hour;
  print(hour);
  String session = '';
  if (hour < 12) {
    session = 'Morning';
  } else if (hour < 17)
    session = 'Afternoon';
  else
    session = 'Evening';
  return Row(children: <Widget>[
    SvgPicture.asset(
        hour < 17 ? 'assets/icons/sun.svg' : 'assets/icons/moon.svg'),
    SizedBox(width: 10.0),
    Text(
      'Good $session, $userName',
      style: TextStyle(
          color: textColor, fontSize: 20.0, fontWeight: FontWeight.w500),
    ),
  ]);
}

//copy clipboard
void coppyClipBoard(String text, context) {
  Clipboard.setData(ClipboardData(text: text)).then((value) =>
      showMess(text: 'Copied $text into clipboard.', context: context));
}
