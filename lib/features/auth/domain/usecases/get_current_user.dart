import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/auth/domain/entities/user_entity.dart';
import 'package:okoa_sem/features/auth/domain/repository/auth_repository.dart';

@injectable
class GetCurrentUser {
  final AuthRepository _repository;

  GetCurrentUser(this._repository);

  Future<UserEntity?> call() async {
    return await _repository.getCurrentUser();
  }
}

@injectable
class GetAuthStateChanges {
  final AuthRepository _repository;

  GetAuthStateChanges(this._repository);

  Stream<UserEntity?> call() {
    return _repository.authStateChanges;
  }
}