import 'package:equatable/equatable.dart';
import 'package:okoa_sem/features/authentication/domain/entities/user.dart';

enum AuthStatus { 
  initial, 
  loading, 
  authenticated, 
  unauthenticated, 
  error,
  otpSent,
  verifying,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;
  final String? phoneNumber;
  final String? accessToken;
  final String? refreshToken;
  final bool? usernameAvailable;
  final String? usernameError;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.phoneNumber,
    this.accessToken,
    this.refreshToken,
    this.usernameAvailable,
    this.usernameError,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated && user != null;
  
  bool get isLoading => status == AuthStatus.loading || status == AuthStatus.verifying;
  
  bool get hasError => status == AuthStatus.error && errorMessage != null;
  
  bool get otpSent => status == AuthStatus.otpSent;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
    String? phoneNumber,
    String? accessToken,
    String? refreshToken,
    bool? usernameAvailable,
    String? usernameError,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      usernameAvailable: usernameAvailable ?? this.usernameAvailable,
      usernameError: usernameError,
    );
  }

  AuthState clearError() {
    return copyWith(errorMessage: null, usernameError: null);
  }

  @override
  List<Object?> get props => [
    status, 
    user, 
    errorMessage, 
    phoneNumber,
    accessToken,
    refreshToken,
    usernameAvailable,
    usernameError,
  ];
}