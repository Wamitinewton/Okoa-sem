import 'package:dartz/dartz.dart';
import 'package:okoa_sem/core/enums/otp_enums.dart';
import 'package:okoa_sem/features/otp/domain/entities/otp.dart';

import '../repositories/otp_repository.dart';

class ResendOtpUseCase {
  final OtpRepository repository;

  ResendOtpUseCase(this.repository);

  Future<Either<OtpFailure, Otp>> call({
    required String email,
    required OtpType type,
  }) async {
    if (email.isEmpty || !_isValidEmail(email)) {
      return const Left(
        OtpFailure(
          message: 'Please provide a valid email address',
          type: OtpFailureType.invalidEmail,
        ),
      );
    }

    return await repository.resendOtp(email: email, type: type);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
}