import 'package:flutter/material.dart';
Color colorPrimary = Color(0xffE98024);
Color colorPrimary_medium = Color(0xffEDAB54);
Color colorPrimary_light = Color(0xffFFEBDA);
Color colorDark = Color(0xff8E4D00);
Color colorBlack = Color(0xff444444);
Color colorMuted = Color(0xff9D9D9D);
int hexColor(String color){
  //add prefix
  String newColor = '0xff' + color;
  //remove #
  newColor = newColor.replaceAll('#', '');
  //convert it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}