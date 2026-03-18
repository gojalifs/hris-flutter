import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/leave_entity.dart';
import '../../domain/repositories/leave_repository.dart';
import '../datasources/leave_remote_datasource.dart';

class LeaveRepositoryImpl implements LeaveRepository {
  final LeaveRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LeaveRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<LeaveEntity>>> getLeaves({
    required String employeeId,
    String? status,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final leaves = await remoteDataSource.getLeaves(
        employeeId: employeeId,
        status: status,
      );
      return Right(leaves);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LeaveEntity>> applyLeave({
    required String employeeId,
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final leave = await remoteDataSource.applyLeave(
        employeeId: employeeId,
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
      );
      return Right(leave);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LeaveEntity>> approveLeave(String leaveId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final leave = await remoteDataSource.approveLeave(leaveId);
      return Right(leave);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, LeaveEntity>> rejectLeave({
    required String leaveId,
    required String notes,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final leave = await remoteDataSource.rejectLeave(
        leaveId: leaveId,
        notes: notes,
      );
      return Right(leave);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
