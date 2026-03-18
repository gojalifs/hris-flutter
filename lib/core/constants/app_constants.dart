class AppConstants {
  AppConstants._();

  // API
  static const String baseUrl = 'https://api.example.com/api/v1';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Storage Keys
  static const String tokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';

  // Pagination
  static const int defaultPageSize = 10;
  static const int defaultPage = 1;
}
