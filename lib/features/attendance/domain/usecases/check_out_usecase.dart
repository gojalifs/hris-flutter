import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class CheckOutUseCase extends UseCase<AttendanceEntity, CheckOutParams> {
  final AttendanceRepository repository;

  CheckOutUseCase(this.repository);

  @override
  Future<Either<Failure, AttendanceEntity>> call(CheckOutParams params) {
    return repository.checkOut(
      attendanceId: params.attendanceId,
      time: params.time,
      notes: params.notes,
    );
  }
}

class CheckOutParams extends Equatable {
  final String attendanceId;
  final DateTime time;
  final String? notes;

  const CheckOutParams({
    required this.attendanceId,
    required this.time,
    this.notes,
  });

  @override
  List<Object?> get props => [attendanceId, time, notes];
}
