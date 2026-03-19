import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendancesUseCase
    extends UseCase<List<AttendanceEntity>, GetAttendancesParams> {
  final AttendanceRepository repository;

  GetAttendancesUseCase(this.repository);

  @override
  Future<Either<Failure, List<AttendanceEntity>>> call(
      GetAttendancesParams params) {
    return repository.getAttendances(
      employeeId: params.employeeId,
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

class GetAttendancesParams extends Equatable {
  final String employeeId;
  final DateTime? startDate;
  final DateTime? endDate;

  const GetAttendancesParams({
    required this.employeeId,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [employeeId, startDate, endDate];
}
