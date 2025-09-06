import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? profileImage;
  final String? phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final Map<String, dynamic> preferences;
  final List<String> interests;

  const ProfileEntity({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
    this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    required this.preferences,
    required this.interests,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        profileImage,
        phoneNumber,
        createdAt,
        updatedAt,
        isEmailVerified,
        isPhoneVerified,
        preferences,
        interests,
      ];
}
