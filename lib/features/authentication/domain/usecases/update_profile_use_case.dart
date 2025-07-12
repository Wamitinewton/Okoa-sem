import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/domain/entities/user.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@injectable
class UpdateProfileUseCase {
  final AuthRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<Either<AuthFailure, User>> call({
    String? username,
    String? profileImage,
  }) async {
    return await _repository.updateProfile(
      username: username,
      profileImage: profileImage,
    );
  }
}