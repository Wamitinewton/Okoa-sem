import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:okoa_sem/core/router/route.dart';
import 'package:okoa_sem/features/authentication/di/auth_injection_container.dart';
import 'package:okoa_sem/features/authentication/presentation/pages/login_page.dart';
import 'package:okoa_sem/features/authentication/presentation/pages/signup_page.dart';
import 'package:okoa_sem/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:okoa_sem/features/onboarding/onboarding_page.dart';
import 'package:okoa_sem/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:okoa_sem/features/home/home_screen.dart';
import 'package:okoa_sem/splash.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.splash.path,
  routes: [
    GoRoute(
      path: AppRoute.splash.path,
      name: 'splash',
      builder: (context, state) => const SplashScreen()
    ),

    GoRoute(
      path: AppRoute.onboarding.path,
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),

    GoRoute(
      path: AppRoute.login.path,
      name: 'login',
      builder: (context, state) => BlocProvider<AuthBloc>(
        create: (context) => authGetIt<AuthBloc>(),
        child: const LoginPage(),
      ),
    ),

    GoRoute(
      path: AppRoute.signup.path,
      name: 'signup',
      builder: (context, state) => BlocProvider<AuthBloc>(
        create: (context) => authGetIt<AuthBloc>(),
        child: const SignupPage(),
      ),
    ),

    GoRoute(
      path: AppRoute.home.path,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: AppRoute.otpVerification.path,
      name: 'otpVerification',
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        final typeString = state.uri.queryParameters['type'] ?? 'phoneVerification';
        final title = state.uri.queryParameters['title'];
        final subtitle = state.uri.queryParameters['subtitle'];

        return BlocProvider<AuthBloc>(
          create: (context) => authGetIt<AuthBloc>(),
          child: OtpVerificationPage(
            phone: phone,
            type: typeString,
            title: title,
            subtitle: subtitle,
          ),
        );
      },
    ),
  ]
);