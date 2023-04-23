import 'package:flutter/material.dart';

class EMPColors {
  static const addBtnColor = "#1DA1F2";
  static const headingColor = "#323238";
  static const lightBlueColor = "#1DA1F2";
  static const cancelBtnColor = "#EDF8FF";
  static const lightGreyColor = "#949C9E";
  static const mainpageBgColor = "#F2F2F2";
  static const subHeadingColor = "#949C9E";
  static const dismissBgColor = "#F34642";
  static const hexWhiteColor = "#FFFFFF";

  static const white = Color(0xffffffff); //R: 255, G: 255, B: 255

  /// added this method to create color from hex color code string
  static Color fromHex(
      {required String hexString, Color defaultColor = white}) {
    try {
      final hexColorCode = hexString.replaceAll('#', 'ff');
      return Color(int.parse(hexColorCode, radix: 16));
    } catch (e) {
      return defaultColor;
    }
  }
}
