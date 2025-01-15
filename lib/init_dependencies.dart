import 'package:clean_code_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:clean_code_app/core/interceptors/api_interceptor.dart';
import 'package:clean_code_app/core/local_storage/user_local_data_source.dart';
import 'package:clean_code_app/core/secrets/app_secrets.dart';
import 'package:clean_code_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_code_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_code_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_code_app/features/auth/domain/usecases/current_user.dart';
import 'package:clean_code_app/features/auth/domain/usecases/delete_user_data_from_local.dart';
import 'package:clean_code_app/features/auth/domain/usecases/sign_out.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_login.dart';
import 'package:clean_code_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_code_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:clean_code_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:clean_code_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_code_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:clean_code_app/features/blog/domain/usecases/get_blog_poster.dart';
import 'package:clean_code_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/add_new_blog/add_new_blog_bloc.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/blogs/blogs_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
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
  serviceLocator.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(box: serviceLocator()));
  dio.interceptors.add(ApiInterceptor(
      userLocalDataSource: serviceLocator(), dio: serviceLocator()));

  _initAuth();

  _initBlog();
}

void _initAuth() {
  //Register Data source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
        dio: serviceLocator(), userLocalDataSource: serviceLocator()))

    //Register Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(), localDataSource: serviceLocator()))

    //Register Usecases
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserLogin(authRepository: serviceLocator()))
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
    ..registerFactory(() => SignOut(authRepository: serviceLocator()))
    ..registerFactory(
        () => DeleteUserDataFromLocalStorage(authRepository: serviceLocator()))

    //Register Bloc
    ..registerLazySingleton(() => AuthBloc(
        signOut: serviceLocator(),
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        appUserCubit: serviceLocator(),
        currentUser: serviceLocator(),
        deleteUserDataFromLocalStorage: serviceLocator()));
}

void _initBlog() {
  //datasources
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(dio: serviceLocator()))

    //repositories
    ..registerFactory<BlogRepository>(
        () => BlogRepositoryImp(remoteDataSource: serviceLocator()))

    //usecases
    ..registerFactory<UploadBlog>(
        () => UploadBlog(blogRepository: serviceLocator()))
    ..registerFactory(() => GetAllBlogs(blogRepository: serviceLocator()))
    ..registerFactory(() => GetBlogPoster(blogRepository: serviceLocator()))

    //blocs
    ..registerLazySingleton<AddNewBlogBloc>(() => AddNewBlogBloc(
          uploadBlog: serviceLocator(),
        ))
    ..registerLazySingleton<BlogDetailBloc>(() => BlogDetailBloc(
          getBlogPoster: serviceLocator(),
        ))
    ..registerLazySingleton<BlogsBloc>(() => BlogsBloc(
          getAllBlogs: serviceLocator(),
        ));
}
