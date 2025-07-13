import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/core/failures/auth_failure.dart';
import 'package:okoa_sem/features/auth/domain/entities/user_entity.dart';
import 'package:okoa_sem/features/auth/domain/repository/auth_repository.dart';

@injectable
class RegisterWithEmail {
  final AuthRepository _repository;

  RegisterWithEmail(this._repository);

  Future<Either<AuthFailure, UserEntity>> call(RegisterWithEmailParams params) async {
    return await _repository.registerWithEmailAndPassword(
      email: params.email,
      password: params.password,
      displayName: params.displayName,
    );
  }
}

class RegisterWithEmailParams extends Equatable {
  final String email;
  final String password;
  final String displayName;

  const RegisterWithEmailParams({
    required this.email,
    required this.password,
    required this.displayName,
  });

  @override
  List<Object> get props => [email, password, displayName];
}