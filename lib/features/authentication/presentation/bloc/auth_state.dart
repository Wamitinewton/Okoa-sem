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
  otpExpired,
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
  
  final String otpCode;
  final int remainingSeconds;
  final bool canResendOtp;
  final int attemptsLeft;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.phoneNumber,
    this.accessToken,
    this.refreshToken,
    this.usernameAvailable,
    this.usernameError,
    this.otpCode = '',
    this.remainingSeconds = 0,
    this.canResendOtp = false,
    this.attemptsLeft = 3,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated && user != null;
  
  bool get isLoading => status == AuthStatus.loading || status == AuthStatus.verifying;
  
  bool get hasError => status == AuthStatus.error && errorMessage != null;
  
  bool get otpSent => status == AuthStatus.otpSent;
  
  bool get isOtpComplete => otpCode.length == 6;
  
  bool get isTimerActive => remainingSeconds > 0;
  
  bool get canVerifyOtp => isOtpComplete && 
                          status != AuthStatus.verifying && 
                          attemptsLeft > 0;
  
  bool get canRequestResend => canResendOtp && 
                              status != AuthStatus.loading && 
                              !isTimerActive;

  String get formattedTimeRemaining {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
    String? phoneNumber,
    String? accessToken,
    String? refreshToken,
    bool? usernameAvailable,
    String? usernameError,
    String? otpCode,
    int? remainingSeconds,
    bool? canResendOtp,
    int? attemptsLeft,
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
      otpCode: otpCode ?? this.otpCode,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      canResendOtp: canResendOtp ?? this.canResendOtp,
      attemptsLeft: attemptsLeft ?? this.attemptsLeft,
    );
  }

  AuthState clearError() {
    return copyWith(errorMessage: null, usernameError: null);
  }

  AuthState clearOtp() {
    return copyWith(
      otpCode: '',
      remainingSeconds: 0,
      canResendOtp: false,
      attemptsLeft: 3,
      status: status == AuthStatus.otpSent || status == AuthStatus.verifying ? AuthStatus.initial : status,
    );
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
    otpCode,
    remainingSeconds,
    canResendOtp,
    attemptsLeft,
  ];
}