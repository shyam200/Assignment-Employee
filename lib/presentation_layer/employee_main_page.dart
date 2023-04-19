import 'package:employee_app/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../resources/dimension_keys.dart';
import '../resources/images.dart';
import '../resources/string_keys.dart';

class EmployeeMainPage extends StatefulWidget {
  const EmployeeMainPage({super.key});

  @override
  State<EmployeeMainPage> createState() => _EmployeeMainPageState();
}

class _EmployeeMainPageState extends State<EmployeeMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          StringKeys.employeePageTitle,
          style: TextStyles.appTitle,
        ),
      ),
      body: _buildBody(),
      floatingActionButton: SizedBox(
        width: DimensionKeys.floatinActionBtnDimension,
        height: DimensionKeys.floatinActionBtnDimension,
        child: _buildAddBtn(),
      ),
    );
  }

  _buildBody() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.noRecordsImg),
            const Text(
              StringKeys.noEmployeeText,
              style: TextStyles.noEmployeeText,
            ),
          ],
        ),
      );

  FloatingActionButton _buildAddBtn() {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: 'Increment',
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: const Icon(Icons.add),
    );
  }
}
