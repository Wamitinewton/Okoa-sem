import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:okoa_sem/features/auth/domain/usecases/get_current_user.dart';
import 'package:okoa_sem/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_event.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUser _getCurrentUser;
  final GetAuthStateChanges _getAuthStateChanges;
  final SignInWithGoogle _signInWithGoogle;

  late StreamSubscription<dynamic> _authStreamSubscription;

  AuthBloc(
    this._getCurrentUser,
    this._getAuthStateChanges,
    this._signInWithGoogle,
  ) : super(const AuthState.initial()) {
    _authStreamSubscription = _getAuthStateChanges().listen(
      (user) {
        if (user != null) {
          add(const AuthEvent.authStateChanged());
        } else {
          add(const AuthEvent.authStateChanged());
        }
      },
    );

    // Register event handlers
    on<AuthEvent>((event, emit) async {
      await event.when(
        authStateChanged: () => _onAuthStateChanged(emit),
        checkAuthStatus: () => _onCheckAuthStatus(emit),
        signInWithGoogle: () => _onSignInWithGoogle(emit),
    
      );
    });

    // Check initial auth status
    add(const AuthEvent.checkAuthStatus());
  }

  Future<void> _onAuthStateChanged(Emitter<AuthState> emit) async {
    final user = await _getCurrentUser();
    if (user != null) {
      emit(AuthState.authenticated(user: user));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onCheckAuthStatus(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final user = await _getCurrentUser();
    if (user != null) {
      emit(AuthState.authenticated(user: user));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignInWithGoogle(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    
    final result = await _signInWithGoogle();
    
    result.fold(
      (failure) => emit(AuthState.error(failure: failure)),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

 

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    return super.close();
  }
}