import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/di/injection_container.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_event.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_state.dart';
import 'package:okoa_sem/features/home/home_screen.dart';
import 'package:okoa_sem/features/onboarding/onboarding_page.dart';
import 'package:okoa_sem/shared/widgets/universal_background.dart';
import 'package:okoa_sem/splash.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(const AuthEvent.checkAuthStatus()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SplashScreen(),
            loading: () => const _LoadingScreen(),
            authenticated: (user) => const HomeScreen(),
            unauthenticated: () => const OnboardingPage(),
            error: (failure, user) {
              if (user != null) {
                return const HomeScreen();
              }
              return const OnboardingPage();
            },
            passwordResetSent: () => const OnboardingPage(),
            emailVerificationSent: () => const OnboardingPage(),
            userReloaded: (user) => const HomeScreen(),
            accountDeleted: () => const OnboardingPage(),
          );
        },
      ),
    );
  }
}

class _LoadingScreen extends StatefulWidget {
  const _LoadingScreen();

  @override
  State<_LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<_LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UniversalBackground(animation: _controller),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: context.sizing.size(80),
                  height: context.sizing.size(80),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(context.sizing.radiusXL),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: context.sizing.size(15),
                        spreadRadius: context.sizing.size(2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.school,
                    size: context.sizing.size(40),
                    color: AppColors.onPrimary,
                  ),
                ),
                
                SizedBox(height: context.sizing.xl),
                
                SizedBox(
                  width: context.sizing.size(30),
                  height: context.sizing.size(30),
                  child: CircularProgressIndicator(
                    strokeWidth: context.sizing.size(3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
                
                SizedBox(height: context.sizing.l),
                
                Text(
                  'Checking authentication...',
                  style: context.typography.bodyM.copyWith(
                    color: context.colors.surfaceAlpha(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}