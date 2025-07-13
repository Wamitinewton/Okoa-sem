import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_state.dart';
import 'package:okoa_sem/features/auth/presentation/pages/login_page.dart';
import 'package:okoa_sem/features/home/home_screen.dart';
import 'package:okoa_sem/features/onboarding/onboarding_page.dart';
import 'package:okoa_sem/shared/widgets/loading_screen.dart';
import 'package:okoa_sem/core/storage/app_storage.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.when(
          initial: () => const LoadingScreen(),
          loading: () => const LoadingScreen(),
          authenticated: (user) => const HomeScreen(),
          unauthenticated: () => _buildUnauthenticatedFlow(),
          error: (failure, user) {
            if (user != null) {
              return const HomeScreen();
            }
            return _buildUnauthenticatedFlow();
          },
          passwordResetSent: () => _buildUnauthenticatedFlow(),
          emailVerificationSent: () => _buildUnauthenticatedFlow(),
          userReloaded: (user) => const HomeScreen(),
          accountDeleted: () => _buildUnauthenticatedFlow(),
        );
      },
    );
  }

  Widget _buildUnauthenticatedFlow() {
    return FutureBuilder<bool>(
      future: AppStorage.isFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }
        
        final isFirstTime = snapshot.data ?? true;
        return isFirstTime ? const OnboardingPage() : const LoginPage();
      },
    );
  }
}

