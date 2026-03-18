import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasources/employee_remote_datasource.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EmployeeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final employees = await remoteDataSource.getEmployees(
        page: page,
        limit: limit,
        search: search,
      );
      return Right(employees);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> getEmployee(String id) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final employee = await remoteDataSource.getEmployee(id);
      return Right(employee);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
