import 'package:dartz/dartz.dart';

import '../../../../core/enums/otp_enums.dart';
import '../repositories/otp_repository.dart';

class VerifyOtpUseCase {
  final OtpRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<OtpFailure, bool>> call({
    required String email,
    required String code,
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

    if (code.isEmpty || code.length != 6 || !_isValidCode(code)) {
      return const Left(
        OtpFailure(
          message: 'Please enter a valid 6-digit code',
          type: OtpFailureType.invalidCode,
        ),
      );
    }

    return await repository.verifyOtp(
      email: email,
      code: code,
      type: type,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  bool _isValidCode(String code) {
    return RegExp(r'^\d{6}$').hasMatch(code);
  }
}