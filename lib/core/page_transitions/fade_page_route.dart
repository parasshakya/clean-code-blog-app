import 'package:flutter/material.dart';

class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  FadePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return page;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade the page in and out
            var opacity = Tween(begin: 0.0, end: 1.0).animate(animation);
            return FadeTransition(opacity: opacity, child: child);
          },
        );
}
