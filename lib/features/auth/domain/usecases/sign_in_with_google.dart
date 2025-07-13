import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/core/failures/auth_failure.dart';
import 'package:okoa_sem/features/auth/domain/entities/user_entity.dart';
import 'package:okoa_sem/features/auth/domain/repository/auth_repository.dart';

@injectable
class SignInWithGoogle {
  final AuthRepository _repository;

  SignInWithGoogle(this._repository);

  Future<Either<AuthFailure, UserEntity>> call() async {
    return await _repository.signInWithGoogle();
  }
}