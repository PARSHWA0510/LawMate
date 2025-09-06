import 'package:equatable/equatable.dart';
import '../domain/entities/profile_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileUpdated extends ProfileState {
  final ProfileEntity profile;

  const ProfileUpdated({required this.profile});

  @override
  List<Object> get props => [profile];
}

class ProfileImageUpdated extends ProfileState {
  final String imagePath;

  const ProfileImageUpdated({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}
