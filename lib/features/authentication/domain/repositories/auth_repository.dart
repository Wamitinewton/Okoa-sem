import 'package:dartz/dartz.dart';
import 'package:okoa_sem/features/authentication/domain/entities/auth_response.dart';
import 'package:okoa_sem/features/authentication/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, void>> signUpWithPhone({
    required String phoneNumber,
    required String username,
    required String password,
  });

  Future<Either<AuthFailure, AuthResponse>> verifyPhoneOtp({
    required String phoneNumber,
    required String otp,
  });

  Future<Either<AuthFailure, void>> signInWithPhoneOtp({
    required String phoneNumber,
  });

  Future<Either<AuthFailure, AuthResponse>> signInWithPassword({
    required String username,
    required String password,
  });

  Future<Either<AuthFailure, void>> resendOtp({
    required String phoneNumber,
  });

  Future<Either<AuthFailure, void>> signOut();

  Future<Either<AuthFailure, AuthResponse?>> getCurrentSession();

  Future<Either<AuthFailure, AuthResponse>> refreshSession({
    required String refreshToken,
  });

  Future<Either<AuthFailure, User>> updateProfile({
    String? username,
    String? profileImage,
  });

  Future<Either<AuthFailure, bool>> isUsernameAvailable(String username);
}

class AuthFailure {
  final String message;
  final AuthFailureType type;

  const AuthFailure({
    required this.message,
    required this.type,
  });

  @override
  String toString() => message;
}

enum AuthFailureType {
  networkError,
  serverError,
  invalidCredentials,
  userNotFound,
  userAlreadyExists,
  invalidPhoneNumber,
  invalidOtp,
  otpExpired,
  weakPassword,
  usernameNotAvailable,
  sessionExpired,
  unknown,
}

extension AuthFailureTypeExtension on AuthFailureType {
  String get defaultMessage {
    switch (this) {
      case AuthFailureType.networkError:
        return 'Network connection error. Please check your internet connection.';
      case AuthFailureType.serverError:
        return 'Server error occurred. Please try again later.';
      case AuthFailureType.invalidCredentials:
        return 'Invalid credentials. Please check your username and password.';
      case AuthFailureType.userNotFound:
        return 'User not found. Please check your credentials.';
      case AuthFailureType.userAlreadyExists:
        return 'An account with this phone number already exists.';
      case AuthFailureType.invalidPhoneNumber:
        return 'Invalid phone number format.';
      case AuthFailureType.invalidOtp:
        return 'Invalid verification code. Please check and try again.';
      case AuthFailureType.otpExpired:
        return 'Verification code has expired. Please request a new one.';
      case AuthFailureType.weakPassword:
        return 'Password is too weak. Please choose a stronger password.';
      case AuthFailureType.usernameNotAvailable:
        return 'Username is already taken. Please choose another one.';
      case AuthFailureType.sessionExpired:
        return 'Your session has expired. Please sign in again.';
      case AuthFailureType.unknown:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}