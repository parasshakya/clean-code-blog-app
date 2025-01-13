import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/success/success.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_code_app/features/auth/domain/usecases/sign_out.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late SignOut signOut;
  late User user;

  setUpAll(() {
    mockAuthRepository = MockAuthRepository();
    signOut = SignOut(authRepository: mockAuthRepository);
    user = User(id: '1', name: "Paras shakya", email: "paras@gmail.com");
  });

  test(
      "Given [AuthRepository] when [signOut] call succeeds then it should return [Success]",
      () async {
    when(() => mockAuthRepository.signOut(user.id))
        .thenAnswer((invocation) async => Right(Success()));

    final result = await signOut(SignOutParams(userId: user.id));

    expect(result, equals(Right<Failure, Success>(Success())));
  });

  test(
      "Given [AuthRepository] when [signOut] call fails then it should return [Failure]",
      () async {
    final failure = Failure(message: "Failed to sign out");
    when(() => mockAuthRepository.signOut(user.id))
        .thenAnswer((invocation) async => Left(failure));

    final result = await signOut(SignOutParams(userId: user.id));

    expect(result, equals(Left<Failure, Success>(failure)));
  });
}
