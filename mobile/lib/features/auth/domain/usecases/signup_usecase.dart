import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(SignupParams params) async {
    return await repository.signup(params.email, params.password, params.name);
  }
}

class SignupParams {
  final String email;
  final String password;
  final String name;

  SignupParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
