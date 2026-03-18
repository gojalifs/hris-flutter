import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/leave_entity.dart';

abstract class LeaveRepository {
  Future<Either<Failure, List<LeaveEntity>>> getLeaves({
    required String employeeId,
    String? status,
  });

  Future<Either<Failure, LeaveEntity>> applyLeave({
    required String employeeId,
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
  });

  Future<Either<Failure, LeaveEntity>> approveLeave(String leaveId);

  Future<Either<Failure, LeaveEntity>> rejectLeave({
    required String leaveId,
    required String notes,
  });
}
