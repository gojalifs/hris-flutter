import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/error_handler.dart';
import '../../../../core/utils/date_formatter.dart';
import '../models/attendance_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<List<AttendanceModel>> getAttendances({
    required String employeeId,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<AttendanceModel> checkIn({
    required String employeeId,
    required DateTime time,
    String? notes,
  });

  Future<AttendanceModel> checkOut({
    required String attendanceId,
    required DateTime time,
    String? notes,
  });
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final Dio dio;

  AttendanceRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<AttendanceModel>> getAttendances({
    required String employeeId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final response = await dio.get(
        ApiEndpoints.attendanceByEmployee(employeeId),
        queryParameters: {
          if (startDate != null) 'start_date': DateFormatter.toApi(startDate),
          if (endDate != null) 'end_date': DateFormatter.toApi(endDate),
        },
      );
      final data = response.data['data'] as List<dynamic>;
      return data
          .map((e) => AttendanceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<AttendanceModel> checkIn({
    required String employeeId,
    required DateTime time,
    String? notes,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.checkIn,
        data: {
          'employee_id': employeeId,
          'time': time.toIso8601String(),
          if (notes != null) 'notes': notes,
        },
      );
      return AttendanceModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<AttendanceModel> checkOut({
    required String attendanceId,
    required DateTime time,
    String? notes,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.checkOut,
        data: {
          'attendance_id': attendanceId,
          'time': time.toIso8601String(),
          if (notes != null) 'notes': notes,
        },
      );
      return AttendanceModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }
}
