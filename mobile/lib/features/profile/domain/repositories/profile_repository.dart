import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity profile);
  Future<Either<Failure, void>> updateProfileImage(String imagePath);
  Future<Either<Failure, void>> updatePreferences(
      Map<String, dynamic> preferences);
  Future<Either<Failure, void>> updateInterests(List<String> interests);
  Future<Either<Failure, void>> deleteAccount();
  Future<Either<Failure, void>> changePassword(
      String currentPassword, String newPassword);
}
