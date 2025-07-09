import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {

  final String emailOrUsername;
  final String password;

  const LoginRequested({
    required this.emailOrUsername,
    required this.password
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
    required this.password
  });

  @override
  List<Object?> get props => [username, email, password];
}

class LogoutRequested extends AuthEvent{}

class AuthStatusChecked extends AuthEvent {}