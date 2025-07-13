import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:okoa_sem/core/failures/auth_failure.dart';

class AuthExceptionHandler {
  static AuthFailure handleException(dynamic exception) {
    if (exception is FirebaseAuthException) {
      return _handleFirebaseAuthException(exception);
    } else if (exception is SocketException) {
      return const AuthFailure.networkError();
    } else {
      return AuthFailure.unknownError(exception.toString());
    }
  }

  static AuthFailure _handleFirebaseAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'user-not-found':
        return const AuthFailure.userNotFound();
      
      case 'wrong-password':
        return const AuthFailure.wrongPassword();
      
      case 'invalid-email':
        return const AuthFailure.invalidEmail();
      
      case 'user-disabled':
        return const AuthFailure.userDisabled();
      
      case 'email-already-in-use':
        return const AuthFailure.emailAlreadyInUse();
      
      case 'weak-password':
        return const AuthFailure.weakPassword();
      
      case 'too-many-requests':
        return const AuthFailure.tooManyRequests();
      
      case 'operation-not-allowed':
        return const AuthFailure.operationNotAllowed();
      
      case 'account-exists-with-different-credential':
        return const AuthFailure.accountExistsWithDifferentCredential();
      
      case 'invalid-credential':
        return const AuthFailure.invalidCredential();
      
      case 'aborted-by-user':
      case 'cancelled':
        return const AuthFailure.cancelled();
      
      case 'network-request-failed':
        return const AuthFailure.networkError();
      
      case 'internal-error':
      case 'unknown':
        return AuthFailure.serverError(exception.message);
      
      default:
        return AuthFailure.unknownError(exception.message);
    }
  }
}