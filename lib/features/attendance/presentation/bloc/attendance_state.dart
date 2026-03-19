import 'package:equatable/equatable.dart';
import '../../domain/entities/attendance_entity.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {
  const AttendanceInitial();
}

class AttendanceLoading extends AttendanceState {
  const AttendanceLoading();
}

class AttendancesLoaded extends AttendanceState {
  final List<AttendanceEntity> attendances;

  const AttendancesLoaded(this.attendances);

  @override
  List<Object> get props => [attendances];
}

class AttendanceActionSuccess extends AttendanceState {
  final AttendanceEntity attendance;
  final String message;

  const AttendanceActionSuccess({
    required this.attendance,
    required this.message,
  });

  @override
  List<Object> get props => [attendance, message];
}

class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError(this.message);

  @override
  List<Object> get props => [message];
}
