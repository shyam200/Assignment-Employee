import 'package:flutter/material.dart';

import '../employee_colors.dart';

abstract class TextStyles {
  static const appTitle = TextStyle(
      color: EmployeeColors.white,
      fontWeight: FontWeight.w500,
      fontFamily: "Roboto",
      fontSize: 18.0);

  static const noEmployeeText = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: "Roboto",
    fontSize: 18.0,
  );

  static const smallText = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: "Roboto",
    fontSize: 16.0,
  );
}
