import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@injectable
class SignInWithPhoneUseCase {
  final AuthRepository _repository;

  SignInWithPhoneUseCase(this._repository);

  Future<Either<AuthFailure, void>> call({
    required String phoneNumber,
  }) async {
    return await _repository.signInWithPhoneOtp(
      phoneNumber: phoneNumber,
    );
  }
}