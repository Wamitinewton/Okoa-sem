import 'package:go_router/go_router.dart';
import 'package:okoa_sem/core/router/route.dart';
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
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: AppRoute.onboarding.path,
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),

    GoRoute(
      path: AppRoute.login.path,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);