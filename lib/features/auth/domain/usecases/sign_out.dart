import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/core/failures/auth_failure.dart';
import 'package:okoa_sem/features/auth/domain/repository/auth_repository.dart';

@injectable
class SignOut {
  final AuthRepository _repository;

  SignOut(this._repository);

  Future<Either<AuthFailure, Unit>> call() async {
    return await _repository.signOut();
  }
}