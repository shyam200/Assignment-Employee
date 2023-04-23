import 'package:flutter/material.dart';

import '../business_layer/employee_bloc/employee_bloc.dart';
import '../business_layer/employee_bloc/employee_event.dart';
import '../data_layer/models/employee_model.dart';
import '../resources/employee_colors.dart';
import '../resources/images.dart';
import '../resources/margin_keys.dart';
import '../resources/string_keys.dart';
import '../resources/styles/text_styles.dart';
import 'employee_add_details_page.dart';

class EmployeeListPage extends StatefulWidget {
  final EmployeeBloc bloc;
  final List<Employee> employeesList;
  const EmployeeListPage(
      {super.key, required this.bloc, required this.employeesList});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  List<Employee> _currentEmplist = [];
  List<Employee> _prevEmpList = [];

  @override
  void initState() {
    super.initState();
    _retrieveCurrentAndPreviousEmp(widget.employeesList);
  }

  @override
  void didUpdateWidget(covariant EmployeeListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.employeesList != widget.employeesList) {
      _currentEmplist = [];
      _prevEmpList = [];
      _retrieveCurrentAndPreviousEmp(widget.employeesList);
    }
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
                onDismissed: (_) {
                  _onDismissed(employee.id);
                },
                child: _buildListCard(employee),
              ),
            );
          }),
    );
  }

  _buildListCard(Employee employee) {
    return InkWell(
      onTap: () async {
        final shouldRefresh =
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AddEmployeeDetailsPage(
                      bloc: widget.bloc,
                      employee: employee,
                    )));
        if (shouldRefresh ?? false) {
          widget.bloc.add(EmployeeGetDataEvent());
        }
      },
      child: Column(
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
      ),
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
        employee.dateFrom.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(employee.dateFrom,
                      style: TextStyles.subTitleText.copyWith(
                        color: EMPColors.fromHex(
                            hexString: EMPColors.subHeadingColor),
                      )),
                  employee.dateTo!.isNotEmpty
                      ? const Text(' - ')
                      : const SizedBox(),
                  Text(employee.dateTo ?? '',
                      style: TextStyles.subTitleText.copyWith(
                        color: EMPColors.fromHex(
                            hexString: EMPColors.subHeadingColor),
                      )),
                ],
              )
            : const SizedBox(),
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

  _onDismissed(String employeeId) {
    // Then show a snackbar.
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text(StringKeys.dismisseText)));
    //Removing from database
    for (var item in _currentEmplist) {
      if (item.id == employeeId) {
        _currentEmplist.remove(item);
        break;
      }
    }

    for (var item in _prevEmpList) {
      if (item.id == employeeId) {
        _prevEmpList.remove(item);
        break;
      }
    }
    widget.bloc.add(EmployeeRemoveFromDBEvent(id: employeeId));
    // Future.delayed(const Duration(seconds: 1));
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
