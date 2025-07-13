import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/authentication/data/datasources/auth_data_source.dart';
import 'package:okoa_sem/features/authentication/data/models/auth_response_model.dart';
import 'package:okoa_sem/features/authentication/data/models/auth_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: AuthDataSource)
class SupabaseAuthDataSource implements AuthDataSource {
  final SupabaseClient _supabase;

  SupabaseAuthDataSource(this._supabase);

 @override
  Future<void> signUpWithPhone({
    required String phoneNumber,
    required String username,
    required String password,
  }) async {
    try {
      final isAvailable = await isUsernameAvailable(username);
      if (!isAvailable) {
        throw const AuthException('Username is already taken');
      }

      final formattedPhone = _formatPhoneNumber(phoneNumber);

      await _supabase.auth.signUp(
        phone: formattedPhone,
        password: password,
        data: {
          'username': username,
        },
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Sign up failed: ${e.toString()}');
    }
  }

  @override
  Future<AuthResponseModel> verifyPhoneOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final formattedPhone = _formatPhoneNumber(phoneNumber);

      final response = await _supabase.auth.verifyOTP(
        phone: formattedPhone,
        token: otp,
        type: OtpType.sms,
      );

      if (response.session == null) {
        throw const AuthException('Verification failed');
      }

      final user = response.user;
      if (user != null) {
        await _updateUserMetadata(user.id);
      }

      return AuthResponseModel.fromSupabaseSession(response.session!.toJson());
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('OTP verification failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signInWithPhoneOtp({
    required String phoneNumber,
  }) async {
    try {
      final formattedPhone = _formatPhoneNumber(phoneNumber);

      await _supabase.auth.signInWithOtp(
        phone: formattedPhone,
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Failed to send OTP: ${e.toString()}');
    }
  }

  @override
  Future<AuthResponseModel> signInWithPassword({
    required String username,
    required String password,
  }) async {
    try {
      final userModel = await getUserByUsername(username);
      if (userModel == null) {
        throw const AuthException('User not found');
      }

      final response = await _supabase.auth.signInWithPassword(
        phone: userModel.phoneNumber,
        password: password,
      );

      if (response.session == null) {
        throw const AuthException('Invalid credentials');
      }

      return AuthResponseModel.fromSupabaseSession(response.session!.toJson());
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<void> resendOtp({
    required String phoneNumber,
  }) async {
    try {
      final formattedPhone = _formatPhoneNumber(phoneNumber);

      await _supabase.auth.resend(
        phone: formattedPhone,
        type: OtpType.sms,
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Failed to resend OTP: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw AuthException('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<AuthResponseModel?> getCurrentSession() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) return null;

      return AuthResponseModel.fromSupabaseSession(session.toJson());
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AuthResponseModel> refreshSession({
    required String refreshToken,
  }) async {
    try {
      final response = await _supabase.auth.refreshSession(refreshToken);

      if (response.session == null) {
        throw const AuthException('Failed to refresh session');
      }

      return AuthResponseModel.fromSupabaseSession(response.session!.toJson());
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Session refresh failed: ${e.toString()}');
    }
  }

  @override
  Future<AuthUserModel> updateProfile({
    String? username,
    String? profileImage,
  }) async {
    try {
      final currentUser = _supabase.auth.currentUser;
      if (currentUser == null) {
        throw const AuthException('No authenticated user');
      }

      if (username != null && username != currentUser.userMetadata?['username']) {
        final isAvailable = await isUsernameAvailable(username);
        if (!isAvailable) {
          throw const AuthException('Username is already taken');
        }
      }

      final updateData = <String, dynamic>{};
      if (username != null) updateData['username'] = username;
      if (profileImage != null) updateData['profile_image'] = profileImage;

      final response = await _supabase.auth.updateUser(
        UserAttributes(data: updateData),
      );

      if (response.user == null) {
        throw const AuthException('Failed to update profile');
      }

      await _updateUserMetadata(currentUser.id);

      return AuthUserModel.fromSupabaseAuth(response.user!.toJson());
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Profile update failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> isUsernameAvailable(String username) async {
    try {
      final response = await _supabase
          .from('users')
          .select('id')
          .eq('username', username.toLowerCase())
          .maybeSingle();

      return response == null;
    } catch (e) {
      return true;
    }
  }

  @override
  Future<AuthUserModel?> getUserByUsername(String username) async {
    try {
      final response = await _supabase
          .from('users')
          .select('*')
          .eq('username', username.toLowerCase())
          .maybeSingle();

      if (response == null) return null;

      return AuthUserModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  String _formatPhoneNumber(String phoneNumber) {
    String digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digits.startsWith('0')) {
      return '+254${digits.substring(1)}';
    } else if (digits.startsWith('254')) {
      return '+$digits';
    } else if (digits.startsWith('+254')) {
      return digits;
    } else {
      return '+254$digits';
    }
  }

  Future<void> _updateUserMetadata(String userId) async {
    try {
      final currentUser = _supabase.auth.currentUser;
      if (currentUser == null) return;

      final metadata = currentUser.userMetadata ?? {};
      final username = metadata['username'] as String?;
      
      if (username != null) {
        await _supabase.from('users').upsert({
          'id': userId,
          'username': username.toLowerCase(),
          'phone_number': currentUser.phone,
          'profile_image': metadata['profile_image'],
          'created_at': currentUser.createdAt,
          'is_phone_verified': currentUser.phoneConfirmedAt != null,
        });
      }
    } catch (e) {
      print('Failed to update user metadata: $e');
    }
  }
}