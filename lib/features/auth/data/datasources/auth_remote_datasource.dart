import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/error_handler.dart';
import '../models/login_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<UserModel> getProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      return LoginResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post(ApiEndpoints.logout);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await dio.get(ApiEndpoints.profile);
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }
}
