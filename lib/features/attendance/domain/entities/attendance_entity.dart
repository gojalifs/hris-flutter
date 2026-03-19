import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final String id;
  final String employeeId;
  final DateTime date;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String status;
  final String? notes;

  const AttendanceEntity({
    required this.id,
    required this.employeeId,
    required this.date,
    this.checkIn,
    this.checkOut,
    required this.status,
    this.notes,
  });

  bool get isCheckedIn => checkIn != null && checkOut == null;

  @override
  List<Object?> get props =>
      [id, employeeId, date, checkIn, checkOut, status, notes];
}
