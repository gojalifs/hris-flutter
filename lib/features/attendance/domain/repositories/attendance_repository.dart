import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/attendance_entity.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, List<AttendanceEntity>>> getAttendances({
    required String employeeId,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<Failure, AttendanceEntity>> checkIn({
    required String employeeId,
    required DateTime time,
    String? notes,
  });

  Future<Either<Failure, AttendanceEntity>> checkOut({
    required String attendanceId,
    required DateTime time,
    String? notes,
  });
}
