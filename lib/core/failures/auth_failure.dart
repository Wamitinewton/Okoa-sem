import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.serverError([String? message]) = _ServerError;
  const factory AuthFailure.networkError() = _NetworkError;
  const factory AuthFailure.cancelled() = _Cancelled;
  const factory AuthFailure.userDisabled() = _UserDisabled;
  const factory AuthFailure.userNotFound() = _UserNotFound;
  const factory AuthFailure.wrongPassword() = _WrongPassword;
  const factory AuthFailure.invalidEmail() = _InvalidEmail;
  const factory AuthFailure.emailAlreadyInUse() = _EmailAlreadyInUse;
  const factory AuthFailure.weakPassword() = _WeakPassword;
  const factory AuthFailure.tooManyRequests() = _TooManyRequests;
  const factory AuthFailure.operationNotAllowed() = _OperationNotAllowed;
  const factory AuthFailure.accountExistsWithDifferentCredential() = _AccountExistsWithDifferentCredential;
  const factory AuthFailure.invalidCredential() = _InvalidCredential;
  const factory AuthFailure.unknownError([String? message]) = _UnknownError;
}

extension AuthFailureExtension on AuthFailure {
  String get message {
    return when(
      serverError: (message) => message ?? 'A server error occurred. Please try again.',
      networkError: () => 'No internet connection. Please check your network.',
      cancelled: () => 'Sign in was cancelled.',
      userDisabled: () => 'This account has been disabled. Please contact support.',
      userNotFound: () => 'No account found with this email address.',
      wrongPassword: () => 'Incorrect password. Please try again.',
      invalidEmail: () => 'Please enter a valid email address.',
      emailAlreadyInUse: () => 'An account already exists with this email address.',
      weakPassword: () => 'Password is too weak. Please choose a stronger password.',
      tooManyRequests: () => 'Too many failed attempts. Please try again later.',
      operationNotAllowed: () => 'This sign-in method is not allowed.',
      accountExistsWithDifferentCredential: () => 'An account already exists with this email but different sign-in method.',
      invalidCredential: () => 'The provided credentials are invalid.',
      unknownError: (message) => message ?? 'An unknown error occurred. Please try again.',
    );
  }

  bool get isNetworkError => this is _NetworkError;
  bool get isCancelled => this is _Cancelled;
  bool get isServerError => this is _ServerError;
}