import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late UserSignUp userSignUp;
  late String email;
  late String password;
  late String name;

  setUpAll(() {
    mockAuthRepository = MockAuthRepository();
    userSignUp = UserSignUp(authRepository: mockAuthRepository);
    email = "paras@gmail.com";
    password = "paras123";
    name = "paras shakya";
  });

  test(
      "Given [AuthRepository] when [signUpWithEmailAndPassword] is called then return [User] ",
      () async {
    final user = User(id: '1', name: name, email: email);

    when(() => mockAuthRepository.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password)).thenAnswer((invocation) async => Right(user));

    final result = await userSignUp(
        UserSignUpParams(email: email, name: name, password: password));

    expect(result, Right<Failure, User>(user));
    verify(() => mockAuthRepository.signUpWithEmailAndPassword(
        name: name, email: email, password: password)).called(1);
  });

  test(
      "Given [AuthRepository] when [signUpWithEmailAndPassword] fails then return [Failure] ",
      () async {
    final failure = Failure(message: "Failed to sign up");

    when(() => mockAuthRepository.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password)).thenAnswer((invocation) async => Left(failure));

    final result = await userSignUp(
        UserSignUpParams(email: email, name: name, password: password));

    expect(result, Left<Failure, User>(failure));
    verify(() => mockAuthRepository.signUpWithEmailAndPassword(
        name: name, email: email, password: password)).called(1);
  });
}
