import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String? photoURL;
  final bool emailVerified;
  final DateTime? createdAt;
  final DateTime? lastSignInAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoURL,
    required this.emailVerified,
    this.createdAt,
    this.lastSignInAt,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    bool? emailVerified,
    DateTime? createdAt,
    DateTime? lastSignInAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoURL,
        emailVerified,
        createdAt,
        lastSignInAt,
      ];

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, displayName: $displayName, emailVerified: $emailVerified)';
  }
}