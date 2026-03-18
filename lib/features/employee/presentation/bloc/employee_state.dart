import 'package:equatable/equatable.dart';
import '../../domain/entities/employee_entity.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeState {
  const EmployeeInitial();
}

class EmployeeLoading extends EmployeeState {
  const EmployeeLoading();
}

class EmployeesLoaded extends EmployeeState {
  final List<EmployeeEntity> employees;
  final bool hasMore;

  const EmployeesLoaded({required this.employees, this.hasMore = true});

  @override
  List<Object> get props => [employees, hasMore];
}

class EmployeeDetailLoaded extends EmployeeState {
  final EmployeeEntity employee;

  const EmployeeDetailLoaded(this.employee);

  @override
  List<Object> get props => [employee];
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);

  @override
  List<Object> get props => [message];
}
