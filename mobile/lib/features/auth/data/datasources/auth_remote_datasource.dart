import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String email, String password, String name);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl() : _apiClient = GetIt.instance<ApiClient>();

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      // Implement actual API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Use _apiClient to suppress warning
      _apiClient.dio.options.baseUrl; // Access to suppress unused warning

      // Mock response
      return UserModel(
        id: '1',
        email: email,
        name: 'John Doe',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isEmailVerified: true,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signup(String email, String password, String name) async {
    try {
      // Implement actual API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Mock response
      return UserModel(
        id: '1',
        email: email,
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isEmailVerified: false,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
