import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@injectable
class ResendOtpUseCase {
  final AuthRepository _repository;

  ResendOtpUseCase(this._repository);

  Future<Either<AuthFailure, void>> call({
    required String phoneNumber,
  }) async {
    return await _repository.resendOtp(
      phoneNumber: phoneNumber,
    );
  }
}