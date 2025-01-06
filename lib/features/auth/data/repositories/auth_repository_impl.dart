import 'package:clean_code_app/core/error/exceptions.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_code_app/features/auth/data/models/user_model.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailAndPassword(
          name: name, password: password, email: email);

      return right(userId);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
