import 'package:clean_code_app/core/secrets/app_secrets.dart';
import 'package:clean_code_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_code_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final dio = Dio(BaseOptions(
    baseUrl: AppSecrets.baseUrl,
    connectTimeout: const Duration(seconds: 10), // 10 seconds
    receiveTimeout: const Duration(seconds: 15),
    // 15 seconds
  ));

  serviceLocator.registerLazySingleton(() => dio);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: serviceLocator()));

  serviceLocator
      .registerFactory(() => UserSignUp(authRepository: serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => AuthBloc(userSignUp: serviceLocator()));
}
