import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class GetAttendancesEvent extends AttendanceEvent {
  final String employeeId;
  final DateTime? startDate;
  final DateTime? endDate;

  const GetAttendancesEvent({
    required this.employeeId,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [employeeId, startDate, endDate];
}

class CheckInEvent extends AttendanceEvent {
  final String employeeId;
  final DateTime time;
  final String? notes;

  const CheckInEvent({
    required this.employeeId,
    required this.time,
    this.notes,
  });

  @override
  List<Object?> get props => [employeeId, time, notes];
}

class CheckOutEvent extends AttendanceEvent {
  final String attendanceId;
  final DateTime time;
  final String? notes;

  const CheckOutEvent({
    required this.attendanceId,
    required this.time,
    this.notes,
  });

  @override
  List<Object?> get props => [attendanceId, time, notes];
}
