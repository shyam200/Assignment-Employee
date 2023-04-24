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
import 'employee_add_details_page.dart';
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
          body: state is EmployeeLoadingSate
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _buildBody(),
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
    // await Future.delayed(Duration(seconds: 2)).then((value) {},),
    return _employeesList.isNotEmpty
        ? EmployeeListPage(
            bloc: _bloc,
            employeesList: _employeesList,
            removeItemCallback: _removeItemFromLocalList,
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
      onPressed: () async {
        final shouldRefresh = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => AddEmployeeDetailsPage(bloc: _bloc)));

        if (shouldRefresh ?? false) {
          _bloc.add(EmployeeGetDataEvent());
        }
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: const Icon(Icons.add),
    );
  }

  _removeItemFromLocalList(String id) {
    for (var employee in _employeesList) {
      if (employee.id == id) {
        _employeesList.remove(employee);
        break;
      }
    }
  }
}
