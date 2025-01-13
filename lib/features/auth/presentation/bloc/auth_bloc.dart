import 'package:clean_code_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/auth/domain/usecases/current_user.dart';
import 'package:clean_code_app/features/auth/domain/usecases/delete_user_data_from_local.dart';
import 'package:clean_code_app/features/auth/domain/usecases/sign_out.dart';
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
  final SignOut _signOut;
  final DeleteUserDataFromLocalStorage _deleteUserDataFromLocalStorage;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit,
      required DeleteUserDataFromLocalStorage deleteUserDataFromLocalStorage,
      required SignOut signOut})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _signOut = signOut,
        _deleteUserDataFromLocalStorage = deleteUserDataFromLocalStorage,
        super(AuthInitial()) {
    on<AuthSignedUp>(_onAuthSignedUp);

    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
    on<AuthLoggedOut>(_onAuthLoggedOut);
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

  _onAuthLoggedOut(AuthLoggedOut event, Emitter<AuthState> emit) async {
    final response = await _signOut(SignOutParams(userId: event.userId));
    response.fold((l) => emit(AuthFailure(message: l.message)), (r) {
      _appUserCubit.updateUser(null);
      _deleteUserDataFromLocalStorage(NoParams());
      emit(AuthInitial());
    });
  }

  _emitAuthSuccess(Emitter<AuthState> emit, User user) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
