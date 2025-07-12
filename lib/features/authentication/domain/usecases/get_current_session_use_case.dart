import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/domain/entities/auth_response.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@injectable
class GetCurrentSessionUseCase {
  final AuthRepository _repository;

  GetCurrentSessionUseCase(this._repository);

  Future<Either<AuthFailure, AuthResponse?>> call() async {
    return await _repository.getCurrentSession();
  }
}