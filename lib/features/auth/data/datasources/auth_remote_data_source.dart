import "package:clean_code_app/core/error/exceptions.dart";
import "package:clean_code_app/core/common/models/user_model.dart";
import "package:clean_code_app/core/success/success.dart";
import "package:dio/dio.dart";

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailAndPassword(
      {required String name, required String password, required String email});

  Future<UserModel> signInWithEmailAndPassword(
      {required String password, required String email});

  Future<Success> signOut(String userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String password, required String email}) async {
    try {
      final response = await dio
          .post("/auth/login", data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        final data = response.data["data"]["userData"] as Map<String, dynamic>;
        return UserModel.fromJson(data);
      } else {
        throw ServerException(message: "Failed to sign up");
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String name,
      required String password,
      required String email}) async {
    try {
      final response = await dio.post("/auth/signUp",
          data: {"username": name, "email": email, "password": password});
      if (response.statusCode == 200) {
        final data = response.data["data"] as Map<String, dynamic>;
        return UserModel.fromJson(data);
      } else {
        throw ServerException(message: "Failed to sign up");
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Success> signOut(String userId) async {
    try {
      await dio.post("/auth/logout", data: {"userId": userId});
      return Success();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
