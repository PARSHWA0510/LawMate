import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user);
  Future<void> clearUser();
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> clearToken();
}

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;

  AuthLocalDataSourceImpl(this._prefs);

  @override
  Future<UserModel?> getUser() async {
    try {
      final userJson = _prefs.getString('user_data');
      if (userJson != null) {
        final userMap = json.decode(userJson) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      }
      return null;
    } catch (e) {
      throw const CacheException(message: 'Failed to get user from cache');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final userJson = json.encode(user.toJson());
      await _prefs.setString('user_data', userJson);
    } catch (e) {
      throw const CacheException(message: 'Failed to save user to cache');
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await _prefs.remove('user_data');
    } catch (e) {
      throw const CacheException(message: 'Failed to clear user from cache');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return _prefs.getString('user_token');
    } catch (e) {
      throw const CacheException(message: 'Failed to get token from cache');
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await _prefs.setString('user_token', token);
    } catch (e) {
      throw const CacheException(message: 'Failed to save token to cache');
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await _prefs.remove('user_token');
    } catch (e) {
      throw const CacheException(message: 'Failed to clear token from cache');
    }
  }
}
