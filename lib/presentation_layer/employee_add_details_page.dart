import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../business_layer/employee_bloc/employee_bloc.dart';
import '../business_layer/employee_bloc/employee_event.dart';
import '../core/custom_date_picker.dart';
import '../core/horizontal_line.dart';
import '../data_layer/models/employee_model.dart';
import '../resources/dimension_keys.dart';
import '../resources/employee_colors.dart';
import '../resources/images.dart';
import '../resources/margin_keys.dart';
import '../resources/string_keys.dart';
import '../resources/styles/text_styles.dart';

class AddEmployeeDetailsPage extends StatefulWidget {
  final EmployeeBloc bloc;
  final Employee? employee;
  const AddEmployeeDetailsPage({super.key, required this.bloc, this.employee});

  @override
  State<AddEmployeeDetailsPage> createState() => _AddEmployeeDetailsPageState();
}

class _AddEmployeeDetailsPageState extends State<AddEmployeeDetailsPage> {
  final TextEditingController _employeeController = TextEditingController();
  final TextEditingController _selectRoleController = TextEditingController();
  final TextEditingController _todayDateController = TextEditingController();
  final TextEditingController _noDateController = TextEditingController();
  bool _isSaveBtnActive = false;

  @override
  void initState() {
    super.initState();
    _employeeController.text = widget.employee?.employeeName ?? '';
    _selectRoleController.text = widget.employee?.employeeRole ?? '';
    _todayDateController.text = widget.employee?.dateFrom ?? '';
    _noDateController.text = widget.employee?.dateTo ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            StringKeys.addEmployeeTitle,
            style: TextStyles.appTitle,
          ),
        ),
        body: _buildBody(),
      ),
    ]);
  }

  _buildBody() {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
        child: Column(
          children: [
            _employeeField(),
            const SizedBox(height: MarginKeys.textFieldMargin),
            _selectRoleField(),
            const SizedBox(height: MarginKeys.textFieldMargin),
            _dateFieldRow(),
            const Spacer(),
            _buildBottomBtns()
          ],
        ),
      ),
    ]);
  }

  _dateFieldRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTodayDateField(),
        Image.asset(Images.arrowRight),
        _buildNoDateFiled(),
      ],
    );
  }

  _selectRoleField() {
    return SizedBox(
      height: DimensionKeys.textFieldHeight,
      child: TextField(
        controller: _selectRoleController,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(DimensionKeys.textFieldBorderRadius)),
                borderSide: BorderSide(
                    width: DimensionKeys.textFieldBorderWidth,
                    color: Colors.grey)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(DimensionKeys.textFieldBorderRadius)),
                borderSide: BorderSide(
                    width: DimensionKeys.textFieldBorderWidth,
                    color: Colors.grey)),
            prefixIcon: Image.asset(Images.roleIcon),
            suffixIcon: Image.asset(Images.roleDropdownIcon),
            hintText: StringKeys.selectRoleHintText,
            hintStyle: _selectRoleController.text.isNotEmpty
                ? TextStyles.titleText.copyWith(
                    color: EMPColors.fromHex(hexString: EMPColors.headingColor))
                : null,
            contentPadding: const EdgeInsets.symmetric(
                vertical: MarginKeys.commonVerticalPadding)),
        readOnly: true,
        onTap: _onSelectRoleTap,
      ),
    );
  }

  _employeeField() {
    return SizedBox(
      height: DimensionKeys.textFieldHeight,
      child: TextField(
        controller: _employeeController,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(DimensionKeys.textFieldBorderRadius)),
                borderSide: BorderSide(
                    width: DimensionKeys.textFieldBorderWidth,
                    color: Colors.grey)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(DimensionKeys.textFieldBorderRadius)),
                borderSide: BorderSide(
                    width: DimensionKeys.textFieldBorderWidth,
                    color: Colors.grey)),
            prefixIcon: Image.asset(Images.employeeIcon),
            hintText: 'Employee name',
            contentPadding: const EdgeInsets.symmetric(
                vertical: MarginKeys.commonVerticalPadding)),
        onChanged: (_) {
          _shouldEnableSaveToDB();
        },
      ),
    );
  }

  _buildBottomBtns() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 40,
              child: OutlinedButton(
                onPressed: _onCancelTap,
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      EMPColors.fromHex(hexString: EMPColors.cancelBtnColor),
                ),
                child: Text(
                  StringKeys.cancelText,
                  style: TextStyles.titleText.copyWith(
                      fontSize: 14,
                      color: EMPColors.fromHex(
                        hexString: EMPColors.lightBlueColor,
                      )),
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              height: 40,
              child: OutlinedButton(
                onPressed: _isSaveBtnActive ? _onSaveTap : null,
                style: OutlinedButton.styleFrom(
                  backgroundColor: _isSaveBtnActive ? Colors.blue : Colors.grey,
                ),
                child: Text(
                  StringKeys.saveText,
                  style: TextStyles.titleText
                      .copyWith(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onCancelTap() {
    Navigator.of(context).pop();
  }

  _onSaveTap() {
    final Employee employee = Employee(
      id: widget.employee?.id ?? UniqueKey().toString(),
      employeeName: _employeeController.text,
      employeeRole: _selectRoleController.text,
      dateFrom: _todayDateController.text,
      dateTo: _noDateController.text,
    );
    widget.bloc.add(EmployeeSaveToDBEvent(employee: employee));
    Navigator.of(context).pop(true);
  }

  _onSelectRoleTap() async {
    await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (_) {
          return _buildBottomRoleSheet();
        });
  }

  _buildBottomRoleSheet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBottomSheetItem(StringKeys.productDesigner),
        const HorizontalLine(),
        _buildBottomSheetItem(StringKeys.flutterDeveloper),
        const HorizontalLine(),
        _buildBottomSheetItem(StringKeys.qaTester),
        const HorizontalLine(),
        _buildBottomSheetItem(StringKeys.productOwner),
      ],
    );
  }

  _buildBottomSheetItem(String text) {
    return InkWell(
      onTap: () {
        _onBottomSheetItemTap(text);
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: MarginKeys.margin16),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  _buildTodayDateField() {
    return SizedBox(
      height: DimensionKeys.textFieldHeight,
      width: 170,
      child: TextField(
        controller: _todayDateController,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(DimensionKeys.textFieldBorderRadius)),
                borderSide: BorderSide(
                    width: DimensionKeys.textFieldBorderWidth,
                    color: Colors.grey)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(DimensionKeys.textFieldBorderRadius)),
                borderSide: BorderSide(
                    width: DimensionKeys.textFieldBorderWidth,
                    color: Colors.grey)),
            prefixIcon: Image.asset(Images.dateIcon),
            hintText: StringKeys.today,
            contentPadding: const EdgeInsets.symmetric(
                vertical: MarginKeys.commonVerticalPadding)),
        readOnly: true,
        onTap: _onTodayDateTap,
      ),
    );
  }

  _buildNoDateFiled() {
    return SizedBox(
      height: DimensionKeys.textFieldHeight,
      width: 170,
      child: TextField(
        controller: _noDateController,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(DimensionKeys.textFieldBorderRadius)),
                borderSide: BorderSide(
                    width: DimensionKeys.textFieldBorderWidth,
                    color: Colors.grey)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(DimensionKeys.textFieldBorderRadius)),
                borderSide: BorderSide(
                    width: DimensionKeys.textFieldBorderWidth,
                    color: Colors.grey)),
            prefixIcon: Image.asset(Images.dateIcon),
            hintText: StringKeys.noDate,
            contentPadding: const EdgeInsets.symmetric(
                vertical: MarginKeys.commonVerticalPadding)),
        readOnly: true,
        onTap: _onNoDateTap,
      ),
    );
  }

  _onBottomSheetItemTap(String item) {
    _selectRoleController.text = item;
    Navigator.of(context).pop();
    _shouldEnableSaveToDB();
  }

  _onTodayDateTap() async {
    final picketdate = await showCustomDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        cancelText: StringKeys.cancelText,
        confirmText: StringKeys.saveText);
    final formattedDate = DateFormat('d MMM y');
    final selectedDate = picketdate != null
        ? formattedDate.format(picketdate)
        : StringKeys.today;
    _todayDateController.text = selectedDate;
    _shouldEnableSaveToDB();
  }

  _onNoDateTap() async {
    final picketdate = await showCustomDatePicker(
        context: context,
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(44.0))),
            child: child,
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        cancelText: StringKeys.cancelText,
        confirmText: StringKeys.saveText,
        isToDate: true);

    final formattedDate = DateFormat('d MMM y');
    final selectedDate = picketdate != null
        ? formattedDate.format(picketdate)
        : StringKeys.noDate;
    _noDateController.text = selectedDate.toString();
  }

  //check for error handling
  _shouldEnableSaveToDB() {
    if (!_isNullOrEmpty(_employeeController.text) &&
        !_isNullOrEmpty(_selectRoleController.text) &&
        !_isNullOrEmpty(_todayDateController.text)) {
      setState(() {
        _isSaveBtnActive = true;
      });
    } else {
      setState(() {
        _isSaveBtnActive = false;
      });
    }
  }

  _isNullOrEmpty(String? text) {
    return (text == null || text.isEmpty) ? true : false;
  }
}
