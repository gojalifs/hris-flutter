import 'package:dio/dio.dart';
import '../errors/exceptions.dart';

class ErrorHandler {
  ErrorHandler._();

  static ServerException handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerException(message: 'Connection timed out');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        final message = _extractMessage(data) ?? 'Server error occurred';
        return ServerException(message: message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const ServerException(message: 'Request was cancelled');
      case DioExceptionType.connectionError:
        return const ServerException(message: 'No internet connection');
      case DioExceptionType.unknown:
      default:
        return ServerException(
          message: e.message ?? 'An unknown error occurred',
        );
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ??
          data['error'] as String? ??
          data['msg'] as String?;
    }
    return null;
  }
}
