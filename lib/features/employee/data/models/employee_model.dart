import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/employee_entity.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.department,
    required super.position,
    super.avatar,
    required super.joinDate,
    required super.status,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

  factory EmployeeModel.fromEntity(EmployeeEntity entity) => EmployeeModel(
        id: entity.id,
        name: entity.name,
        email: entity.email,
        phone: entity.phone,
        department: entity.department,
        position: entity.position,
        avatar: entity.avatar,
        joinDate: entity.joinDate,
        status: entity.status,
      );
}
