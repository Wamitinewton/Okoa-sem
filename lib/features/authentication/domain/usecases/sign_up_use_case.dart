import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<AuthFailure, void>> call({
    required String phoneNumber,
    required String username,
    required String password,
  }) async {
    return await _repository.signUpWithPhone(
      phoneNumber: phoneNumber,
      username: username,
      password: password,
    );
  }
}