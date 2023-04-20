import 'package:employee_app/data_layer/models/employee_model.dart';
import 'package:employee_app/resources/employee_colors.dart';
import 'package:employee_app/resources/images.dart';
import 'package:employee_app/resources/margin_keys.dart';
import 'package:employee_app/resources/string_keys.dart';
import 'package:employee_app/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  int _currentLen = 5;
  int _preLen = 7;

  List<Employee> empList = [
    Employee(
        employeeName: 'Samantha lee',
        employeeRole: 'Full Stacj Developer',
        dateFrom: DateTime.now(),
        dateTo: null),
    Employee(
        employeeName: 'Samantha lee',
        employeeRole: 'Full Stacj Developer',
        dateFrom: DateTime.now(),
        dateTo: null),
    Employee(
        employeeName: 'Samantha lee',
        employeeRole: 'Full Stacj Developer',
        dateFrom: DateTime.now(),
        dateTo: null),
    Employee(
        employeeName: 'Samantha lee',
        employeeRole: 'Full Stacj Developer',
        dateFrom: DateTime.now(),
        dateTo: null),
    Employee(
        employeeName: 'Samantha lee',
        employeeRole: 'Full Stacj Developer',
        dateFrom: DateTime.now(),
        dateTo: null),
  ];

  @override
  void initState() {
    super.initState();
    _currentLen = empList.length;
    _preLen = empList.length;
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
          _currentLen > 0
              ? _buildHeadingText(StringKeys.currnetEmpHeading)
              : const SizedBox(),
          _buildListContainer(_currentLen),
          _preLen > 0
              ? _buildHeadingText(StringKeys.prevEmpHeading)
              : const SizedBox(),
          _buildListContainer(_preLen),
          _buildDeleteInfoText()
        ],
      ),
    );
  }

  _buildDeleteInfoText() {
    return (_currentLen > 0 || _preLen > 0)
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

  _buildListContainer(int listLength) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.32),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: listLength,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final employee = empList[index];
            return Container(
              color: EMPColors.white,
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                    alignment: Alignment.centerRight,
                    color:
                        EMPColors.fromHex(hexString: EMPColors.dismissBgColor),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: MarginKeys.deleteIconRightMargin),
                      child: Image.asset(Images.deleteIcon),
                    )),
                onDismissed: (direction) {
                  // Then show a snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(StringKeys.dismisseText)));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: MarginKeys.margin16,
                        vertical: MarginKeys.margin16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Samantha lee',
                            style: TextStyles.titleText.copyWith(
                                fontWeight: FontWeight.bold,
                                color: EMPColors.fromHex(
                                    hexString: EMPColors.headingColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Text('Full Stack Developer',
                                style: TextStyles.subTitleText.copyWith(
                                  color: EMPColors.fromHex(
                                      hexString: EMPColors.subHeadingColor),
                                )),
                          ),
                          Text('From 1 july, 2022',
                              style: TextStyles.subTitleText.copyWith(
                                color: EMPColors.fromHex(
                                    hexString: EMPColors.subHeadingColor),
                              )),
                        ],
                      ),
                    ),
                    //build line
                    Container(
                      width: double.infinity,
                      height: 0.2,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            );
          }),
    );
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
}
