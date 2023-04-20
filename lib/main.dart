import 'package:employee_app/presentation_layer/employee_list_page.dart';
import 'package:employee_app/presentation_layer/employee_main_page.dart';
import 'package:flutter/material.dart';

import 'presentation_layer/employee_add_details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddEmployeeDetailsPage(),
    );
  }
}
