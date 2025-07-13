import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/core/failures/auth_failure.dart';
import 'package:okoa_sem/features/auth/domain/entities/user_entity.dart';
import 'package:okoa_sem/features/auth/domain/repository/auth_repository.dart';

@injectable
class SignInWithEmail {
  final AuthRepository _repository;

  SignInWithEmail(this._repository);

  Future<Either<AuthFailure, UserEntity>> call(SignInWithEmailParams params) async {
    return await _repository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInWithEmailParams extends Equatable {
  final String email;
  final String password;

  const SignInWithEmailParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}