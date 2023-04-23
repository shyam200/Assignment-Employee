import 'package:flutter_bloc/flutter_bloc.dart';

import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitialSate()) {
    on<EmployeeSaveToDBEvent>((event, emit) => _saveEmployeeDataToDB);
  }

  _saveEmployeeDataToDB(
      EmployeeSaveToDBEvent event, Emitter<EmployeeState> emit) {
    //emit loading state
    emit(EmployeeLoadingSate());
    //saving data to DB

    emit(EmployeeDataSavedSuccessState());
  }
}
