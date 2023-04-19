import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String employeeName;
  final String employeeRole;
  final DateTime dateFrom;
  final DateTime dateTo;

  const Employee(
      this.employeeName, this.employeeRole, this.dateFrom, this.dateTo);

  @override
  List<Object?> get props => [
        employeeName,
        employeeRole,
        dateFrom,
        dateTo,
      ];
}
