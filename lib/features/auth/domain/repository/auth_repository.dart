import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/common/entities/user.dart';
import 'package:clean_code_app/core/success/success.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name, required String email, required String password});

  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, Success>> signOut(String userId);

  Future<Either<Failure, Success>> deleteUserDataFromLocalStorage();

  Future<Either<Failure, User>> currentUser();
}
