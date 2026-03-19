import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/error_handler.dart';
import '../../../../core/utils/date_formatter.dart';
import '../models/leave_model.dart';

abstract class LeaveRemoteDataSource {
  Future<List<LeaveModel>> getLeaves({
    required String employeeId,
    String? status,
  });

  Future<LeaveModel> applyLeave({
    required String employeeId,
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
  });

  Future<LeaveModel> approveLeave(String leaveId);

  Future<LeaveModel> rejectLeave({
    required String leaveId,
    required String notes,
  });
}

class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  final Dio dio;

  LeaveRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<LeaveModel>> getLeaves({
    required String employeeId,
    String? status,
  }) async {
    try {
      final response = await dio.get(
        ApiEndpoints.leavesByEmployee(employeeId),
        queryParameters: {
          if (status != null) 'status': status,
        },
      );
      final data = response.data['data'] as List<dynamic>;
      return data
          .map((e) => LeaveModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<LeaveModel> applyLeave({
    required String employeeId,
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.leaves,
        data: {
          'employee_id': employeeId,
          'leave_type': leaveType,
          'start_date': DateFormatter.toApi(startDate),
          'end_date': DateFormatter.toApi(endDate),
          'reason': reason,
        },
      );
      return LeaveModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<LeaveModel> approveLeave(String leaveId) async {
    try {
      final response =
          await dio.patch(ApiEndpoints.approveLeave(leaveId));
      return LeaveModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<LeaveModel> rejectLeave({
    required String leaveId,
    required String notes,
  }) async {
    try {
      final response = await dio.patch(
        ApiEndpoints.rejectLeave(leaveId),
        data: {'notes': notes},
      );
      return LeaveModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }
}
