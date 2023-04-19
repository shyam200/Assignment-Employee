import 'package:employee_app/resources/string_keys.dart';
import 'package:employee_app/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
