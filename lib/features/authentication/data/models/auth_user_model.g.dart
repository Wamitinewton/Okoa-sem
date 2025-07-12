// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) =>
    AuthUserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profileImage: json['profileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$AuthUserModelToJson(AuthUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'profileImage': instance.profileImage,
      'createdAt': instance.createdAt.toIso8601String(),
      'isPhoneVerified': instance.isPhoneVerified,
    };
