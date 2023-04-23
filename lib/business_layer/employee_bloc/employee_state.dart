import 'package:equatable/equatable.dart';

abstract class EmployeeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeInitialSate extends EmployeeState {}

class EmployeeLoadingSate extends EmployeeState {}

class EmployeeDataSavedSuccessState extends EmployeeState {}

class EmployeeDataLoadedState extends EmployeeState {}

class EmployeeFailureState extends EmployeeState {}
