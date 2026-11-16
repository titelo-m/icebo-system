import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/landing/presentation/pages/landing_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';
import '../../features/employee/presentation/pages/employee_dashboard_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(),
          child: const SignupPage(),
        ),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardPage(),
      ),
      GoRoute(
        path: '/worker',
        builder: (context, state) => const EmployeeDashboardPage(),
      ),
    ],
  );
}