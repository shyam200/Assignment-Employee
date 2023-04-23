import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../resources/hive_db/hive_type_id.dart';

part 'employee_model.g.dart';

@HiveType(typeId: HiveTypeId.saveEmployeeId)
class Employee extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String employeeName;
  @HiveField(2)
  final String employeeRole;
  @HiveField(3)
  final String dateFrom;
  @HiveField(4)
  final String? dateTo;

  const Employee({
    required this.id,
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
