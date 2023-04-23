import 'package:flutter/material.dart';

import 'injection/injection_container.dart' as di;
import 'presentation_layer/employee_main_page.dart';
import 'resources/hive_db/hive_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await HiveInit.init();
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
      home: const EmployeeMainPage(),
    );
  }
}
