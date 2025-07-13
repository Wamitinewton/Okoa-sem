import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/core/failures/auth_failure.dart';
import 'package:okoa_sem/features/auth/domain/repository/auth_repository.dart';

@injectable
class SendPasswordReset {
  final AuthRepository _repository;

  SendPasswordReset(this._repository);

  Future<Either<AuthFailure, Unit>> call(SendPasswordResetParams params) async {
    return await _repository.sendPasswordResetEmail(email: params.email);
  }
}

class SendPasswordResetParams extends Equatable {
  final String email;

  const SendPasswordResetParams({required this.email});

  @override
  List<Object> get props => [email];
}