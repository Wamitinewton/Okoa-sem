import 'package:equatable/equatable.dart';
import 'package:okoa_sem/features/authentication/domain/entities/user.dart';

class AuthResponse extends Equatable {
  final User user;
  final String accessToken;
  final String refreshToken;
  final DateTime? expiresAt;

  const AuthResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    this.expiresAt,
  });

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  @override
  List<Object?> get props => [user, accessToken, refreshToken, expiresAt];
}