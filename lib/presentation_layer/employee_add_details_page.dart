import 'dart:developer';

import 'package:flutter/material.dart';

import '../core/horizontal_line.dart';
import '../resources/dimension_keys.dart';
import '../resources/employee_colors.dart';
import '../resources/images.dart';
import '../resources/margin_keys.dart';
import '../resources/string_keys.dart';
import '../resources/styles/text_styles.dart';

class AddEmployeeDetailsPage extends StatefulWidget {
  const AddEmployeeDetailsPage({super.key});

  @override
  State<AddEmployeeDetailsPage> createState() => _AddEmployeeDetailsPageState();
}

class _AddEmployeeDetailsPageState extends State<AddEmployeeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          StringKeys.addEmployeeTitle,
          style: TextStyles.appTitle,
        ),
      ),
      body: _buildBody(),
    );
  }

  Padding _buildBody() {
    return Padding(
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
    );
  }

  _dateFieldRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDateField(hintText: 'Today'),
        Image.asset(Images.arrowRight),
        _buildDateField(hintText: 'No date'),
      ],
    );
  }

  _buildDateField({String hintText = ""}) {
    return SizedBox(
      height: DimensionKeys.textFieldHeight,
      width: 170,
      child: TextField(
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
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
                vertical: MarginKeys.commonVerticalPadding)),
        readOnly: true,
      ),
    );
  }

  _selectRoleField() {
    return SizedBox(
      height: DimensionKeys.textFieldHeight,
      child: TextField(
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
                onPressed: _onSaveTap,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue,
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

  _onCancelTap() {}

  _onSaveTap() {
    print('saving.......');
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
      mainAxisAlignment: MainAxisAlignment.center,
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
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(text),
      ),
    );
  }
}
