import 'package:equatable/equatable.dart';
import 'package:okoa_sem/core/enums/otp_enums.dart';

class Otp extends Equatable {
  final String id;
  final String email;
  final String code;
  final OtpType type;
  final DateTime expiresAt;
  final DateTime createdAt;
  final bool isUsed;
  final int attemptsLeft;

  const Otp({
    required this.id,
    required this.email,
    required this.code,
    required this.type,
    required this.expiresAt,
    required this.createdAt,
    this.isUsed = false,
    this.attemptsLeft = 3,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  
  bool get isValid => !isExpired && !isUsed && attemptsLeft > 0;

  Duration get timeRemaining {
    if (isExpired) return Duration.zero;
    return expiresAt.difference(DateTime.now());
  }

  Otp copyWith({
    String? id,
    String? email,
    String? code,
    OtpType? type,
    DateTime? expiresAt,
    DateTime? createdAt,
    bool? isUsed,
    int? attemptsLeft,
  }) {
    return Otp(
      id: id ?? this.id,
      email: email ?? this.email,
      code: code ?? this.code,
      type: type ?? this.type,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      isUsed: isUsed ?? this.isUsed,
      attemptsLeft: attemptsLeft ?? this.attemptsLeft,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        code,
        type,
        expiresAt,
        createdAt,
        isUsed,
        attemptsLeft,
      ];
}