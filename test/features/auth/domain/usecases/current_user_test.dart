import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_code_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late CurrentUser currentUser;
  late User user;

  setUpAll(() {
    mockAuthRepository = MockAuthRepository();
    currentUser = CurrentUser(authRepository: mockAuthRepository);
    user = User(id: '1', name: 'paras shakya', email: 'paras@gmail.com');
  });

  test(
      "Given [AuthRepository] when [currentUser] call succeeds then it should return [User]",
      () async {
    when(() => mockAuthRepository.currentUser())
        .thenAnswer((invocation) async => Right(user));

    final result = await currentUser(NoParams());

    expect(result, equals(Right<Failure, User>(user)));
  });

  test(
      "Given [AuthRepository] when [currentUser] call fails then it should return [Failure]",
      () async {
    final failure =
        Failure(message: "Failed to get current user from local storage");
    when(() => mockAuthRepository.currentUser())
        .thenAnswer((invocation) async => Left(failure));

    final result = await currentUser(NoParams());

    expect(result, equals(Left<Failure, User>(failure)));
  });
}
