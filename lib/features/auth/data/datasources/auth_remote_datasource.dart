import 'package:okoa_sem/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Get current authenticated user
  Future<UserModel?> getCurrentUser();
  
  /// Sign in with Google
  Future<UserModel> signInWithGoogle();
  
  /// Sign in with email and password
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  /// Register with email and password
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  });
  
  /// Sign out
  Future<void> signOut();
  
  /// Send password reset email
  Future<void> sendPasswordResetEmail({
    required String email,
  });
  
  /// Send email verification
  Future<void> sendEmailVerification();
  
  /// Reload current user
  Future<void> reloadUser();
  
  /// Delete current user account
  Future<void> deleteAccount();
  
  /// Stream of authentication state changes
  Stream<UserModel?> get authStateChanges;
  
  /// Check if user is signed in
  bool get isSignedIn;
}