import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/otp_enums.dart';
import '../entities/otp.dart';

abstract class OtpRepository{

  Future<Either<OtpFailure, Otp>> sendOtp({
    required String email,
    required OtpType type,
  });

  Future<Either<OtpFailure, bool>> verifyOtp({
    required String email,
    required String code,
    required OtpType type,
  });

  Future<Either<OtpFailure, Otp>> resendOtp({
    required String email,
    required OtpType type,
  });

   Future<Either<OtpFailure, Otp?>> getCurrentOtp({
    required String email,
    required OtpType type,
  });
}


class OtpFailure extends Equatable {
  final String message;
  final OtpFailureType type;

  const OtpFailure({
    required this.message,
    required this.type,
  });

  @override
  List<Object?> get props => [message, type];
}

enum OtpFailureType {
  networkError,
  serverError,
  invalidEmail,
  invalidCode,
  expiredCode,
  tooManyAttempts,
  rateLimitExceeded,
  unknown,
}

extension OtpFailureTypeExtension on OtpFailureType {
  String get defaultMessage {
    switch (this) {
      case OtpFailureType.networkError:
        return 'Network connection error. Please check your internet connection.';
      case OtpFailureType.serverError:
        return 'Server error occurred. Please try again later.';
      case OtpFailureType.invalidEmail:
        return 'Invalid email address provided.';
      case OtpFailureType.invalidCode:
        return 'Invalid verification code. Please check and try again.';
      case OtpFailureType.expiredCode:
        return 'Verification code has expired. Please request a new one.';
      case OtpFailureType.tooManyAttempts:
        return 'Too many failed attempts. Please request a new code.';
      case OtpFailureType.rateLimitExceeded:
        return 'Too many requests. Please wait before requesting again.';
      case OtpFailureType.unknown:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}