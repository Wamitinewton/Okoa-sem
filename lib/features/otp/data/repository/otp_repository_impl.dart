import 'package:dartz/dartz.dart';
import 'package:okoa_sem/core/enums/otp_enums.dart';
import 'package:okoa_sem/features/otp/domain/entities/otp.dart';
import 'package:okoa_sem/features/otp/domain/repositories/otp_repository.dart';

class OtpRepositoryImpl implements OtpRepository {

  final Map<String, Otp> _otpCache = {};

  @override
  Future<Either<OtpFailure, Otp?>> getCurrentOtp({required String email, required OtpType type}) 
  async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (_shouldSimulateSuccess()) {
        final otp = Otp(
           id: DateTime.now().millisecondsSinceEpoch.toString(),
          email: email,
          code: _generateMockCode(),
          type: type,
          expiresAt: DateTime.now().add(const Duration(minutes: 5)),
          createdAt: DateTime.now(),
        );

        _otpCache['${email}_${type.name}'] = otp;

        return Right(otp);
      } else {
        return Left(_getRandomFailure());
      }
    } catch (e) {
      return const Left(
        OtpFailure(
          message: 'Failed to send OTP',
          type: OtpFailureType.networkError,
          )
      );
    }
    
  }

  @override
  Future<Either<OtpFailure, Otp>> resendOtp({required String email, required OtpType type}) 
  async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final cachedOtp = _otpCache['${email}_${type.name}'];
      if (cachedOtp != null) {
        final timeSinceLastSent = DateTime.now().difference(cachedOtp.createdAt);
        if (timeSinceLastSent.inSeconds < 60) {
          return const Left(
            OtpFailure(
              message: 'Please wait 60 seconds before requesting again',
              type: OtpFailureType.rateLimitExceeded,
            ),
          );
        }
      
      }

      return await sendOtp(email: email, type: type);
    } catch (e) {
      return const Left(
        OtpFailure(
          message: 'Failed to resend OTP',
          type: OtpFailureType.networkError,
        ),
      );
    }
  }

 @override
  Future<Either<OtpFailure, Otp>> sendOtp({
    required String email,
    required OtpType type,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (_shouldSimulateSuccess()) {
        final otp = Otp(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          email: email,
          code: _generateMockCode(),
          type: type,
          expiresAt: DateTime.now().add(const Duration(minutes: 5)),
          createdAt: DateTime.now(),
        );

        _otpCache['${email}_${type.name}'] = otp;

        return Right(otp);
      } else {
        return Left(_getRandomFailure());
      }
    } catch (e) {
      return const Left(
        OtpFailure(
          message: 'Failed to send OTP',
          type: OtpFailureType.networkError,
        ),
      );
    }
  }

  @override
  Future<Either<OtpFailure, bool>> verifyOtp({
    required String email,
    required String code,
    required OtpType type,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final cachedOtp = _otpCache['${email}_${type.name}'];

      if (cachedOtp == null) {
        return const Left(
          OtpFailure(
            message: 'No OTP found for this email',
            type: OtpFailureType.invalidCode,
          ),
        );
      }

      if (cachedOtp.isExpired) {
        return const Left(
          OtpFailure(
            message: 'OTP has expired',
            type: OtpFailureType.expiredCode,
          ),
        );
      }

      if (cachedOtp.code == code) {
        // Mark as used
        _otpCache['${email}_${type.name}'] = cachedOtp.copyWith(isUsed: true);
        return const Right(true);
      } else {
        // Update attempts
        final updatedOtp = cachedOtp.copyWith(
          attemptsLeft: cachedOtp.attemptsLeft - 1,
        );
        _otpCache['${email}_${type.name}'] = updatedOtp;

        if (updatedOtp.attemptsLeft <= 0) {
          return const Left(
            OtpFailure(
              message: 'Too many failed attempts',
              type: OtpFailureType.tooManyAttempts,
            ),
          );
        }

        return const Left(
          OtpFailure(
            message: 'Invalid verification code',
            type: OtpFailureType.invalidCode,
          ),
        );
      }
    } catch (e) {
      return const Left(
        OtpFailure(
          message: 'Failed to verify OTP',
          type: OtpFailureType.networkError,
        ),
      );
    }
  }


  bool _shouldSimulateSuccess() {
    return DateTime.now().millisecond % 10 < 9;
  }

  String _generateMockCode() {
    final code = DateTime.now().millisecond.toString().padLeft(6, '0');
    return code.substring(0, 6);
  }

  OtpFailure _getRandomFailure() {
    final failures = [
        const OtpFailure(
        message: 'Network timeout',
        type: OtpFailureType.networkError,
      ),
      const OtpFailure(
        message: 'Server temporarily unavailable',
        type: OtpFailureType.serverError,
      ),
      const OtpFailure(
        message: 'Rate limit exceeded',
        type: OtpFailureType.rateLimitExceeded,
      ),
    ];

    return failures[DateTime.now().millisecond % failures.length];
  }
}