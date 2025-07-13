import 'package:dartz/dartz.dart';
import 'package:okoa_sem/core/failures/auth_failure.dart';
import 'package:okoa_sem/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  /// Get current authenticated user
  Future<UserEntity?> getCurrentUser();
  
  /// Sign in with Google
  Future<Either<AuthFailure, UserEntity>> signInWithGoogle();
  
  /// Sign in with email and password
  Future<Either<AuthFailure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  /// Register with email and password
  Future<Either<AuthFailure, UserEntity>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  });
  
  /// Sign out
  Future<Either<AuthFailure, Unit>> signOut();
  
  /// Send password reset email
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail({
    required String email,
  });
  
  /// Send email verification
  Future<Either<AuthFailure, Unit>> sendEmailVerification();
  
  /// Reload current user
  Future<Either<AuthFailure, Unit>> reloadUser();
  
  /// Delete current user account
  Future<Either<AuthFailure, Unit>> deleteAccount();
  
  /// Stream of authentication state changes
  Stream<UserEntity?> get authStateChanges;
  
  /// Check if user is signed in
  bool get isSignedIn;
}