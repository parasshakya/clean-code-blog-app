import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/success/success.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteUserDataFromLocalStorage implements UseCase<Success, NoParams> {
  final AuthRepository authRepository;

  DeleteUserDataFromLocalStorage({required this.authRepository});
  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    return await authRepository.deleteUserDataFromLocalStorage();
  }
}
