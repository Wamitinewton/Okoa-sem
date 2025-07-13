import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:okoa_sem/core/auth/auth_wrapper.dart';
import 'package:okoa_sem/core/router/route.dart';
import 'package:okoa_sem/di/injection_container.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_event.dart';
import 'package:okoa_sem/features/auth/presentation/pages/login_page.dart';
import 'package:okoa_sem/features/home/home_screen.dart';
import 'package:okoa_sem/features/onboarding/onboarding_page.dart';
import 'package:okoa_sem/splash.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.splash.path,
  routes: [
    GoRoute(
      path: AppRoute.splash.path,
      name: 'splash',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthBloc>()..add(const AuthEvent.checkAuthStatus()),
        child: const SplashScreen(),
      ),
    ),

    GoRoute(
      path: '/app',
      name: 'app',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthBloc>()..add(const AuthEvent.checkAuthStatus()),
        child: const AuthWrapper(),
      ),
    ),

    GoRoute(
      path: AppRoute.onboarding.path,
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),

    GoRoute(
      path: AppRoute.login.path,
      name: 'login',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthBloc>(),
        child: const LoginPage(),
      ),
    ),

    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Page not found',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'The page "${state.uri}" could not be found.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);