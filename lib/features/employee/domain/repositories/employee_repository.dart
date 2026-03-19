import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees({
    int page = 1,
    int limit = 10,
    String? search,
  });

  Future<Either<Failure, EmployeeEntity>> getEmployee(String id);
}
