import 'package:flutter/material.dart';

abstract class TextStyles {
  static const appTitle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontFamily: "Roboto",
      fontSize: 18.0);

  static const noEmployeeText = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: "Roboto",
    fontSize: 18.0,
  );

  static const titleText = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: "Roboto",
    fontSize: 16.0,
  );

  static const subTitleText = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: "Roboto",
    fontSize: 14.0,
  );
  //  static const smallText = TextStyle(
  //   fontWeight: FontWeight.w400,
  //   fontFamily: "Roboto",
  //   fontSize: 16.0,
  // );
}
