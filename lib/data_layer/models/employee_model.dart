import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String employeeName;
  final String employeeRole;
  final DateTime dateFrom;
  final DateTime? dateTo;

  const Employee({
    required this.employeeName,
    required this.employeeRole,
    required this.dateFrom,
    required this.dateTo,
  });

  @override
  List<Object?> get props => [
        employeeName,
        employeeRole,
        dateFrom,
        dateTo,
      ];
}
