import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AttendanceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AttendanceEntity>>> getAttendances({
    required String employeeId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final attendances = await remoteDataSource.getAttendances(
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
      );
      return Right(attendances);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AttendanceEntity>> checkIn({
    required String employeeId,
    required DateTime time,
    String? notes,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final attendance = await remoteDataSource.checkIn(
        employeeId: employeeId,
        time: time,
        notes: notes,
      );
      return Right(attendance);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AttendanceEntity>> checkOut({
    required String attendanceId,
    required DateTime time,
    String? notes,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final attendance = await remoteDataSource.checkOut(
        attendanceId: attendanceId,
        time: time,
        notes: notes,
      );
      return Right(attendance);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
