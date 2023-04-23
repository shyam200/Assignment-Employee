import 'package:get_it/get_it.dart';

import '../business_layer/employee_bloc/employee_bloc.dart';

//This will hold dependency injection
///setting [di] naming from dependency injection
final di = GetIt.instance;

Future<void> init() async {
  //!Bloc
  di.registerFactory<EmployeeBloc>(() => EmployeeBloc());
}
