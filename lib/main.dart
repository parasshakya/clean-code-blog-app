import 'package:clean_code_app/core/secrets/app_secrets.dart';
import 'package:clean_code_app/core/theme/theme.dart';
import 'package:clean_code_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_code_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_code_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:clean_code_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final dio = Dio(BaseOptions(
    baseUrl: AppSecrets.baseUrl,
    connectTimeout: const Duration(seconds: 10), // 10 seconds
    receiveTimeout: const Duration(seconds: 15),
    // 15 seconds
  ));

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) => AuthBloc(
              userSignUp: UserSignUp(
                  authRepository: AuthRepositoryImpl(
                      remoteDataSource: AuthRemoteDataSourceImpl(dio: dio)))))
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemeMode,
        title: "Blog App",
        home: SignInPage());
  }
}
