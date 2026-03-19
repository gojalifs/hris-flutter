import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/leave_entity.dart';
import '../repositories/leave_repository.dart';

class ApplyLeaveUseCase extends UseCase<LeaveEntity, ApplyLeaveParams> {
  final LeaveRepository repository;

  ApplyLeaveUseCase(this.repository);

  @override
  Future<Either<Failure, LeaveEntity>> call(ApplyLeaveParams params) {
    return repository.applyLeave(
      employeeId: params.employeeId,
      leaveType: params.leaveType,
      startDate: params.startDate,
      endDate: params.endDate,
      reason: params.reason,
    );
  }
}

class ApplyLeaveParams extends Equatable {
  final String employeeId;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;

  const ApplyLeaveParams({
    required this.employeeId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
  });

  @override
  List<Object> get props =>
      [employeeId, leaveType, startDate, endDate, reason];
}
