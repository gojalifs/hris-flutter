import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee_entity.dart';
import '../repositories/employee_repository.dart';

class GetEmployeesUseCase extends UseCase<List<EmployeeEntity>, GetEmployeesParams> {
  final EmployeeRepository repository;

  GetEmployeesUseCase(this.repository);

  @override
  Future<Either<Failure, List<EmployeeEntity>>> call(
      GetEmployeesParams params) {
    return repository.getEmployees(
      page: params.page,
      limit: params.limit,
      search: params.search,
    );
  }
}

class GetEmployeesParams extends Equatable {
  final int page;
  final int limit;
  final String? search;

  const GetEmployeesParams({
    this.page = 1,
    this.limit = 10,
    this.search,
  });

  @override
  List<Object?> get props => [page, limit, search];
}
