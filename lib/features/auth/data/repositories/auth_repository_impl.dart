import 'package:clean_code_app/core/common/entities/user.dart';
import 'package:clean_code_app/core/error/exceptions.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:clean_code_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_code_app/core/common/models/user_model.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await remoteDataSource
        .signInWithEmailAndPassword(password: password, email: email));
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async =>
        await remoteDataSource.signUpWithEmailAndPassword(
            name: name, password: password, email: email));
  }

  Future<Either<Failure, UserModel>> _getUser(
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
}
