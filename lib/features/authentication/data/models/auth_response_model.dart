import 'package:json_annotation/json_annotation.dart';
import 'package:okoa_sem/features/authentication/data/models/auth_user_model.dart';
import 'package:okoa_sem/features/authentication/domain/entities/auth_response.dart';
import 'package:okoa_sem/features/authentication/domain/entities/user.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel extends AuthResponse {
  @JsonKey(
    fromJson: _userFromJson,
    toJson: _userToJson,
  )
  @override
  final User user;

  const AuthResponseModel({
    required this.user,
    required super.accessToken,
    required super.refreshToken,
    super.expiresAt,
  }) : super(user: user);

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  static User _userFromJson(Map<String, dynamic> json) => 
      AuthUserModel.fromJson(json);

  static Map<String, dynamic> _userToJson(User user) => 
      (user as AuthUserModel).toJson();

  factory AuthResponseModel.fromSupabaseSession(Map<String, dynamic> sessionData) {
    final userData = sessionData['user'] as Map<String, dynamic>;
    final user = AuthUserModel.fromSupabaseAuth(userData);
    
    return AuthResponseModel(
      user: user,
      accessToken: sessionData['access_token'] as String,
      refreshToken: sessionData['refresh_token'] as String,
      expiresAt: sessionData['expires_at'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(
              (sessionData['expires_at'] as int) * 1000)
          : null,
    );
  }

  AuthResponse toDomain() {
    return AuthResponse(
      user: (user as AuthUserModel).toDomain(),
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
    );
  }
}