import 'package:equatable/equatable.dart';

class DashboardSummaryEntity extends Equatable {
  final int totalEmployees;
  final int presentToday;
  final int absentToday;
  final int pendingLeaves;
  final int totalLeaveThisMonth;

  const DashboardSummaryEntity({
    required this.totalEmployees,
    required this.presentToday,
    required this.absentToday,
    required this.pendingLeaves,
    required this.totalLeaveThisMonth,
  });

  @override
  List<Object> get props => [
        totalEmployees,
        presentToday,
        absentToday,
        pendingLeaves,
        totalLeaveThisMonth,
      ];
}
