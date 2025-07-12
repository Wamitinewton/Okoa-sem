import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/domain/entities/auth_response.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@injectable
class VerifyPhoneUseCase {
  final AuthRepository _repository;

  VerifyPhoneUseCase(this._repository);

  Future<Either<AuthFailure, AuthResponse>> call({
    required String phoneNumber,
    required String otp,
  }) async {
    return await _repository.verifyPhoneOtp(
      phoneNumber: phoneNumber,
      otp: otp,
    );
  }
}