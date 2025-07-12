import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignupWithPhoneRequested extends AuthEvent {
  final String phoneNumber;
  final String username;
  final String password;

  const SignupWithPhoneRequested({
    required this.phoneNumber,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [phoneNumber, username, password];
}

class VerifyPhoneOtpRequested extends AuthEvent {
  final String phoneNumber;
  final String otp;

  const VerifyPhoneOtpRequested({
    required this.phoneNumber,
    required this.otp,
  });

  @override
  List<Object?> get props => [phoneNumber, otp];
}

class SignInWithPhoneRequested extends AuthEvent {
  final String phoneNumber;

  const SignInWithPhoneRequested({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}

class SignInWithPasswordRequested extends AuthEvent {
  final String username;
  final String password;

  const SignInWithPasswordRequested({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class ResendOtpRequested extends AuthEvent {
  final String phoneNumber;

  const ResendOtpRequested({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}

class SignOutRequested extends AuthEvent {}

class AuthSessionCheckRequested extends AuthEvent {}

class RefreshSessionRequested extends AuthEvent {}

class UpdateProfileRequested extends AuthEvent {
  final String? username;
  final String? profileImage;

  const UpdateProfileRequested({
    this.username,
    this.profileImage,
  });

  @override
  List<Object?> get props => [username, profileImage];
}

class CheckUsernameAvailabilityRequested extends AuthEvent {
  final String username;

  const CheckUsernameAvailabilityRequested({
    required this.username,
  });

  @override
  List<Object?> get props => [username];
}

class AuthErrorCleared extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String emailOrUsername;
  final String password;

  const LoginRequested({
    required this.emailOrUsername,
    required this.password,
  });

  @override
  List<Object?> get props => [emailOrUsername, password];
}

class SignupRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const SignupRequested({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}

class LogoutRequested extends AuthEvent {}

class AuthStatusChecked extends AuthEvent {}