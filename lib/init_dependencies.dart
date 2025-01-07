import 'package:clean_code_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_code_app/core/secrets/app_secrets.dart';
import 'package:clean_code_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:clean_code_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_code_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_code_app/features/auth/domain/usecases/current_user.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_login.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final dio = Dio(BaseOptions(
    baseUrl: AppSecrets.baseUrl,
    connectTimeout: const Duration(seconds: 10), // 10 seconds
    receiveTimeout: const Duration(seconds: 15),
    // 15 seconds
  ));

  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  final userBox = await Hive.openBox("user_box");

  //register dio
  serviceLocator.registerLazySingleton(() => dio);

//register hive box for user data
  serviceLocator.registerLazySingleton(() => userBox);

  //register core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  _initAuth();
}

void _initAuth() {
  //Register Data source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(dio: serviceLocator()))
    ..registerFactory<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(box: serviceLocator()))
    //Register Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(), localDataSource: serviceLocator()))

    //Register Usecases
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserLogin(authRepository: serviceLocator()))
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))

    //Register Bloc
    ..registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        appUserCubit: serviceLocator(),
        currentUser: serviceLocator()));
}
