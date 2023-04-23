import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_layer/employee_bloc/employee_bloc.dart';
import '../business_layer/employee_bloc/employee_event.dart';
import '../business_layer/employee_bloc/employee_state.dart';
import '../data_layer/models/employee_model.dart';
import '../injection/injection_container.dart';
import '../resources/dimension_keys.dart';
import '../resources/images.dart';
import '../resources/string_keys.dart';
import '../resources/styles/text_styles.dart';
import 'employee_list_page.dart';

class EmployeeMainPage extends StatefulWidget {
  const EmployeeMainPage({super.key});

  @override
  State<EmployeeMainPage> createState() => _EmployeeMainPageState();
}

class _EmployeeMainPageState extends State<EmployeeMainPage> {
  late EmployeeBloc _bloc;
  List<Employee> _employeesList = [];

  @override
  void initState() {
    super.initState();
    _bloc = di<EmployeeBloc>();
    _bloc.add(EmployeeGetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (context, state) {
        if (state is EmployeeDataLoadedState) {
          _employeesList = state.employeeList;
        }
      },
      builder: (context, state) {
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
      },
    );
  }

  _buildBody() {
    return _employeesList.isNotEmpty
        ? EmployeeListPage(
            employeesList: _employeesList,
          )
        : _buildNoDataImage();
  }

  _buildNoDataImage() {
    return Center(
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
  }

  FloatingActionButton _buildAddBtn() {
    return FloatingActionButton(
      onPressed: () {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: const Icon(Icons.add),
    );
  }
}
