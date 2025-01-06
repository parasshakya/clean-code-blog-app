import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String name;
  final String password;

  UserSignUpParams(
      {required this.email, required this.name, required this.password});
}
