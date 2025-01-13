import 'package:clean_code_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:clean_code_app/core/theme/theme.dart';
import 'package:clean_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_code_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/add_new_blog/add_new_blog_bloc.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/blogs/blogs_bloc.dart';
import 'package:clean_code_app/features/blog/presentation/pages/blogs_page.dart';
import 'package:clean_code_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      BlocProvider(create: (_) => serviceLocator<AddNewBlogBloc>()),
      BlocProvider(create: (_) => serviceLocator<BlogDetailBloc>()),
      BlocProvider(create: (_) => serviceLocator<BlogsBloc>())
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemeMode,
        title: "Blog App",
        home: BlocBuilder<AppUserCubit, AppUserState>(
          builder: (context, state) {
            if (state is AppUserLoggedIn) {
              return const BlogsPage();
            }

            return const SignInPage();
          },
        ));
  }
}
