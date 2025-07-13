import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:okoa_sem/core/failures/auth_failure.dart';
import 'package:okoa_sem/features/auth/domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  
  const factory AuthState.loading() = _Loading;
  
  const factory AuthState.authenticated({
    required UserEntity user,
  }) = _Authenticated;
  
  const factory AuthState.unauthenticated() = _Unauthenticated;
  
  const factory AuthState.error({
    required AuthFailure failure,
    UserEntity? user,
  }) = _Error;
  
  // Specific success states for actions
  const factory AuthState.passwordResetSent() = _PasswordResetSent;
  
  const factory AuthState.emailVerificationSent() = _EmailVerificationSent;
  
  const factory AuthState.userReloaded({
    required UserEntity user,
  }) = _UserReloaded;
  
  const factory AuthState.accountDeleted() = _AccountDeleted;
}

extension AuthStateExtension on AuthState {
  bool get isLoading => this is _Loading;
  
  bool get isAuthenticated => this is _Authenticated;
  
  bool get isUnauthenticated => this is _Unauthenticated;
  
  bool get hasError => this is _Error;
  
  UserEntity? get user => maybeWhen(
        authenticated: (user) => user,
        error: (failure, user) => user,
        userReloaded: (user) => user,
        orElse: () => null,
      );
  
  AuthFailure? get failure => maybeWhen(
        error: (failure, user) => failure,
        orElse: () => null,
      );
}