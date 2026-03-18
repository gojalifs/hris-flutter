import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class CheckInUseCase extends UseCase<AttendanceEntity, CheckInParams> {
  final AttendanceRepository repository;

  CheckInUseCase(this.repository);

  @override
  Future<Either<Failure, AttendanceEntity>> call(CheckInParams params) {
    return repository.checkIn(
      employeeId: params.employeeId,
      time: params.time,
      notes: params.notes,
    );
  }
}

class CheckInParams extends Equatable {
  final String employeeId;
  final DateTime time;
  final String? notes;

  const CheckInParams({
    required this.employeeId,
    required this.time,
    this.notes,
  });

  @override
  List<Object?> get props => [employeeId, time, notes];
}
