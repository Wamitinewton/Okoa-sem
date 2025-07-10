import 'package:equatable/equatable.dart';
import 'package:okoa_sem/core/enums/otp_enums.dart';

abstract class OtpEvent extends Equatable{
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

class OtpSendRequested extends OtpEvent {
  final String email;
  final OtpType type;

  const OtpSendRequested({
    required this.email,
    required this.type
  });

  @override
  List<Object?> get props => [email, type];
}

class OtpVerifyRequested extends OtpEvent {
  final String email;
  final String code;
  final OtpType type;

  const OtpVerifyRequested({
    required this.email,
    required this.code,
    required this.type
  });

  @override
  List<Object?> get props => [email, code, type];
}

class OtpResendRequested extends OtpEvent {
  final String email;
  final OtpType type;

  const OtpResendRequested({
    required this.email,
    required this.type,
  });

  @override
  List<Object?> get props => [email, type];
}

class OtpCodeChanged extends OtpEvent {
  final String code;

  const OtpCodeChanged(this.code);

  @override
  List<Object?> get props => [code];
}

class OtpTimerTick extends OtpEvent {
  final int remainingSeconds;

  const OtpTimerTick(this.remainingSeconds);

  @override
  List<Object?> get props => [remainingSeconds];
}

class OtpTimerStarted extends OtpEvent {
  final int durationInSeconds;

  const OtpTimerStarted({this.durationInSeconds = 300});

  @override
  List<Object?> get props => [durationInSeconds];
}

class OtpTimerStopped extends OtpEvent {}

class OtpReset extends OtpEvent {}