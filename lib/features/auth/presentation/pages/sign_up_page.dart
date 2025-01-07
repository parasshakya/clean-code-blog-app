import 'package:clean_code_app/core/common/widgets/loader.dart';
import 'package:clean_code_app/core/theme/app_pallete.dart';
import 'package:clean_code_app/core/utils/show_snackbar.dart';
import 'package:clean_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_code_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:clean_code_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:clean_code_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:clean_code_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
            if (state is AuthSuccess) {
              Navigator.of(context)
                  .pushAndRemoveUntil(BlogPage.route(), (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoadInProgress) {
              return const Loader();
            }
            return Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up.",
                      style: TextStyle(fontSize: 50),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthField(
                      hintText: "Email",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintText: "Name",
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintText: "Password",
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthGradientButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignedUp(
                              email: emailController.text.trim(),
                              name: nameController.text.trim(),
                              password: passwordController.text.trim()));
                        }
                      },
                      buttonText: "Sign up",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(SignInPage.route());
                      },
                      child: RichText(
                          text: const TextSpan(
                              text: "Already have an account? ",
                              children: [
                            TextSpan(
                                text: "Sign in",
                                style: TextStyle(color: AppPallete.gradient2))
                          ])),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
