import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthResponse, User;
import 'package:okoa_sem/features/authentication/data/datasources/auth_data_source.dart';
import 'package:okoa_sem/features/authentication/domain/entities/auth_response.dart';
import 'package:okoa_sem/features/authentication/domain/entities/user.dart';
import 'package:okoa_sem/features/authentication/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<Either<AuthFailure, void>> signUpWithPhone({
    required String phoneNumber,
    required String username,
    required String password,
  }) async {
    try {
      final phoneValidation = _validatePhoneNumber(phoneNumber);
      if (phoneValidation != null) {
        return Left(phoneValidation);
      }

      final usernameValidation = _validateUsername(username);
      if (usernameValidation != null) {
        return Left(usernameValidation);
      }

      final passwordValidation = _validatePassword(password);
      if (passwordValidation != null) {
        return Left(passwordValidation);
      }

      await _dataSource.signUpWithPhone(
        phoneNumber: phoneNumber,
        username: username,
        password: password,
      );

      return const Right(null);
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(AuthFailure(
        message: e.toString(),
        type: AuthFailureType.unknown,
      ));
    }
  }

  @override
  Future<Either<AuthFailure, AuthResponse>> verifyPhoneOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final phoneValidation = _validatePhoneNumber(phoneNumber);
      if (phoneValidation != null) {
        return Left(phoneValidation);
      }

      final otpValidation = _validateOtp(otp);
      if (otpValidation != null) {
        return Left(otpValidation);
      }

      final response = await _dataSource.verifyPhoneOtp(
        phoneNumber: phoneNumber,
        otp: otp,
      );

      return Right(response.toDomain());
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(AuthFailure(
        message: e.toString(),
        type: AuthFailureType.unknown,
      ));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signInWithPhoneOtp({
    required String phoneNumber,
  }) async {
    try {
      final phoneValidation = _validatePhoneNumber(phoneNumber);
      if (phoneValidation != null) {
        return Left(phoneValidation);
      }

      await _dataSource.signInWithPhoneOtp(phoneNumber: phoneNumber);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(AuthFailure(
        message: e.toString(),
        type: AuthFailureType.unknown,
      ));
    }
  }

  @override
  Future<Either<AuthFailure, AuthResponse>> signInWithPassword({
    required String username,
    required String password,
  }) async {
    try {
      final usernameValidation = _validateUsername(username);
      if (usernameValidation != null) {
        return Left(usernameValidation);
      }

      if (password.isEmpty) {
        return const Left(AuthFailure(
          message: 'Password is required',
          type: AuthFailureType.invalidCredentials,
        ));
      }

      final response = await _dataSource.signInWithPassword(
        username: username,
        password: password,
      );

      return Right(response.toDomain());
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(AuthFailure(
        message: e.toString(),
        type: AuthFailureType.unknown,
      ));
    }
  }

  @override
  Future<Either<AuthFailure, void>> resendOtp({
    required String phoneNumber,
  }) async {
    try {
      final phoneValidation = _validatePhoneNumber(phoneNumber);
      if (phoneValidation != null) {
        return Left(phoneValidation);
      }

      await _dataSource.resendOtp(phoneNumber: phoneNumber);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(AuthFailure(
        message: e.toString(),
        type: AuthFailureType.unknown,
      ));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      await _dataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(
        message: e.toString(),
        type: AuthFailureType.unknown,
      ));
    }
  }

  @override
  Future<Either<AuthFailure, AuthResponse?>> getCurrentSession() async {
    try {
      final response = await _dataSource.getCurrentSession();
      return Right(response?.toDomain());
    } catch (e) {
      return Left(AuthFailure(
        message: e.toString(),
        type: AuthFailureType.unknown,
      ));
    }
  }

  @override
  Future<Either<AuthFailure, AuthResponse>> refreshSession({
    required String refreshToken,
  }) async {
    try {
      if (refreshToken.isEmpty) {
        return const Left(AuthFailure(
          message: 'Refresh token is required',
          type: AuthFailureType.sessionExpired,
        ));
      }

      final response = await _dataSource.refreshSession(
        refreshToken: refreshToken,
      );

      return Right(response.toDomain());
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(AuthFailure(
        message: e.toString(),
        type: AuthFailureType.unknown,
      ));
    }
  }

  @override
  Future<Either<AuthFailure, User>> updateProfile({
    String? username,
    String? profileImage,
  }) async {
    try {
      if (username != null) {
        final usernameValidation = _validateUsername(username);
        if (usernameValidation != null) {
          return Left(usernameValidation);
        }
      }

      final response = await _dataSource.updateProfile(
        username: username,
        profileImage: profileImage,
      );

      return Right(response.toDomain());
    } on AuthException catch (e) {
      return Left(_mapAuthException(e));
    } catch (e) {
      return Left(AuthFailure(
        message: e.toString(),
        type: AuthFailureType.unknown,
      ));
    }
  }

  @override
  Future<Either<AuthFailure, bool>> isUsernameAvailable(String username) async {
    try {
      final usernameValidation = _validateUsername(username);
      if (usernameValidation != null) {
        return Left(usernameValidation);
      }

      final isAvailable = await _dataSource.isUsernameAvailable(username);
      return Right(isAvailable);
    } catch (e) {
      return Left(AuthFailure(
        message: e.toString(),
        type: AuthFailureType.unknown,
      ));
    }
  }

  AuthFailure? _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return const AuthFailure(
        message: 'Phone number is required',
        type: AuthFailureType.invalidPhoneNumber,
      );
    }



    return null;
  }

  AuthFailure? _validateUsername(String username) {
    if (username.isEmpty) {
      return const AuthFailure(
        message: 'Username is required',
        type: AuthFailureType.invalidCredentials,
      );
    }

    if (username.length < 3) {
      return const AuthFailure(
        message: 'Username must be at least 3 characters',
        type: AuthFailureType.invalidCredentials,
      );
    }

    if (username.length > 20) {
      return const AuthFailure(
        message: 'Username must be less than 20 characters',
        type: AuthFailureType.invalidCredentials,
      );
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      return const AuthFailure(
        message: 'Username can only contain letters, numbers, and underscores',
        type: AuthFailureType.invalidCredentials,
      );
    }

    return null;
  }

  AuthFailure? _validatePassword(String password) {
    if (password.isEmpty) {
      return const AuthFailure(
        message: 'Password is required',
        type: AuthFailureType.invalidCredentials,
      );
    }

    if (password.length < 6) {
      return const AuthFailure(
        message: 'Password must be at least 6 characters',
        type: AuthFailureType.weakPassword,
      );
    }

    if (password.length > 128) {
      return const AuthFailure(
        message: 'Password must be less than 128 characters',
        type: AuthFailureType.weakPassword,
      );
    }

    return null;
  }

  AuthFailure? _validateOtp(String otp) {
    if (otp.isEmpty) {
      return const AuthFailure(
        message: 'Verification code is required',
        type: AuthFailureType.invalidOtp,
      );
    }

    if (otp.length != 6 || !RegExp(r'^\d{6}$').hasMatch(otp)) {
      return const AuthFailure(
        message: 'Please enter a valid 6-digit verification code',
        type: AuthFailureType.invalidOtp,
      );
    }

    return null;
  }



  AuthFailure _mapAuthException(AuthException exception) {
    final message = exception.message.toLowerCase();

    if (message.contains('invalid_credentials') || 
        message.contains('invalid credentials')) {
      return const AuthFailure(
        message: 'Invalid credentials',
        type: AuthFailureType.invalidCredentials,
      );
    }

    if (message.contains('user_not_found') || 
        message.contains('user not found')) {
      return const AuthFailure(
        message: 'User not found',
        type: AuthFailureType.userNotFound,
      );
    }

    if (message.contains('user_already_registered') || 
        message.contains('already registered')) {
      return const AuthFailure(
        message: 'An account with this phone number already exists',
        type: AuthFailureType.userAlreadyExists,
      );
    }

    if (message.contains('invalid_phone') || 
        message.contains('phone')) {
      return const AuthFailure(
        message: 'Invalid phone number',
        type: AuthFailureType.invalidPhoneNumber,
      );
    }

    if (message.contains('invalid_otp') || 
        message.contains('otp') ||
        message.contains('token')) {
      return const AuthFailure(
        message: 'Invalid verification code',
        type: AuthFailureType.invalidOtp,
      );
    }

    if (message.contains('expired')) {
      return const AuthFailure(
        message: 'Verification code has expired',
        type: AuthFailureType.otpExpired,
      );
    }

    if (message.contains('weak_password') || 
        message.contains('password')) {
      return const AuthFailure(
        message: 'Password is too weak',
        type: AuthFailureType.weakPassword,
      );
    }

    if (message.contains('username') && 
        message.contains('taken')) {
      return const AuthFailure(
        message: 'Username is already taken',
        type: AuthFailureType.usernameNotAvailable,
      );
    }

    if (message.contains('network') || 
        message.contains('connection')) {
      return const AuthFailure(
        message: 'Network connection error',
        type: AuthFailureType.networkError,
      );
    }

    if (message.contains('server') || 
        message.contains('internal')) {
      return const AuthFailure(
        message: 'Server error occurred',
        type: AuthFailureType.serverError,
      );
    }

    return AuthFailure(
      message: exception.message,
      type: AuthFailureType.unknown,
    );
  }
}