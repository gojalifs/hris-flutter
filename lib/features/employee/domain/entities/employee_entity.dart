import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String position;
  final String? avatar;
  final DateTime joinDate;
  final String status;

  const EmployeeEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.position,
    this.avatar,
    required this.joinDate,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        department,
        position,
        avatar,
        joinDate,
        status,
      ];
}
