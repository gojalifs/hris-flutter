import 'package:flutter_test/flutter_test.dart';

import 'package:hris_flutter/features/auth/data/models/user_model.dart';
import 'package:hris_flutter/features/auth/domain/entities/user_entity.dart';

void main() {
  const tUserModel = UserModel(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    role: 'employee',
    avatar: null,
    employeeId: 'EMP001',
  );

  const tUserEntity = UserEntity(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    role: 'employee',
    avatar: null,
    employeeId: 'EMP001',
  );

  final tJson = {
    'id': '1',
    'name': 'John Doe',
    'email': 'john@example.com',
    'role': 'employee',
    'avatar': null,
    'employee_id': 'EMP001',
  };

  group('UserModel', () {
    test('should be a subtype of UserEntity', () {
      expect(tUserModel, isA<UserEntity>());
    });

    test('should deserialize from JSON correctly', () {
      final result = UserModel.fromJson(tJson);
      expect(result, tUserModel);
    });

    test('should serialize to JSON correctly', () {
      final result = tUserModel.toJson();
      expect(result, tJson);
    });

    test('fromEntity should create correct model', () {
      final result = UserModel.fromEntity(tUserEntity);
      expect(result, tUserModel);
    });
  });
}
