import 'package:flutter_test/flutter_test.dart';

import 'package:hris_flutter/features/leave/domain/entities/leave_entity.dart';
import 'package:hris_flutter/features/leave/data/models/leave_model.dart';

void main() {
  final tLeaveModel = LeaveModel(
    id: 'leave_1',
    employeeId: 'EMP001',
    leaveType: 'Annual Leave',
    startDate: DateTime(2024, 1, 15),
    endDate: DateTime(2024, 1, 17),
    reason: 'Family vacation',
    status: 'pending',
  );

  group('LeaveModel', () {
    test('should be a subtype of LeaveEntity', () {
      expect(tLeaveModel, isA<LeaveEntity>());
    });

    test('durationDays should return correct number of days', () {
      expect(tLeaveModel.durationDays, 3);
    });

    test('should serialize and deserialize correctly', () {
      final json = tLeaveModel.toJson();
      final result = LeaveModel.fromJson(json);
      expect(result, tLeaveModel);
    });
  });
}
