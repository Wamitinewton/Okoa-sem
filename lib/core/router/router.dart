import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:okoa_sem/core/enums/otp_enums.dart';
import 'package:okoa_sem/core/router/route.dart';
import 'package:okoa_sem/di/injection_container.dart';
import 'package:okoa_sem/features/authentication/presentation/pages/login_page.dart';
import 'package:okoa_sem/features/authentication/presentation/pages/signup_page.dart';
import 'package:okoa_sem/features/onboarding/onboarding_page.dart';
import 'package:okoa_sem/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:okoa_sem/features/otp/presentation/pages/otp_verification_page.dart';
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
    ),

    GoRoute(
      path: AppRoute.otpVerification.path,
      name: 'otpVerification',
      builder: (context, state) {
        final email = state.uri.queryParameters['email'] ?? '';
        final typeString = state.uri.queryParameters['type'] ?? 'emailVerification';
        final title = state.uri.queryParameters['title'];
        final subtitle = state.uri.queryParameters['subtitle'];
        
        OtpType type = OtpType.emailVerification;
        switch (typeString) {
          case 'passwordReset':
            type = OtpType.passwordReset;
            break;
          case 'twoFactorAuth':
            type = OtpType.twoFactorAuth;
            break;
          default:
            type = OtpType.emailVerification;
        }

        return BlocProvider<OtpBloc>(
          create: (context) => getIt<OtpBloc>(),
          child: OtpVerificationPage(
            email: email,
            type: type,
            title: title,
            subtitle: subtitle,
          ),
        );
      },
    ),
      
      
]);