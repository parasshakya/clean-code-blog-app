import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/success/success.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class SignOut implements UseCase<Success, SignOutParams> {
  final AuthRepository authRepository;

  SignOut({required this.authRepository});

  @override
  Future<Either<Failure, Success>> call(SignOutParams params) async {
    return await authRepository.signOut(params.userId);
  }
}

class SignOutParams {
  final String userId;

  SignOutParams({required this.userId});
}
