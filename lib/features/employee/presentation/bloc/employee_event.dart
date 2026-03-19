import 'package:equatable/equatable.dart';
import '../../domain/entities/employee_entity.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => [];
}

class GetEmployeesEvent extends EmployeeEvent {
  final int page;
  final int limit;
  final String? search;

  const GetEmployeesEvent({
    this.page = 1,
    this.limit = 10,
    this.search,
  });

  @override
  List<Object?> get props => [page, limit, search];
}

class GetEmployeeEvent extends EmployeeEvent {
  final String id;

  const GetEmployeeEvent({required this.id});

  @override
  List<Object> get props => [id];
}
