import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authStateChanged() = _AuthStateChanged;
  const factory AuthEvent.checkAuthStatus() = _CheckAuthStatus;
  
  const factory AuthEvent.signInWithGoogle() = _SignInWithGoogle;
  
  const factory AuthEvent.signInWithEmail({
    required String email,
    required String password,
  }) = _SignInWithEmail;
  
  const factory AuthEvent.registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) = _RegisterWithEmail;
  
  const factory AuthEvent.signOut() = _SignOut;
  
  const factory AuthEvent.sendPasswordReset({
    required String email,
  }) = _SendPasswordReset;
  
  const factory AuthEvent.sendEmailVerification() = _SendEmailVerification;
  
  const factory AuthEvent.reloadUser() = _ReloadUser;
  
  const factory AuthEvent.deleteAccount() = _DeleteAccount;
}