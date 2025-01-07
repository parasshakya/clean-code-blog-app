import 'package:clean_code_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_code_app/core/common/entities/user.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/auth/domain/usecases/current_user.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_login.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final AppUserCubit _appUserCubit;
  final CurrentUser _currentUser;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthSignedUp>(_onAuthSignedUp);

    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

  _onAuthSignedUp(AuthSignedUp event, Emitter<AuthState> emit) async {
    emit(AuthLoadInProgress());
    final response = await _userSignUp(UserSignUpParams(
        email: event.email, name: event.name, password: event.password));

    response.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => _emitAuthSuccess(emit, user));
  }

  _onAuthLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoadInProgress());
    final response = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    response.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => _emitAuthSuccess(emit, user));
  }

  _onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final response = await _currentUser(NoParams());
    response.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => _emitAuthSuccess(emit, user));
  }

  _emitAuthSuccess(Emitter<AuthState> emit, User user) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
