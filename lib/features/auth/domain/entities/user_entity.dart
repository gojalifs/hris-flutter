import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? avatar;
  final String employeeId;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatar,
    required this.employeeId,
  });

  @override
  List<Object?> get props => [id, name, email, role, avatar, employeeId];
}
