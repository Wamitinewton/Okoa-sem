// lib/features/otp/presentation/bloc/otp_state.dart

import 'package:equatable/equatable.dart';
import 'package:okoa_sem/core/enums/otp_enums.dart';
import 'package:okoa_sem/features/otp/domain/entities/otp.dart';

class OtpState extends Equatable {
  final OtpStatus status;
  final String code;
  final String email;
  final OtpType type;
  final Otp? currentOtp;
  final String? errorMessage;
  final int remainingSeconds;
  final bool canResend;
  final int attemptsLeft;

  const OtpState({
    this.status = OtpStatus.initial,
    this.code = '',
    this.email = '',
    this.type = OtpType.emailVerification,
    this.currentOtp,
    this.errorMessage,
    this.remainingSeconds = 0,
    this.canResend = false,
    this.attemptsLeft = 3,
  });

  bool get isCodeComplete => code.length == 6;
  
  bool get isTimerActive => remainingSeconds > 0;
  
  bool get canVerify => isCodeComplete && 
                       status != OtpStatus.verifying && 
                       attemptsLeft > 0;
  
  bool get canRequestResend => canResend && 
                              status != OtpStatus.sending && 
                              status != OtpStatus.resending &&
                              !isTimerActive;

  String get formattedTimeRemaining {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  OtpState copyWith({
    OtpStatus? status,
    String? code,
    String? email,
    OtpType? type,
    Otp? currentOtp,
    String? errorMessage,
    int? remainingSeconds,
    bool? canResend,
    int? attemptsLeft,
  }) {
    return OtpState(
      status: status ?? this.status,
      code: code ?? this.code,
      email: email ?? this.email,
      type: type ?? this.type,
      currentOtp: currentOtp ?? this.currentOtp,
      errorMessage: errorMessage,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      canResend: canResend ?? this.canResend,
      attemptsLeft: attemptsLeft ?? this.attemptsLeft,
    );
  }

  OtpState clearError() {
    return copyWith(errorMessage: null);
  }

  @override
  List<Object?> get props => [
        status,
        code,
        email,
        type,
        currentOtp,
        errorMessage,
        remainingSeconds,
        canResend,
        attemptsLeft,
      ];
}