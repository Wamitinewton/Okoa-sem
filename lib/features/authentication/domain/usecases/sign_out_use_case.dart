import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@injectable
class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Either<AuthFailure, void>> call() async {
    return await _repository.signOut();
  }
}