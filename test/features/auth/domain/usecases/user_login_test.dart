import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late UserLogin userLogin;
  late String email;
  late String password;
  late String name;

  setUpAll(() {
    mockAuthRepository = MockAuthRepository();
    userLogin = UserLogin(authRepository: mockAuthRepository);
    email = "paras@gmail.com";
    password = "paras123";
    name = "paras shakya";
  });

  test(
      "Given [AuthRepository] when [signInWithEmailAndPassword] call succeeds then return [User] ",
      () async {
    final user = User(id: '1', name: name, email: email);
    when(() => mockAuthRepository.signInWithEmailAndPassword(
        email: email,
        password: password)).thenAnswer((invocation) async => Right(user));

    final result =
        await userLogin(UserLoginParams(email: email, password: password));

    expect(result, equals(Right<Failure, User>(user)));
  });

  test(
      "Given [AuthRepository] when [signInWithEmailAndPassword] call fails then return [Failure] ",
      () async {
    final failure = Failure(message: "Failed to sign in");
    when(() => mockAuthRepository.signInWithEmailAndPassword(
        email: email,
        password: password)).thenAnswer((invocation) async => Left(failure));

    final result =
        await userLogin(UserLoginParams(email: email, password: password));

    expect(result, equals(Left<Failure, User>(failure)));
  });
}
