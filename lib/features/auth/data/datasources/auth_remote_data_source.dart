import "package:clean_code_app/core/error/exceptions.dart";
import "package:dio/dio.dart";

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailAndPassword(
      {required String name, required String password, required String email});

  Future<String> signInWithEmailAndPassword(
      {required String password, required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> signInWithEmailAndPassword(
      {required String password, required String email}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailAndPassword(
      {required String name,
      required String password,
      required String email}) async {
    try {
      final response = await dio.post("/auth/signup",
          data: {"username": name, "email": email, "password": password});
      if (response.statusCode == 200) {
        return response.data["data"]["_id"];
      } else {
        throw ServerException(message: "Failed to sign up");
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
