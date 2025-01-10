part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignedUp extends AuthEvent {
  final String email;
  final String name;
  final String password;

  AuthSignedUp(
      {required this.email, required this.name, required this.password});
}

final class AuthLoggedIn extends AuthEvent {
  final String email;
  final String password;

  AuthLoggedIn({required this.email, required this.password});
}

final class AuthLoggedOut extends AuthEvent {
  final String userId;

  AuthLoggedOut({required this.userId});
}

final class AuthIsUserLoggedIn extends AuthEvent {}
