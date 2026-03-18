import 'package:equatable/equatable.dart';

class LeaveEntity extends Equatable {
  final String id;
  final String employeeId;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String status;
  final String? reviewNotes;
  final DateTime? reviewedAt;

  const LeaveEntity({
    required this.id,
    required this.employeeId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    this.reviewNotes,
    this.reviewedAt,
  });

  int get durationDays => endDate.difference(startDate).inDays + 1;

  @override
  List<Object?> get props => [
        id,
        employeeId,
        leaveType,
        startDate,
        endDate,
        reason,
        status,
        reviewNotes,
        reviewedAt,
      ];
}
