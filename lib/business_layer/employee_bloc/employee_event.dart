import 'package:employee_app/data_layer/models/employee_model.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
  @override
  List<Object?> get props => [];
}

class EmployeeLoadingEvent extends EmployeeEvent {}

class EmployeeGetDataEvent extends EmployeeEvent {}

class EmployeeSaveToDBEvent extends EmployeeEvent {
  final Employee employee;

  const EmployeeSaveToDBEvent({required this.employee});
  @override
  List<Object?> get props => [employee];
}

class EmployeeRemoveFromDBEvent extends EmployeeEvent {
  final String id;

  const EmployeeRemoveFromDBEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
