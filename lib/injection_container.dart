import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/app_constants.dart';
import 'core/network/api_client.dart';
import 'core/network/network_info.dart';

// Auth
import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

// Employee
import 'features/employee/data/datasources/employee_remote_datasource.dart';
import 'features/employee/data/repositories/employee_repository_impl.dart';
import 'features/employee/domain/repositories/employee_repository.dart';
import 'features/employee/domain/usecases/get_employee_usecase.dart';
import 'features/employee/domain/usecases/get_employees_usecase.dart';
import 'features/employee/presentation/bloc/employee_bloc.dart';

// Attendance
import 'features/attendance/data/datasources/attendance_remote_datasource.dart';
import 'features/attendance/data/repositories/attendance_repository_impl.dart';
import 'features/attendance/domain/repositories/attendance_repository.dart';
import 'features/attendance/domain/usecases/check_in_usecase.dart';
import 'features/attendance/domain/usecases/check_out_usecase.dart';
import 'features/attendance/domain/usecases/get_attendances_usecase.dart';
import 'features/attendance/presentation/bloc/attendance_bloc.dart';

// Leave
import 'features/leave/data/datasources/leave_remote_datasource.dart';
import 'features/leave/data/repositories/leave_repository_impl.dart';
import 'features/leave/domain/repositories/leave_repository.dart';
import 'features/leave/domain/usecases/apply_leave_usecase.dart';
import 'features/leave/domain/usecases/get_leaves_usecase.dart';
import 'features/leave/presentation/bloc/leave_bloc.dart';

// Dashboard
import 'features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'features/dashboard/domain/repositories/dashboard_repository.dart';
import 'features/dashboard/domain/usecases/get_dashboard_summary_usecase.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ─── External ────────────────────────────────────────────────────────────
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // ─── Core ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  // Auth local datasource must be registered before ApiClient since the
  // client needs the stored token on startup.
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()),
  );

  final token = await sl<AuthLocalDataSource>().getToken() ?? '';
  sl.registerLazySingleton<ApiClient>(() => ApiClient(token: token));
  sl.registerLazySingleton<Dio>(() => sl<ApiClient>().dio);

  // ─── Auth ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl<Dio>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl<AuthRepository>()));
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getCachedUserUseCase: sl<GetCachedUserUseCase>(),
    ),
  );

  // ─── Employee ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(dio: sl<Dio>()),
  );
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      remoteDataSource: sl<EmployeeRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerLazySingleton(() => GetEmployeesUseCase(sl<EmployeeRepository>()));
  sl.registerLazySingleton(() => GetEmployeeUseCase(sl<EmployeeRepository>()));
  sl.registerFactory(
    () => EmployeeBloc(
      getEmployeesUseCase: sl<GetEmployeesUseCase>(),
      getEmployeeUseCase: sl<GetEmployeeUseCase>(),
    ),
  );

  // ─── Attendance ───────────────────────────────────────────────────────────
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(dio: sl<Dio>()),
  );
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(
      remoteDataSource: sl<AttendanceRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerLazySingleton(
    () => GetAttendancesUseCase(sl<AttendanceRepository>()),
  );
  sl.registerLazySingleton(() => CheckInUseCase(sl<AttendanceRepository>()));
  sl.registerLazySingleton(() => CheckOutUseCase(sl<AttendanceRepository>()));
  sl.registerFactory(
    () => AttendanceBloc(
      getAttendancesUseCase: sl<GetAttendancesUseCase>(),
      checkInUseCase: sl<CheckInUseCase>(),
      checkOutUseCase: sl<CheckOutUseCase>(),
    ),
  );

  // ─── Leave ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<LeaveRemoteDataSource>(
    () => LeaveRemoteDataSourceImpl(dio: sl<Dio>()),
  );
  sl.registerLazySingleton<LeaveRepository>(
    () => LeaveRepositoryImpl(
      remoteDataSource: sl<LeaveRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerLazySingleton(() => GetLeavesUseCase(sl<LeaveRepository>()));
  sl.registerLazySingleton(() => ApplyLeaveUseCase(sl<LeaveRepository>()));
  sl.registerFactory(
    () => LeaveBloc(
      getLeavesUseCase: sl<GetLeavesUseCase>(),
      applyLeaveUseCase: sl<ApplyLeaveUseCase>(),
    ),
  );

  // ─── Dashboard ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(dio: sl<Dio>()),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      remoteDataSource: sl<DashboardRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerLazySingleton(
    () => GetDashboardSummaryUseCase(sl<DashboardRepository>()),
  );
  sl.registerFactory(
    () => DashboardBloc(
      getDashboardSummaryUseCase: sl<GetDashboardSummaryUseCase>(),
    ),
  );
}
