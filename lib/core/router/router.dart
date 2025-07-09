import 'package:go_router/go_router.dart';
import 'package:okoa_sem/core/router/route.dart';
import 'package:okoa_sem/features/authentication/presentation/pages/login_page.dart';
import 'package:okoa_sem/features/authentication/presentation/pages/signup_page.dart';
import 'package:okoa_sem/features/onboarding/onboarding_page.dart';
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
      builder: (context, state) => const LoginPage()
    ),

    GoRoute(
      path: AppRoute.signup.path,
      name: 'signup',
      builder: (context, state) => const SignupPage()
    ),

     GoRoute(
      path: AppRoute.home.path,
      name: 'home',
      builder: (context, state) => const SignupPage()
    )
      
      
]);