import 'package:flutter/material.dart';

import '../resources/employee_colors.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 0.5,
        color: EMPColors.fromHex(
          hexString: EMPColors.lightGreyColor,
        ));
  }
}
