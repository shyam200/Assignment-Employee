import 'dart:developer';

import 'package:employee_app/data_layer/models/employee_model.dart';
import 'package:employee_app/resources/employee_colors.dart';
import 'package:employee_app/resources/images.dart';
import 'package:employee_app/resources/margin_keys.dart';
import 'package:employee_app/resources/string_keys.dart';
import 'package:employee_app/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

class EmployeeListPage extends StatefulWidget {
  final List<Employee> employeesList;
  const EmployeeListPage({super.key, required this.employeesList});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  final List<Employee> _currentEmplist = [];
  final List<Employee> _prevEmpList = [];

  @override
  void initState() {
    super.initState();
    _retrieveCurrentAndPreviousEmp(widget.employeesList);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Scaffold(
      backgroundColor: EMPColors.fromHex(hexString: EMPColors.mainpageBgColor),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _currentEmplist.isNotEmpty
              ? _buildHeadingText(StringKeys.currnetEmpHeading)
              : const SizedBox(),
          _buildListContainer(_currentEmplist),
          _prevEmpList.isNotEmpty
              ? _buildHeadingText(StringKeys.prevEmpHeading)
              : const SizedBox(),
          _buildListContainer(_prevEmpList),
          _buildDeleteInfoText()
        ],
      ),
    );
  }

  _buildDeleteInfoText() {
    return (_currentEmplist.isNotEmpty || _prevEmpList.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.only(top: 12, left: MarginKeys.margin16),
            child: Text(
              StringKeys.deleteInfoText,
              style: TextStyles.subTitleText.copyWith(
                  fontSize: 15,
                  color:
                      EMPColors.fromHex(hexString: EMPColors.lightGreyColor)),
            ),
          )
        : const SizedBox();
  }

  _buildListContainer(List<Employee> employeeList) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.32),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: employeeList.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final employee = employeeList[index];
            return Container(
              color: EMPColors.white,
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: _buildDismisssibleBackground(),
                onDismissed: (direction) {
                  // Then show a snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(StringKeys.dismisseText)));
                },
                child: _buildListCard(employee),
              ),
            );
          }),
    );
  }

  _buildListCard(Employee employee) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MarginKeys.margin16,
            vertical: MarginKeys.margin16,
          ),
          child: _buildListCardItems(employee),
        ),
        //build line
        Container(
          width: double.infinity,
          height: 0.2,
          color: Colors.grey,
        )
      ],
    );
  }

  _buildListCardItems(Employee employee) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          employee.employeeName,
          style: TextStyles.titleText.copyWith(
              fontWeight: FontWeight.bold,
              color: EMPColors.fromHex(hexString: EMPColors.headingColor)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(employee.employeeRole,
              style: TextStyles.subTitleText.copyWith(
                color: EMPColors.fromHex(hexString: EMPColors.subHeadingColor),
              )),
        ),
        Row(
          children: [
            Text(employee.dateFrom,
                style: TextStyles.subTitleText.copyWith(
                  color:
                      EMPColors.fromHex(hexString: EMPColors.subHeadingColor),
                )),
            employee.dateTo!.isNotEmpty ? const Text(' - ') : const SizedBox(),
            Text(employee.dateTo ?? '',
                style: TextStyles.subTitleText.copyWith(
                  color:
                      EMPColors.fromHex(hexString: EMPColors.subHeadingColor),
                )),
          ],
        )
      ],
    );
  }

  _buildDismisssibleBackground() {
    return Container(
        alignment: Alignment.centerRight,
        color: EMPColors.fromHex(hexString: EMPColors.dismissBgColor),
        child: Padding(
          padding:
              const EdgeInsets.only(right: MarginKeys.deleteIconRightMargin),
          child: Image.asset(Images.deleteIcon),
        ));
  }

  _buildHeadingText(String headingText) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: MarginKeys.margin16, horizontal: MarginKeys.margin16),
      child: Text(
        headingText,
        style: TextStyles.titleText.copyWith(
            color: EMPColors.fromHex(hexString: EMPColors.lightBlueColor)),
      ),
    );
  }

  _retrieveCurrentAndPreviousEmp(List<Employee> empList) {
    for (int i = 0; i < empList.length; i++) {
      Employee employee = empList[i];
      if (_isPrevEmployee(employee)) {
        _prevEmpList.add(employee);
      } else {
        _currentEmplist.add(employee);
      }
    }
  }

  bool _isPrevEmployee(Employee employee) {
    return (employee.dateFrom.isNotEmpty &&
        employee.dateTo != null &&
        employee.dateTo!.isNotEmpty);
  }
}
