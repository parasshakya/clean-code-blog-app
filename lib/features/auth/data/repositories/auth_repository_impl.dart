import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/error/exceptions.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/success/success.dart';
import 'package:clean_code_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:clean_code_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_code_app/core/models/user_model.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await remoteDataSource
        .signInWithEmailAndPassword(password: password, email: email));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async =>
        await remoteDataSource.signUpWithEmailAndPassword(
            name: name, password: password, email: email));
  }

  Future<Either<Failure, User>> _getUser(
      Future<UserModel> Function() fn) async {
    try {
      final user = await fn();
      await localDataSource.saveUserData(user);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await localDataSource.getCurrentUser();
      if (user == null) {
        return left(Failure(message: "User not logged in"));
      }
      return right(user);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> signOut(String userId) async {
    try {
      await remoteDataSource.signOut(userId);
      return right(Success());
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteUserDataFromLocalStorage() async {
    try {
      await localDataSource.deleteUserData();
      return right(Success());
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
