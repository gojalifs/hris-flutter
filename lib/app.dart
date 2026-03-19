import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/attendance/presentation/bloc/attendance_bloc.dart';
import 'features/attendance/presentation/pages/attendance_page.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/employee/presentation/bloc/employee_bloc.dart';
import 'features/employee/presentation/pages/employee_list_page.dart';
import 'features/leave/presentation/bloc/leave_bloc.dart';
import 'features/leave/presentation/pages/leave_page.dart';
import 'injection_container.dart' as di;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          di.sl<AuthBloc>()..add(const CheckAuthStatusEvent()),
      child: MaterialApp.router(
        title: 'HRIS',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: _buildRouter(),
      ),
    );
  }

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => BlocProvider(
            create: (_) => di.sl<DashboardBloc>(),
            child: const DashboardPage(),
          ),
        ),
        GoRoute(
          path: '/employees',
          builder: (context, state) => BlocProvider(
            create: (_) => di.sl<EmployeeBloc>(),
            child: const EmployeeListPage(),
          ),
        ),
        GoRoute(
          path: '/attendance/:employeeId',
          builder: (context, state) {
            final employeeId = state.pathParameters['employeeId']!;
            return BlocProvider(
              create: (_) => di.sl<AttendanceBloc>(),
              child: AttendancePage(employeeId: employeeId),
            );
          },
        ),
        GoRoute(
          path: '/leave/:employeeId',
          builder: (context, state) {
            final employeeId = state.pathParameters['employeeId']!;
            return BlocProvider(
              create: (_) => di.sl<LeaveBloc>(),
              child: LeavePage(employeeId: employeeId),
            );
          },
        ),
      ],
    );
  }
}
