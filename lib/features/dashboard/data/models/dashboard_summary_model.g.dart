// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardSummaryModel _$DashboardSummaryModelFromJson(
        Map<String, dynamic> json) =>
    DashboardSummaryModel(
      totalEmployees: (json['total_employees'] as num).toInt(),
      presentToday: (json['present_today'] as num).toInt(),
      absentToday: (json['absent_today'] as num).toInt(),
      pendingLeaves: (json['pending_leaves'] as num).toInt(),
      totalLeaveThisMonth: (json['total_leave_this_month'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardSummaryModelToJson(
        DashboardSummaryModel instance) =>
    <String, dynamic>{
      'total_employees': instance.totalEmployees,
      'present_today': instance.presentToday,
      'absent_today': instance.absentToday,
      'pending_leaves': instance.pendingLeaves,
      'total_leave_this_month': instance.totalLeaveThisMonth,
    };
