import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee_entity.dart';
import '../repositories/employee_repository.dart';

class GetEmployeeUseCase extends UseCase<EmployeeEntity, GetEmployeeParams> {
  final EmployeeRepository repository;

  GetEmployeeUseCase(this.repository);

  @override
  Future<Either<Failure, EmployeeEntity>> call(GetEmployeeParams params) {
    return repository.getEmployee(params.id);
  }
}

class GetEmployeeParams extends Equatable {
  final String id;

  const GetEmployeeParams({required this.id});

  @override
  List<Object> get props => [id];
}
