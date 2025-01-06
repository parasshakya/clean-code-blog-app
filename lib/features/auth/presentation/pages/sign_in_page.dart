import 'dart:js_interop';

import 'package:clean_code_app/core/theme/app_pallete.dart';
import 'package:clean_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_code_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:clean_code_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:clean_code_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignInPage());
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In.",
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
                hintText: "Password",
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              AuthGradientButton(
                onPressed: () {},
                buttonText: "Sign in",
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(SignUpPage.route());
                },
                child: RichText(
                    text: const TextSpan(
                        text: "Don't have an account? ",
                        children: [
                      TextSpan(
                          text: "Sign up",
                          style: TextStyle(color: AppPallete.gradient2))
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
