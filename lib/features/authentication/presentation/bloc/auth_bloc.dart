import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/sign_up_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/verifiy_phone_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/sign_in_with_phone_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/sign_in_with_password_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/resend_otp_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/sign_out_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/get_current_session_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/refresh_session_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/update_profile_use_case.dart';
import 'package:okoa_sem/features/authentication/domain/usecases/check_username_availability_use_case.dart';
import 'package:okoa_sem/features/authentication/presentation/bloc/auth_event.dart';
import 'package:okoa_sem/features/authentication/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final VerifyPhoneUseCase _verifyPhoneUseCase;
  final SignInWithPhoneUseCase _signInWithPhoneUseCase;
  final SignInWithPasswordUseCase _signInWithPasswordUseCase;
  final ResendOtpUseCase _resendOtpUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetCurrentSessionUseCase _getCurrentSessionUseCase;
  final RefreshSessionUseCase _refreshSessionUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final CheckUsernameAvailabilityUseCase _checkUsernameAvailabilityUseCase;

  Timer? _otpTimer;

  AuthBloc({
    required SignUpUseCase signUpUseCase,
    required VerifyPhoneUseCase verifyPhoneUseCase,
    required SignInWithPhoneUseCase signInWithPhoneUseCase,
    required SignInWithPasswordUseCase signInWithPasswordUseCase,
    required ResendOtpUseCase resendOtpUseCase,
    required SignOutUseCase signOutUseCase,
    required GetCurrentSessionUseCase getCurrentSessionUseCase,
    required RefreshSessionUseCase refreshSessionUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required CheckUsernameAvailabilityUseCase checkUsernameAvailabilityUseCase,
  })  : _signUpUseCase = signUpUseCase,
        _verifyPhoneUseCase = verifyPhoneUseCase,
        _signInWithPhoneUseCase = signInWithPhoneUseCase,
        _signInWithPasswordUseCase = signInWithPasswordUseCase,
        _resendOtpUseCase = resendOtpUseCase,
        _signOutUseCase = signOutUseCase,
        _getCurrentSessionUseCase = getCurrentSessionUseCase,
        _refreshSessionUseCase = refreshSessionUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        _checkUsernameAvailabilityUseCase = checkUsernameAvailabilityUseCase,
        super(const AuthState()) {
    on<SignupWithPhoneRequested>(_onSignupWithPhoneRequested);
    on<VerifyPhoneOtpRequested>(_onVerifyPhoneOtpRequested);
    on<SignInWithPhoneRequested>(_onSignInWithPhoneRequested);
    on<SignInWithPasswordRequested>(_onSignInWithPasswordRequested);
    on<ResendOtpRequested>(_onResendOtpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthSessionCheckRequested>(_onAuthSessionCheckRequested);
    on<RefreshSessionRequested>(_onRefreshSessionRequested);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
    on<CheckUsernameAvailabilityRequested>(_onCheckUsernameAvailabilityRequested);
    on<AuthErrorCleared>(_onAuthErrorCleared);
    
    // OTP related events
    on<OtpCodeChanged>(_onOtpCodeChanged);
    on<OtpTimerTick>(_onOtpTimerTick);
    on<OtpTimerStarted>(_onOtpTimerStarted);
    on<OtpTimerStopped>(_onOtpTimerStopped);
    on<OtpReset>(_onOtpReset);
  }

  Future<void> _onSignupWithPhoneRequested(
    SignupWithPhoneRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _signUpUseCase(
      phoneNumber: event.phoneNumber,
      username: event.username,
      password: event.password,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      )),
      (_) {
        emit(state.copyWith(
          status: AuthStatus.otpSent,
          phoneNumber: event.phoneNumber,
          canResendOtp: false,
          attemptsLeft: 3,
          otpCode: '',
        ));
        
        add(const OtpTimerStarted());
      },
    );
  }

  Future<void> _onVerifyPhoneOtpRequested(
    VerifyPhoneOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.otpCode.length != 6) {
      emit(state.copyWith(
        errorMessage: 'Please enter a complete 6-digit code',
      ));
      return;
    }

    emit(state.copyWith(status: AuthStatus.verifying));

    final result = await _verifyPhoneUseCase(
      phoneNumber: event.phoneNumber,
      otp: event.otp,
    );

    result.fold(
      (failure) {
        final newAttemptsLeft = state.attemptsLeft - 1;
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
          attemptsLeft: newAttemptsLeft,
          canResendOtp: newAttemptsLeft <= 0,
        ));
      },
      (authResponse) {
        _otpTimer?.cancel();
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: authResponse.user,
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
          remainingSeconds: 0,
        ));
      },
    );
  }

  Future<void> _onSignInWithPhoneRequested(
    SignInWithPhoneRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _signInWithPhoneUseCase(
      phoneNumber: event.phoneNumber,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      )),
      (_) {
        emit(state.copyWith(
          status: AuthStatus.otpSent,
          phoneNumber: event.phoneNumber,
          canResendOtp: false,
          attemptsLeft: 3,
          otpCode: '',
        ));
        
        add(const OtpTimerStarted());
      },
    );
  }

  Future<void> _onSignInWithPasswordRequested(
    SignInWithPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _signInWithPasswordUseCase(
      username: event.username,
      password: event.password,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      )),
      (authResponse) => emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: authResponse.user,
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      )),
    );
  }

  Future<void> _onResendOtpRequested(
    ResendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _resendOtpUseCase(
      phoneNumber: event.phoneNumber,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
        canResendOtp: true,
      )),
      (_) {
        emit(state.copyWith(
          status: AuthStatus.otpSent,
          canResendOtp: false,
          attemptsLeft: 3,
          otpCode: '',
        ));
        
        add(const OtpTimerStarted());
      },
    );
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _signOutUseCase();

    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      )),
      (_) {
        _otpTimer?.cancel();
        emit(const AuthState(status: AuthStatus.unauthenticated));
      },
    );
  }

  Future<void> _onAuthSessionCheckRequested(
    AuthSessionCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _getCurrentSessionUseCase();

    result.fold(
      (failure) => emit(const AuthState(status: AuthStatus.unauthenticated)),
      (authResponse) {
        if (authResponse != null) {
          emit(state.copyWith(
            status: AuthStatus.authenticated,
            user: authResponse.user,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
          ));
        } else {
          emit(const AuthState(status: AuthStatus.unauthenticated));
        }
      },
    );
  }

  Future<void> _onRefreshSessionRequested(
    RefreshSessionRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.refreshToken == null) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
      return;
    }

    final result = await _refreshSessionUseCase(
      refreshToken: state.refreshToken!,
    );

    result.fold(
      (failure) => emit(const AuthState(status: AuthStatus.unauthenticated)),
      (authResponse) => emit(state.copyWith(
        user: authResponse.user,
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      )),
    );
  }

  Future<void> _onUpdateProfileRequested(
    UpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _updateProfileUseCase(
      username: event.username,
      profileImage: event.profileImage,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      )),
    );
  }

  Future<void> _onCheckUsernameAvailabilityRequested(
    CheckUsernameAvailabilityRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _checkUsernameAvailabilityUseCase(
      username: event.username,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        usernameAvailable: false,
        usernameError: failure.message,
      )),
      (isAvailable) => emit(state.copyWith(
        usernameAvailable: isAvailable,
        usernameError: isAvailable ? null : 'Username is not available',
      )),
    );
  }

  void _onAuthErrorCleared(
    AuthErrorCleared event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }

  // OTP related event handlers
  void _onOtpCodeChanged(
    OtpCodeChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      otpCode: event.code,
      errorMessage: null,
    ));
  }

  void _onOtpTimerTick(
    OtpTimerTick event,
    Emitter<AuthState> emit,
  ) {
    if (event.remainingSeconds <= 0) {
      _otpTimer?.cancel();
      emit(state.copyWith(
        remainingSeconds: 0,
        canResendOtp: true,
        status: state.status == AuthStatus.otpSent ? AuthStatus.otpExpired : state.status,
      ));
    } else {
      emit(state.copyWith(remainingSeconds: event.remainingSeconds));
    }
  }

  void _onOtpTimerStarted(
    OtpTimerStarted event,
    Emitter<AuthState> emit,
  ) {
    _otpTimer?.cancel();
    
    emit(state.copyWith(
      remainingSeconds: event.durationInSeconds,
      canResendOtp: false,
    ));

    _otpTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final remaining = state.remainingSeconds - 1;
        add(OtpTimerTick(remaining));
      },
    );
  }

  void _onOtpTimerStopped(
    OtpTimerStopped event,
    Emitter<AuthState> emit,
  ) {
    _otpTimer?.cancel();
    emit(state.copyWith(
      remainingSeconds: 0,
      canResendOtp: true,
    ));
  }

  void _onOtpReset(
    OtpReset event,
    Emitter<AuthState> emit,
  ) {
    _otpTimer?.cancel();
    emit(state.clearOtp());
  }

  @override
  Future<void> close() {
    _otpTimer?.cancel();
    return super.close();
  }
}