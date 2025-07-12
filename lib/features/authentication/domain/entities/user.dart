import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String phoneNumber;
  final String? profileImage;
  final DateTime createdAt;
  final bool isPhoneVerified;

  const User({
    required this.id,
    required this.username,
    required this.phoneNumber,
    this.profileImage,
    required this.createdAt,
    this.isPhoneVerified = false,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        phoneNumber,
        profileImage,
        createdAt,
        isPhoneVerified,
      ];
}