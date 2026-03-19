import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/dashboard_summary_entity.dart';

part 'dashboard_summary_model.g.dart';

@JsonSerializable()
class DashboardSummaryModel extends DashboardSummaryEntity {
  const DashboardSummaryModel({
    required super.totalEmployees,
    required super.presentToday,
    required super.absentToday,
    required super.pendingLeaves,
    required super.totalLeaveThisMonth,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardSummaryModelToJson(this);
}
