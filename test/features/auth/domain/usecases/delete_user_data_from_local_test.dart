import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/success/success.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_code_app/features/auth/domain/usecases/current_user.dart';
import 'package:clean_code_app/features/auth/domain/usecases/delete_user_data_from_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late DeleteUserDataFromLocalStorage deleteUserDataFromLocalStorage;

  setUpAll(() {
    mockAuthRepository = MockAuthRepository();
    deleteUserDataFromLocalStorage =
        DeleteUserDataFromLocalStorage(authRepository: mockAuthRepository);
  });

  test(
      "Given [AuthRepository] when [deleteUserDataFromLocalStorage] call succeeds then it should return [Success]",
      () async {
    when(() => mockAuthRepository.deleteUserDataFromLocalStorage())
        .thenAnswer((invocation) async => Right(Success()));

    final result = await deleteUserDataFromLocalStorage(NoParams());

    expect(result, equals(Right<Failure, Success>(Success())));
  });

  test(
      "Given [AuthRepository] when [deleteUserDataFromLocalStorage] call fails then it should return [Failure]",
      () async {
    final failure =
        Failure(message: "Failed to delete user data from local storage");
    when(() => mockAuthRepository.deleteUserDataFromLocalStorage())
        .thenAnswer((invocation) async => Left(failure));

    final result = await deleteUserDataFromLocalStorage(NoParams());

    expect(result, equals(Left<Failure, Success>(failure)));
  });
}
