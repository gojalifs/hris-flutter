class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String profile = '/auth/profile';

  // Employee
  static const String employees = '/employees';
  static String employeeById(String id) => '/employees/$id';

  // Attendance
  static const String attendance = '/attendance';
  static const String checkIn = '/attendance/check-in';
  static const String checkOut = '/attendance/check-out';
  static String attendanceByEmployee(String employeeId) =>
      '/attendance/employee/$employeeId';

  // Leave
  static const String leaves = '/leaves';
  static String leaveById(String id) => '/leaves/$id';
  static String leavesByEmployee(String employeeId) =>
      '/leaves/employee/$employeeId';
  static const String leaveTypes = '/leaves/types';
  static String approveLeave(String id) => '/leaves/$id/approve';
  static String rejectLeave(String id) => '/leaves/$id/reject';

  // Dashboard
  static const String dashboardSummary = '/dashboard/summary';
}
