import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/domain/entities/auth_response.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@injectable
class SignInWithPasswordUseCase {
  final AuthRepository _repository;

  SignInWithPasswordUseCase(this._repository);

  Future<Either<AuthFailure, AuthResponse>> call({
    required String username,
    required String password,
  }) async {
    return await _repository.signInWithPassword(
      username: username,
      password: password,
    );
  }
}