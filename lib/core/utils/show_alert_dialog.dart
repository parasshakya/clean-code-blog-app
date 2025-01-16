import 'package:clean_code_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

void showLogoutDialog(
  BuildContext context, {
  void Function()? onConfirm,
  void Function()? onCancel,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout ?'),
        backgroundColor: AppPallete.backgroundColor,
        shadowColor: AppPallete.gradient2,
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: onCancel,
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: onConfirm,
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}
