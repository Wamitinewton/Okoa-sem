import 'package:json_annotation/json_annotation.dart';
import 'package:okoa_sem/features/authentication/domain/entities/user.dart';

part 'auth_user_model.g.dart';

@JsonSerializable()
class AuthUserModel extends User {
  const AuthUserModel({
    required super.id,
    required super.username,
    required super.phoneNumber,
    super.profileImage,
    required super.createdAt,
    super.isPhoneVerified = false,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);

  factory AuthUserModel.fromSupabaseAuth(Map<String, dynamic> authData) {
    final userMetadata = authData['user_metadata'] ?? {};
    
    return AuthUserModel(
      id: authData['id'] as String,
      username: userMetadata['username'] as String? ?? '',
      phoneNumber: authData['phone'] as String? ?? '',
      profileImage: userMetadata['profile_image'] as String?,
      createdAt: DateTime.parse(authData['created_at'] as String),
      isPhoneVerified: authData['phone_confirmed_at'] != null,
    );
  }

  User toDomain() {
    return User(
      id: id,
      username: username,
      phoneNumber: phoneNumber,
      profileImage: profileImage,
      createdAt: createdAt,
      isPhoneVerified: isPhoneVerified,
    );
  }

  AuthUserModel copyWith({
    String? id,
    String? username,
    String? phoneNumber,
    String? profileImage,
    DateTime? createdAt,
    bool? isPhoneVerified,
  }) {
    return AuthUserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
    );
  }
}