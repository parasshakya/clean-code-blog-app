import 'package:clean_code_app/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

abstract interface class AuthLocalDataSource {
  Future<void> saveUserData(UserModel userModel);
  Future<UserModel?> getCurrentUser();
  Future<void> deleteUserData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box box;

  AuthLocalDataSourceImpl({required this.box});

  final String _userKey = 'user_data';

  @override
  Future<void> deleteUserData() async {
    try {
      await box.delete(_userKey); // Remove user data from Hive box
    } catch (e) {
      throw Exception("Failed to delete user data: $e");
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
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
  Future<void> saveUserData(UserModel userModel) async {
    try {
      await box.put(
          _userKey, userModel.toJson()); // Save user data as a JSON map
    } catch (e) {
      throw Exception("Failed to save user data: $e");
    }
  }
}
