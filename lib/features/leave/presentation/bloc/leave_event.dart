import 'package:equatable/equatable.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object?> get props => [];
}

class GetLeavesEvent extends LeaveEvent {
  final String employeeId;
  final String? status;

  const GetLeavesEvent({required this.employeeId, this.status});

  @override
  List<Object?> get props => [employeeId, status];
}

class ApplyLeaveEvent extends LeaveEvent {
  final String employeeId;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;

  const ApplyLeaveEvent({
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
