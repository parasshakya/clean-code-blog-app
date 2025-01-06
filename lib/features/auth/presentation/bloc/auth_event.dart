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
