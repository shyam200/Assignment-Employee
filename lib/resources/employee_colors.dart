import 'package:flutter/material.dart';

class EmployeeColors {
  static const _addBtnColor = "#1DA1F2";
  static const _blackColor = "#323238";
  static const _lightGreyColor = "#949C9E";

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

  static get blackColor => fromHex(hexString: _blackColor);
  get addBtnColor => fromHex(hexString: _addBtnColor);
  get lightGreyColor => fromHex(hexString: _lightGreyColor);
}
