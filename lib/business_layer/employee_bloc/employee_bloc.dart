import 'dart:developer';

import 'package:employee_app/core/hive/hive_local_data_base.dart';
import 'package:employee_app/data_layer/models/employee_model.dart';
import 'package:employee_app/resources/hive_db/box_keys.dart';
import 'package:employee_app/resources/string_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final HiveLocalDatabase localDatabase;
  EmployeeBloc({required this.localDatabase}) : super(EmployeeInitialSate()) {
    on<EmployeeSaveToDBEvent>(_saveEmployeeDataToDB);
    on<EmployeeGetDataEvent>(_getEmployeeDataFromDB);
    on<EmployeeRemoveFromDBEvent>(_removeDataFromDB);
  }

  void _saveEmployeeDataToDB(
      EmployeeSaveToDBEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingSate());
    //saving to database
    localDatabase.addDataToLocalHiveDb<Employee>(
        event.employee, HiveBoxKeys.employeeBoxKey, event.employee.id);
    await Future.delayed(const Duration(seconds: 2));
    emit(EmployeeDataSavedSuccessState());
  }

  void _getEmployeeDataFromDB(
      EmployeeGetDataEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingSate());
    final List<Employee> employeeList = await localDatabase
        .getDataFromHiveDb<Employee>(HiveBoxKeys.employeeBoxKey);

    emit(EmployeeDataLoadedState(employeeList: employeeList));
  }

  void _removeDataFromDB(
      EmployeeRemoveFromDBEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingSate());
    await localDatabase.removeDataFromLocalHiveDb(
        HiveBoxKeys.employeeBoxKey, event.id);
    emit(EmployeeRemovedSuccessSate());
  }
}
