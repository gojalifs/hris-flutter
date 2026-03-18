import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/attendance_entity.dart';

part 'attendance_model.g.dart';

@JsonSerializable()
class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required super.id,
    required super.employeeId,
    required super.date,
    super.checkIn,
    super.checkOut,
    required super.status,
    super.notes,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}
