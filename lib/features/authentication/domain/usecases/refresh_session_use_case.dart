import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/domain/entities/auth_response.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@injectable
class RefreshSessionUseCase {
  final AuthRepository _repository;

  RefreshSessionUseCase(this._repository);

  Future<Either<AuthFailure, AuthResponse>> call({
    required String refreshToken,
  }) async {
    return await _repository.refreshSession(
      refreshToken: refreshToken,
    );
  }
}