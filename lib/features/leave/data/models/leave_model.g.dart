// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveModel _$LeaveModelFromJson(Map<String, dynamic> json) => LeaveModel(
      id: json['id'] as String,
      employeeId: json['employee_id'] as String,
      leaveType: json['leave_type'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      reason: json['reason'] as String,
      status: json['status'] as String,
      reviewNotes: json['review_notes'] as String?,
      reviewedAt: json['reviewed_at'] == null
          ? null
          : DateTime.parse(json['reviewed_at'] as String),
    );

Map<String, dynamic> _$LeaveModelToJson(LeaveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'leave_type': instance.leaveType,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'reason': instance.reason,
      'status': instance.status,
      'review_notes': instance.reviewNotes,
      'reviewed_at': instance.reviewedAt?.toIso8601String(),
    };
