import 'package:equatable/equatable.dart';

import '../../data_layer/models/employee_model.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();
  @override
  List<Object?> get props => [];
}

class EmployeeInitialSate extends EmployeeState {}

class EmployeeLoadingSate extends EmployeeState {}

class EmployeeDataSavedSuccessState extends EmployeeState {}

class EmployeeDataLoadedState extends EmployeeState {
  final List<Employee> employeeList;

  const EmployeeDataLoadedState({required this.employeeList});
  @override
  List<Object?> get props => [employeeList];
}

class EmployeeFailureState extends EmployeeState {}

class EmployeeRemovedSuccessSate extends EmployeeState {}
