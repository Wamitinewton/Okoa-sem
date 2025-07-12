import 'package:okoa_sem/features/authentication/data/models/auth_response_model.dart';
import 'package:okoa_sem/features/authentication/data/models/auth_user_model.dart';

abstract class AuthDataSource {
  Future<void> signUpWithPhone({
    required String phoneNumber,
    required String username,
    required String password,
  });

  Future<AuthResponseModel> verifyPhoneOtp({
    required String phoneNumber,
    required String otp,
  });

  Future<void> signInWithPhoneOtp({
    required String phoneNumber,
  });

  Future<AuthResponseModel> signInWithPassword({
    required String username,
    required String password,
  });

  Future<void> resendOtp({
    required String phoneNumber,
  });

  Future<void> signOut();

  Future<AuthResponseModel?> getCurrentSession();

  Future<AuthResponseModel> refreshSession({
    required String refreshToken,
  });

  Future<AuthUserModel> updateProfile({
    String? username,
    String? profileImage,
  });

  Future<bool> isUsernameAvailable(String username);

  Future<AuthUserModel?> getUserByUsername(String username);
}