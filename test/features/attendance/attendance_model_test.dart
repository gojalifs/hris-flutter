import 'package:flutter_test/flutter_test.dart';

import 'package:hris_flutter/features/attendance/data/models/attendance_model.dart';
import 'package:hris_flutter/features/attendance/domain/entities/attendance_entity.dart';

void main() {
  final tAttendanceModel = AttendanceModel(
    id: 'att_1',
    employeeId: 'EMP001',
    date: DateTime(2024, 1, 15),
    checkIn: DateTime(2024, 1, 15, 8, 0),
    checkOut: DateTime(2024, 1, 15, 17, 0),
    status: 'present',
  );

  group('AttendanceModel', () {
    test('should be a subtype of AttendanceEntity', () {
      expect(tAttendanceModel, isA<AttendanceEntity>());
    });

    test('isCheckedIn should return false when checkOut is set', () {
      expect(tAttendanceModel.isCheckedIn, false);
    });

    test('isCheckedIn should return true when checkOut is null', () {
      final model = AttendanceModel(
        id: 'att_2',
        employeeId: 'EMP001',
        date: DateTime(2024, 1, 15),
        checkIn: DateTime(2024, 1, 15, 8, 0),
        status: 'present',
      );
      expect(model.isCheckedIn, true);
    });

    test('should serialize and deserialize correctly', () {
      final json = tAttendanceModel.toJson();
      final result = AttendanceModel.fromJson(json);
      expect(result, tAttendanceModel);
    });
  });
}
