// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      department: json['department'] as String,
      position: json['position'] as String,
      avatar: json['avatar'] as String?,
      joinDate: DateTime.parse(json['join_date'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'department': instance.department,
      'position': instance.position,
      'avatar': instance.avatar,
      'join_date': instance.joinDate.toIso8601String(),
      'status': instance.status,
    };
