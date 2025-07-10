import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okoa_sem/core/enums/otp_enums.dart';
import 'package:okoa_sem/features/otp/domain/user_cases/resend_otp_use_case.dart';
import 'package:okoa_sem/features/otp/domain/user_cases/send_otp_use_case.dart';
import 'package:okoa_sem/features/otp/domain/user_cases/verifiy_otp_use_case.dart';
import 'package:okoa_sem/features/otp/presentation/bloc/otp_event.dart';
import 'package:okoa_sem/features/otp/presentation/bloc/otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;

  Timer? _timer;

  OtpBloc({
    required SendOtpUseCase sendOtpUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResendOtpUseCase resendOtpUseCase,
  })  : _sendOtpUseCase = sendOtpUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        _resendOtpUseCase = resendOtpUseCase,
        super(const OtpState()) {
    on<OtpSendRequested>(_onSendOtpRequested);
    on<OtpVerifyRequested>(_onVerifyOtpRequested);
    on<OtpResendRequested>(_onResendOtpRequested);
    on<OtpCodeChanged>(_onCodeChanged);
    on<OtpTimerTick>(_onTimerTick);
    on<OtpTimerStarted>(_onTimerStarted);
    on<OtpTimerStopped>(_onTimerStopped);
    on<OtpReset>(_onReset);
  }

  Future<void> _onSendOtpRequested(
    OtpSendRequested event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(
      status: OtpStatus.sending,
      email: event.email,
      type: event.type,
      errorMessage: null,
    ));

    final result = await _sendOtpUseCase(
      email: event.email,
      type: event.type,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: OtpStatus.failed,
        errorMessage: failure.message,
        canResend: true,
      )),
      (otp) {
        emit(state.copyWith(
          status: OtpStatus.sent,
          currentOtp: otp,
          canResend: false,
          attemptsLeft: otp.attemptsLeft,
          code: '', 
        ));
        
        add(const OtpTimerStarted());
      },
    );
  }

  Future<void> _onVerifyOtpRequested(
    OtpVerifyRequested event,
    Emitter<OtpState> emit,
  ) async {
    if (state.code.length != 6) {
      emit(state.copyWith(
        errorMessage: 'Please enter a complete 6-digit code',
      ));
      return;
    }

    emit(state.copyWith(
      status: OtpStatus.verifying,
      errorMessage: null,
    ));

    final result = await _verifyOtpUseCase(
      email: event.email,
      code: event.code,
      type: event.type,
    );

    result.fold(
      (failure) {
        final newAttemptsLeft = state.attemptsLeft - 1;
        emit(state.copyWith(
          status: OtpStatus.failed,
          errorMessage: failure.message,
          attemptsLeft: newAttemptsLeft,
          canResend: newAttemptsLeft <= 0,
        ));
      },
      (isVerified) {
        if (isVerified) {
          _timer?.cancel();
          emit(state.copyWith(
            status: OtpStatus.verified,
            remainingSeconds: 0,
          ));
        } else {
          emit(state.copyWith(
            status: OtpStatus.failed,
            errorMessage: 'Verification failed. Please try again.',
          ));
        }
      },
    );
  }

  Future<void> _onResendOtpRequested(
    OtpResendRequested event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(
      status: OtpStatus.resending,
      errorMessage: null,
    ));

    final result = await _resendOtpUseCase(
      email: event.email,
      type: event.type,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: OtpStatus.failed,
        errorMessage: failure.message,
        canResend: true,
      )),
      (otp) {
        emit(state.copyWith(
          status: OtpStatus.sent,
          currentOtp: otp,
          canResend: false,
          attemptsLeft: otp.attemptsLeft,
          code: '',
        ));
        
        add(const OtpTimerStarted());
      },
    );
  }

  void _onCodeChanged(
    OtpCodeChanged event,
    Emitter<OtpState> emit,
  ) {
    emit(state.copyWith(
      code: event.code,
      errorMessage: null,
    ));
  }

  void _onTimerTick(
    OtpTimerTick event,
    Emitter<OtpState> emit,
  ) {
    if (event.remainingSeconds <= 0) {
      _timer?.cancel();
      emit(state.copyWith(
        remainingSeconds: 0,
        canResend: true,
        status: state.status == OtpStatus.sent ? OtpStatus.expired : state.status,
      ));
    } else {
      emit(state.copyWith(remainingSeconds: event.remainingSeconds));
    }
  }

  void _onTimerStarted(
    OtpTimerStarted event,
    Emitter<OtpState> emit,
  ) {
    _timer?.cancel();
    
    emit(state.copyWith(
      remainingSeconds: event.durationInSeconds,
      canResend: false,
    ));

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final remaining = state.remainingSeconds - 1;
        add(OtpTimerTick(remaining));
      },
    );
  }

  void _onTimerStopped(
    OtpTimerStopped event,
    Emitter<OtpState> emit,
  ) {
    _timer?.cancel();
    emit(state.copyWith(
      remainingSeconds: 0,
      canResend: true,
    ));
  }

  void _onReset(
    OtpReset event,
    Emitter<OtpState> emit,
  ) {
    _timer?.cancel();
    emit(const OtpState());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}