import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/leave_entity.dart';

part 'leave_model.g.dart';

@JsonSerializable()
class LeaveModel extends LeaveEntity {
  const LeaveModel({
    required super.id,
    required super.employeeId,
    required super.leaveType,
    required super.startDate,
    required super.endDate,
    required super.reason,
    required super.status,
    super.reviewNotes,
    super.reviewedAt,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveModelToJson(this);
}
