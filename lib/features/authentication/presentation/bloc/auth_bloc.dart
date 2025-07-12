import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okoa_sem/features/authentication/domain/entities/user.dart';
import 'package:okoa_sem/features/authentication/presentation/bloc/auth_event.dart';
import 'package:okoa_sem/features/authentication/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthStatusChecked>(_onAuthStatusChecked);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final user = User(
        id: '1',
        username: 'demo_user',
        phoneNumber: event.emailOrUsername.contains('@')
            ? event.emailOrUsername
            : 'demo@example.com',
        createdAt: DateTime.now(),
      );

      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Login Failed. Please try again',
        ),
      );
    }
  }

  Future<void> _onSignupRequested(
    SignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final user = User(
        id: '1',
        username: event.username,
        phoneNumber: event.email,
        createdAt: DateTime.now(),
      );

      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Signup failed. Please try again.',
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      emit(const AuthState(status: AuthStatus.unauthenticated));
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Logout failed. Please try again.',
        ),
      );
    }
  }

  Future<void> _onAuthStatusChecked(
    AuthStatusChecked event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      emit(const AuthState(status: AuthStatus.unauthenticated));
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Failed to check authentication status.',
        ),
      );
    }
  }
}
