import 'package:flutter/material.dart';

class ScalePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  ScalePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return page;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = 0.0;
            var end = 1.0;
            var curve = Curves.easeInOut;

            var scaleAnimation = Tween(begin: begin, end: end).animate(
              CurvedAnimation(parent: animation, curve: curve),
            );

            return ScaleTransition(scale: scaleAnimation, child: child);
          },
        );
}
