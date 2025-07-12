import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@injectable
class CheckUsernameAvailabilityUseCase {
  final AuthRepository _repository;

  CheckUsernameAvailabilityUseCase(this._repository);

  Future<Either<AuthFailure, bool>> call({
    required String username,
  }) async {
    return await _repository.isUsernameAvailable(username);
  }
}