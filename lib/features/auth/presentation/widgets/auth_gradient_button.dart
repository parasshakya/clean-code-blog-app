import 'package:clean_code_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthGradientButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [AppPallete.gradient1, AppPallete.gradient2],
          )),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppPallete.transparentColor,
              shadowColor: AppPallete.transparentColor,
              fixedSize: const Size(395, 55)),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          )),
    );
  }
}
