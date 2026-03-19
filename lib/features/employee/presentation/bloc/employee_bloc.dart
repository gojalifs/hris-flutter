import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_employee_usecase.dart';
import '../../domain/usecases/get_employees_usecase.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetEmployeesUseCase getEmployeesUseCase;
  final GetEmployeeUseCase getEmployeeUseCase;

  EmployeeBloc({
    required this.getEmployeesUseCase,
    required this.getEmployeeUseCase,
  }) : super(const EmployeeInitial()) {
    on<GetEmployeesEvent>(_onGetEmployees);
    on<GetEmployeeEvent>(_onGetEmployee);
  }

  Future<void> _onGetEmployees(
    GetEmployeesEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(const EmployeeLoading());
    final result = await getEmployeesUseCase(
      GetEmployeesParams(
        page: event.page,
        limit: event.limit,
        search: event.search,
      ),
    );
    result.fold(
      (failure) => emit(EmployeeError(failure.message)),
      (employees) => emit(
        EmployeesLoaded(
          employees: employees,
          hasMore: employees.length == event.limit,
        ),
      ),
    );
  }

  Future<void> _onGetEmployee(
    GetEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(const EmployeeLoading());
    final result = await getEmployeeUseCase(GetEmployeeParams(id: event.id));
    result.fold(
      (failure) => emit(EmployeeError(failure.message)),
      (employee) => emit(EmployeeDetailLoaded(employee)),
    );
  }
}
