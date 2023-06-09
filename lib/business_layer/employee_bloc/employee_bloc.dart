import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/hive/hive_local_data_base.dart';
import '../../data_layer/models/employee_model.dart';
import '../../resources/hive_db/box_keys.dart';
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
    await Future.delayed(const Duration(seconds: 1));
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
