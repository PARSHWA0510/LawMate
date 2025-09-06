import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc({
    required ProfileRepository profileRepository,
  })  : _profileRepository = profileRepository,
        super(const ProfileInitial()) {
    on<ProfileLoadRequested>(_onProfileLoadRequested);
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
    on<ProfileImageUpdateRequested>(_onProfileImageUpdateRequested);
    on<ProfilePreferencesUpdateRequested>(_onProfilePreferencesUpdateRequested);
    on<ProfilePasswordChangeRequested>(_onProfilePasswordChangeRequested);
    on<ProfileDeleteRequested>(_onProfileDeleteRequested);
  }

  Future<void> _onProfileLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final result = await _profileRepository.getProfile();

    result.fold(
      (failure) => emit(ProfileError(message: _mapFailureToMessage(failure))),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  Future<void> _onProfileUpdateRequested(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    // Implement profile update logic
  }

  Future<void> _onProfileImageUpdateRequested(
    ProfileImageUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    // Implement profile image update logic
  }

  Future<void> _onProfilePreferencesUpdateRequested(
    ProfilePreferencesUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    // Implement preferences update logic
  }

  Future<void> _onProfilePasswordChangeRequested(
    ProfilePasswordChangeRequested event,
    Emitter<ProfileState> emit,
  ) async {
    // Implement password change logic
  }

  Future<void> _onProfileDeleteRequested(
    ProfileDeleteRequested event,
    Emitter<ProfileState> emit,
  ) async {
    // Implement account deletion logic
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure _:
        return failure.message;
      case NetworkFailure _:
        return failure.message;
      case ValidationFailure _:
        return failure.message;
      default:
        return 'An unexpected error occurred.';
    }
  }
}
