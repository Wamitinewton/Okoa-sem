import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authStateChanged() = _AuthStateChanged;
  const factory AuthEvent.checkAuthStatus() = _CheckAuthStatus;
  
  const factory AuthEvent.signInWithGoogle() = _SignInWithGoogle;
  

}