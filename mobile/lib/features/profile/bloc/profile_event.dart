import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
}

class ProfileUpdateRequested extends ProfileEvent {
  final String name;
  final String? phoneNumber;
  final List<String> interests;

  const ProfileUpdateRequested({
    required this.name,
    this.phoneNumber,
    required this.interests,
  });

  @override
  List<Object> get props => [name, phoneNumber ?? '', interests];
}

class ProfileImageUpdateRequested extends ProfileEvent {
  final String imagePath;

  const ProfileImageUpdateRequested(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class ProfilePreferencesUpdateRequested extends ProfileEvent {
  final Map<String, dynamic> preferences;

  const ProfilePreferencesUpdateRequested(this.preferences);

  @override
  List<Object> get props => [preferences];
}

class ProfilePasswordChangeRequested extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  const ProfilePasswordChangeRequested({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [currentPassword, newPassword];
}

class ProfileDeleteRequested extends ProfileEvent {
  const ProfileDeleteRequested();
}
