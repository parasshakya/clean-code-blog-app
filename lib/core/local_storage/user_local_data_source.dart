import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/models/user_model.dart';
import 'package:hive/hive.dart';

abstract interface class UserLocalDataSource {
  Future<void> saveUserData(UserModel userModel);
  Future<void> saveAccessToken(String accessToken);
  Future<void> saveRefreshToken(String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();

  Future<User?> getCurrentUser();
  Future<void> deleteUserData();
  Future<void> deleteTokens();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box box;

  UserLocalDataSourceImpl({required this.box});

  final String _userKey = 'user_data';
  final String _accessTokenKey = "access_token";
  final String _refreshTokenKey = "refresh_token";

  @override
  Future<void> deleteUserData() async {
    try {
      await box.delete(_userKey); // Remove user data from Hive box
    } catch (e) {
      throw Exception("Failed to delete user data: $e");
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userData = box.get(_userKey);
      if (userData == null) {
        return null;
      }
      return UserModel.fromJson(Map<String, dynamic>.from(userData));
    } catch (e) {
      throw Exception("Failed to load user data: $e");
    }
  }

  @override
  Future<void> saveUserData(UserModel user) async {
    try {
      await box.put(_userKey, user.toJson()); // Save user data as a JSON map
    } catch (e) {
      throw Exception("Failed to save user data: $e");
    }
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    try {
      await box.put(
          _accessTokenKey, accessToken); // Save user data as a JSON map
    } catch (e) {
      throw Exception("Failed to save access token: $e");
    }
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await box.put(
          _refreshTokenKey, refreshToken); // Save user data as a JSON map
    } catch (e) {
      throw Exception("Failed to save refresh token: $e");
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      final accessToken = await box.get(_accessTokenKey);
      if (accessToken == null) {
        return null;
      }
      return accessToken;
    } catch (e) {
      throw Exception("Failed to get access token: $e");
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      final refreshToken = await box.get(_refreshTokenKey);
      if (refreshToken == null) {
        return null;
      }
      return refreshToken;
    } catch (e) {
      throw Exception("Failed to get refresh token: $e");
    }
  }

  @override
  Future<void> deleteTokens() async {
    try {
      await box.delete(_accessTokenKey);
      await box.delete(_refreshTokenKey);
    } catch (e) {
      throw Exception("Failed to delete tokens: $e");
    }
  }
}
