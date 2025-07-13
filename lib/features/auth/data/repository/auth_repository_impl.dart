import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/core/failures/auth_failure.dart';
import 'package:okoa_sem/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:okoa_sem/features/auth/data/utils/auth_exception_handler.dart';
import 'package:okoa_sem/features/auth/domain/entities/user_entity.dart';
import 'package:okoa_sem/features/auth/domain/repository/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final userModel = await _remoteDataSource.getCurrentUser();
      return userModel?.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signInWithGoogle() async {
    try {
      final userModel = await _remoteDataSource.signInWithGoogle();
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final userModel = await _remoteDataSource.registerWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _remoteDataSource.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendEmailVerification() async {
    try {
      await _remoteDataSource.sendEmailVerification();
      return const Right(unit);
    } catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> reloadUser() async {
    try {
      await _remoteDataSource.reloadUser();
      return const Right(unit);
    } catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> deleteAccount() async {
    try {
      await _remoteDataSource.deleteAccount();
      return const Right(unit);
    } catch (e) {
      return Left(AuthExceptionHandler.handleException(e));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _remoteDataSource.authStateChanges.map(
      (userModel) => userModel?.toEntity(),
    );
  }

  @override
  bool get isSignedIn {
    return _remoteDataSource.isSignedIn;
  }
}