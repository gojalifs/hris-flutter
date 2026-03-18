import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:hris_flutter/features/auth/domain/entities/user_entity.dart';
import 'package:hris_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:hris_flutter/features/auth/domain/usecases/login_usecase.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  const tUser = UserEntity(
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    role: 'employee',
    employeeId: 'EMP001',
  );

  const tParams = LoginParams(
    email: 'john@example.com',
    password: 'password123',
  );

  test('should return UserEntity when login is successful', () async {
    when(mockAuthRepository.login(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => const Right(tUser));

    final result = await useCase(tParams);

    expect(result, const Right(tUser));
    verify(mockAuthRepository.login(
      email: tParams.email,
      password: tParams.password,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
