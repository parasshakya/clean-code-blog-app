import 'package:clean_code_app/features/auth/domain/entities/user.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignedUp>((event, emit) async {
      emit(AuthLoadInProgress());
      final response = await _userSignUp(UserSignUpParams(
          email: event.email, name: event.name, password: event.password));

      response.fold((failure) => emit(AuthFailure(message: failure.message)),
          (user) => emit(AuthSuccess(user: user)));
    });
  }
}
